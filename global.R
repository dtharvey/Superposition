# global.R file for superposition learning module

# load packages
library(shiny)
library(shinythemes)

# set colors
palette("Okabe-Ito")

# set common variables
x = seq(0, 4*pi, 0.01*pi)

# load data files and/or source scripts
squarewave = read.csv("data/squarewave.csv")
trianglewave = read.csv("data/trianglewave.csv")
sawtoothwave = read.csv("data/sawtoothwave.csv")
sq_fs = read.csv(file = "data/sq_fs.csv")
wave1a = sin(x)
wave1b = sin(x)
wave2a = sin(x)
wave2b = sin(x-pi)
wave3a = sin(x)
wave3b = sin(2*x)
old.par = par(mfrow = c(3, 3))
