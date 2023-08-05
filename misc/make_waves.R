# file: make_waves

# code to generate set of 15 sine waves to make square wave
# saving file as squarewave.csv

x = seq(0,4*pi,0.01*pi) # values along x axis
y = seq(1,29,2) # equivalent to 2k-1
y_square = matrix(data = NA, nrow = 401, ncol = 15)
for (i in 1:15){
  y_square[,i] = (4/pi) * (sin(y[i] * x)/y[i])
}
write.csv(y_square, file = "squarewave.csv",row.names = FALSE)

# code to test data in squarewave.csv; uncomment to run

# squarewave = read.csv("squarewave.csv")
# x = seq(0,4*pi,0.01 * pi)
# number_cols = 15
# if (number_cols == 1){
#   ysum = squarewave[,1]
# } else {
#   ysum = apply(squarewave[,1:number_cols], MARGIN = 1, FUN = sum)
# }
# plot(x = x, y = ysum, type = "l", lty = 1, lwd = 3, col = 8)
# lines(x = x, y = sign(sin(x)), lwd = 3, lty = 3, col = 6)
# grid()
# for (i in 1:number_cols){
#   lines(x = x, y = squarewave[,i], lty = 2, col = 1)
# }

# code to generate set of 15 sine waves to make triangular wave
# saving file as trianglewave.csv

x = seq(0,4*pi,0.01*pi)
y = seq(1,29,2)
y_triangle = matrix(data = NA, nrow = 401, ncol = 15)
for (i in 1:15){
  y_triangle[,i] = (-8/pi^2) * (-1)^i * 1/(y[i]^2) * sin(y[i]*x)
}
write.csv(y_triangle, file = "trianglewave.csv",row.names = FALSE)

# code to test data in trianglewave.csv; uncomment to run

# trianglewave = read.csv("trianglewave.csv")
# x = seq(0,4*pi,0.01 * pi)
# number_cols = 15
# if (number_cols == 1){
#   ysum = trianglewave[,1]
# } else {
#   ysum = apply(trianglewave[,1:number_cols], MARGIN = 1, FUN = sum)
# }
# plot(x = x, y = ysum, type = "l", lty = 1, lwd = 3, col = 8)
# lines(x = x, 
#       y = 4*1/(2*pi) * abs((x-2*pi/4)%%(2*pi) - 2*pi/2) - 1, 
#       lwd = 3, lty = 3, col = 6)
# grid()
# for (i in 1:number_cols){
#   lines(x = x, y = trianglewave[,i], lty = 2, col = 1)
# }

# code to generate set of 15 sine waves to make sawtooth wave
# saving file as sawtoothwave.csv

x = seq(0,4*pi,0.01*pi)
y = seq(1,15,1)
y_sawtooth = matrix(data = NA, nrow = 401, ncol = 15)
for (i in 1:15){
  y_sawtooth[,i] = (-2/pi) * (-1)^i * 1/i * sin(i*x)
}
ysum = apply(y_sawtooth[,1:15], MARGIN = 1, FUN = sum)
plot(x = x, y = ysum, type = "l")
write.csv(y_sawtooth, file = "sawtoothwave.csv",row.names = FALSE)

# code to test data in sawtoothwave.csv; uncomment to run

# sawtoothwave = read.csv("sawtoothwave.csv")
# x = seq(0,4*pi,0.01 * pi)
# number_cols = 15
# if (number_cols == 1){
#   ysum = sawtoothwave[,1]
# } else {
#   ysum = apply(sawtoothwave[,1:number_cols], MARGIN = 1, FUN = sum)
# }
# plot(x = x, y = ysum, type = "l", lty = 1, lwd = 3, col = 8)
# lines(x = c(0,pi,pi,pi,pi,3*pi,3*pi,3*pi,3*pi,4*pi), 
#       y = c(0,1,1,-1,-1,1,1,-1,-1, 0), lty = 1)
# grid()
# for (i in 1:number_cols){
#   lines(x = x, y = sawtoothwave[,i], lty = 2, col = 1)
# }
