library(TraMineR)
library(data.table)
library(tidyverse)
library(dplyr)
library(reshape2)

#S3659000

occ <- read_csv("~/Downloads/occmob97/occmob97.csv", col_names = T, na = c("-5","-4","-3"), progress = T)[,c(2:26)]

occ_num <- apply(X = matrix(c(1:nrow(occ))), MARGIN = 1, occ_seq)   %>% 
  t %>% 
  data.frame

occ_new <- cbind(occ_num,
                 mx = as.numeric(apply(occ_num, 1, max)))

occ_data <- select(occ_new[order(occ_new$mx),], -mx)

occ_new <- cbind(occ_new,
                 seqdef(occ_data) %>% seqST(norm = T))

colnames(occ_new) <- c(1997:1994,
                       1996,
                       1998,
                       2000,
                       2002,
                       2004,
                       2006,
                       2008,
                       2010,
                       2012,
                       2014,
                       'mx',
                       'Turbulence')

occ_data <- seqdef(occ_new[order(occ_new$mx,occ_new$Turbulence,decreasing = F),c(1:17)], cpal = c('#ffffe0','#ffe9b7','#ffd196','#ffb67f','#ff9b6f','#f98065','#ee665d','#e14d54','#cf3548','#bb1e37','#a40921','#8b0000'))

pdf('occ79_d.pdf',width=11,height=8.5,paper='special') 

seqdplot(occ_data, main = 'Occupational Mobility\nNLSY97 Sample')

dev.off()
