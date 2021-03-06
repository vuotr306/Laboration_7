visualize_airport_delays<-function(){
  # def: A delay is the arr_delay and the airport that accounts for the delay is the destination airport. 
  airports <- nycflights13::airports
  flights <- nycflights13::flights
  
  flights_r<-dplyr::select(flights,dep_delay,flight,dest)
  airports_r<-dplyr::select(airports,faa,lat,lon)
  # rm(airports, flights)
  airports_r<-dplyr::rename(airports_r, dest=faa)
  
  Db<-dplyr::left_join( flights_r,airports_r, "dest")
  rm(airports_r, flights_r)
  Db<-dplyr::select(Db,-(2))
  
  reset_early_arrivals <- function(x) {
    x[x<0]<-0
    return(x)
  }
  
  Db<-dplyr::mutate(Db,newDelay=reset_early_arrivals(dep_delay))
  Db<-dplyr::select(Db,-dep_delay)
  
  # avgDelays <- Db %>% group_by(dest) %>% dplyr::summarise(avg=mean(newDelay, na.rm = TRUE))
  avgDelays <- dplyr::summarise(dplyr::group_by(Db, dest),  avg=mean(newDelay, na.rm = TRUE))
  
  Final <- dplyr::left_join(avgDelays, Db, "dest")
  Final <- dplyr::select(Final, -c(1,5))
  Final <- dplyr::distinct(Final)
  Final<-as.data.frame(Final)
  
  p1<-ggplot2::ggplot(data=Final) + ggplot2::aes(x=lon,y=lat,size=avg) +
    ggplot2::scale_size_area(max_size = 10)+ ggplot2::geom_point(shape=21,col="red")
  plot(p1)
  
}

