args <- commandArgs(trailingOnly = F)
myargument <- args[length(args)]
myargument <- sub("-","",myargument)
myargument <- as.numeric(myargument)
setwd("/zhome/6e/9/133731/Desktop/Thesis/Thesis/Code")
source(paste(getwd(), "/Coefficient_optimization/neldermead_optimization/Single_step_predictions/meta_optim.r", sep = ""))
load("Coefficient_optimization/neldermead_optimization/Single_step_predictions/ARIMA/orders.rdata")
s2 <-  read.csv("../Data/Training_data/s2_training.txt", header = TRUE, sep = "\t")$Value
s2_wwIndex <- read.csv("../Data/Training_data/s2_WW_training.txt", header = TRUE, sep = "\t")$Flag

ts <- s2
wwIndex <- s2_wwIndex

order <- as.vector(orders[myargument,], mode = "numeric")
print(order)

start_time <- Sys.time()
results <- meta_optim(order, External_Regressor = FALSE)
end_time <- Sys.time()
results$Time <- end_time -  start_time  


name <- paste("CO_ARIMA_S1_c(", order[1], ", ", order[2], ", ", order[3], ")", sep = "")
assign(name, results)
filename <- paste("Coefficient_optimization/neldermead_optimization/Single_step_predictions/ARIMA/S2/Lists/", name, ".rdata",sep = "")
save(results, file = filename)

