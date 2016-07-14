makeFeatures <- function(eegTp, eegNTp, left_border, sRate, times_seq, decimation_window)
{
  N0 <- dim(eegNTp)[3]
  N1 <- dim(eegTp)[3]
  
  nChannels <- dim(eegTp)[2]
  t <- dim(eegTp)[1]
  
  beg_time <- left_border / 1000
  
  times_beg <- times_seq/1000;
  times_end <- times_beg + decimation_window/1000;
  ts_beg <- round((times_beg - beg_time) * sRate);
  ts_end <- round((times_end - beg_time) * sRate);
  
  eegTfilt <- eegTp;
  eegNTfilt <- eegNTp;

  X0 <- x <- matrix(nrow = N0, ncol = nChannels*length(ts_beg))
  X1 <- x <- matrix(nrow = N1, ncol = nChannels*length(ts_beg))
  
  for (i in 1:N1) 
  {
    x <- matrix(nrow = length(ts_beg), ncol = nChannels)
    for (t in 1:length(ts_beg))
    {
      x[t,] <- colMeans( eegTfilt[ts_beg[t]:ts_end[t], , i] )
    }
    X1[i,] <- as.vector(x)
  }
  
  for (i in 1:N0) 
  {
    x <- matrix(nrow = length(ts_beg), ncol = nChannels)
    for (t in 1:length(ts_beg))
    {
      x[t,] <- colMeans( eegNTfilt[ts_beg[t]:ts_end[t], , i] )
    }
    X0[i,] <- as.vector(x)
  }
  
l <- list(X0 = X0, X1 = X1)

l
 
}