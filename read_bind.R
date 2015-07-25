#function is used to read multiple files  from a folderand bind the resulting data using rbind
read_bind <- function(path, file, name=FALSE) {
  data <- data.frame()
  
  for (folder in c('test', 'train')) {
    filename <- sprintf('%s/%s/%s_%s.txt', path, folder, file, folder)
    data <- rbind(data, read.table(filename))
  }
  
  if (name != FALSE) {
    colnames(data) <- name
  }
  
  data
}