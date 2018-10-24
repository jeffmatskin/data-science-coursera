library(rhdf5)

get_exchanges <- function(files){
  pos <- regexpr('_', files)[1:length(files)]
  exchanges <- substr(files, 1, pos-1)
}

get_currencies <- function(files){
  posns <- gregexpr('_', files)
  curr1 <- vector(mode = "integer", length = length(files))
  #curr2 <- vector(mode = "integer", length = length(files))
  for (i in seq_along(posns)){
    curr1[i] <- substr(files[i],posns[[i]][1]+1, posns[[i]][2]-1)
    #removed bc all vs USD
    #curr2[i] <- substr(files[i],posns[[i]][2]+1, posns[[i]][3]-1)
  }
  curr1
}

files <- list.files("Minute", full.names=TRUE)
currencies <- get_currencies(files)
exchanges <- get_exchanges(files)
headers<- lapply(files[1], h5ls)#assuming same for all files
data <- lapply(h5read, files)

