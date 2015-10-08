library(ggplot2)
library(nycflights13)
library(dplyr)

visualize_airport_delays<-function(){
  # def: A delay is the arr_delay and the airport that accounts for the delay is the destination airport. 
  data(airports)
  data(flights) 
  
  flights_r<-select(flights,dep_delay,flight,dest)
  airports_r<-select(airports,faa,lat,lon)
  rm(airports, flights)
  airports_r<-rename(airports_r,dest=faa)
  
  Db<-left_join( flights_r,airports_r, "dest")
  rm(airports_r, flights_r)
  Db<-select(Db,-(2))
  
  f <- function(x) {
    x[x<0]<-0
    return(x)
  }
  
  Db<-mutate(Db,newDelay=f(dep_delay))
  Db<-select(Db,-dep_delay)
  
  avgDelays <- Db %>% group_by(dest) %>% summarise(avg=mean(newDelay, na.rm = TRUE))
  
  Final <- left_join(avgDelays, Db, "dest")
  Final <- select(Final, -c(1,5))
  Final <- distinct(Final)
  Final<-as.data.frame(Final)
  
  p1<-ggplot2::ggplot(data=Final) + ggplot2::aes(x=lon,y=lat,size=avg) +
    scale_size_area(max_size = 10)+ ggplot2::geom_point(shape=21,col="red")
  plot(p1)
  
}

