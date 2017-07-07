
if(require("NLP")==FALSE) install.packages("NLP", repos="http://cran.rstudio.com/")
if(require("tm")==FALSE) install.packages("tm", repos="http://cran.rstudio.com/")
if(require("RWeka")==FALSE) install.packages("RWeka", repos="http://cran.rstudio.com/")
if(require("RTextTools")==FALSE) install.packages("RTextTools", repos="http://cran.rstudio.com/")
if(require("caret")==FALSE) install.packages("caret", repos="http://cran.rstudio.com/")
if(require("openNLP")==FALSE) install.packages("openNLP", repos="http://cran.rstudio.com/")
if(require("stringi")==FALSE) install.packages("stringi", repos="http://cran.rstudio.com/")
if(require("stringr")==FALSE) install.packages("stringr", repos="http://cran.rstudio.com/")
if(require("gsubfn")==FALSE) install.packages("gsubfn", repos="http://cran.rstudio.com/")
if(require("plyr")==FALSE) install.packages("plyr", repos="http://cran.rstudio.com/")
if(require("openNLPmodels.en")==FALSE) install.packages("openNLPmodels.en",
                                                        repos = "http://datacube.wu.ac.at/",
                                                        type = "source")
install.packages("SnowballC", repos="http://cran.rstudio.com/")



require(tm)
require(RTextTools)
require(NLP)
require(openNLP)
require(openNLPmodels.en)
require(stringr)
require(gsubfn)
require(plyr)
require(stringi)
require(RWeka)
require(SnowballC)
require(e1071)

## below two commands has been used in the AWS unix

setwd("/home/rstudio/Attempt_4_all_algo")

load("Allset_BeforeBaseline_2k.RData")


## removing unncessary datasets 

rm(list = ls(pattern = "^tmp"))

rm(list = ls(pattern = "^df_imp_4k_f"))
rm(list = ls(pattern = "^df_imp_6k_f"))
rm(list = ls(pattern = "^df_imp_8k_f"))
rm(list = ls(pattern = "^df_imp_10k_f"))
rm(list = ls(pattern = "^df_imp_20k_f"))

df_imp_4k_f
df_imp_4k_f
df_imp_8k_f
df_imp_10k_f
df_imp_20k_f


abcd <- 2
abc <- 4
ab <- 3

rm(list = ls(pattern = "^ab"))


getwd()
  
