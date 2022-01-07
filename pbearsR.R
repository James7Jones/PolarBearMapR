
##Load packages needed
library(tidyverse)
library(gganimate)
library(gghighlight)
library(ggthemes)
library(gifski)
library(ggmap)

##Import data
polarBear_serumUreaCreatinine_beaufortChukchi_rode <- read_csv("C:/Users/james.jones/Desktop/polarBear_serumUreaCreatinine_beaufortChukchi_rode.csv", 
                                                               col_types = cols(`Capture Date` = col_date(format = "%d/%m/%Y"), 
                                                                                YearCaptured = col_integer()))
View(polarBear_serumUreaCreatinine_beaufortChukchi_rode)


##name data and fields
pbears <- polarBear_serumUreaCreatinine_beaufortChukchi_rode
names(pbears)[2] <- "CapDate"
names(pbears)[3] <- "CapYear"
names(pbears)[10] <- "lat1"
names(pbears)[11] <- "long1"

##alt map
##mapview(pbears,xcol="lat1",ycol="long1",crs=4269,grid=FALSE)

##create static map
bearmap2<-qmplot(long1, lat1, data = pbears, colour = I('red'), size = I(3), darken = .3,source="stamen", maptype= "watercolor")+
  labs(title="Polar Bear Migration: Location of Polar Bear Sightings by Year. 1983-2017",subtitle = "Year: {frame_time}",caption = "Source: USGS Alaska Science Center") 

bearmap2

##create animation
graph1.animation = bearmap2 +
  transition_time(CapYear) +
  labs(subtitle = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.1)

##run animation
animate(graph1.animation, height = 500, width = 800, fps = 30, duration = 24,
        end_pause = 60, res = 100)
