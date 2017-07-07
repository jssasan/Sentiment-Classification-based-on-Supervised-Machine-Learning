
#### creating a function for generating document-term-frequency dataset 

#### this will return a df which is essentially a feature set which will be fed into the algorithms ###

###  the function below takes following inputs and returns a dtm
## temp_corpus is generated from corpus_transformation_custom 
## ctrl_list will be n-gram specific
## sparsity between 0 and 1 : close to 0.99 


fetures_df_from_corpus<- function(corpus, ctrl_list, sparsity){
  
  tdm_temp<- TermDocumentMatrix(corpus, control= ctrl_list)
  dtm_temp <- as.DocumentTermMatrix(tdm_temp)
  dtm_temp<- removeSparseTerms(dtm_temp, sparsity)  ## this factor can be varied
  ## frequency of each term 
  # temp<- findFreqTerms(dtm_sparse_temp, lowfreq = 16)  ## all the terms has a frequency of atleast 16, 
  # summary(temp)
  dtm_temp_df<- as.data.frame(as.matrix(dtm_temp))
  row.names(dtm_temp_df)<- NULL
  rm(tdm_temp, dtm_temp) ## deleting unused df
  
  return(dtm_temp_df)
  
  
  # temp<- findFreqTerms(dtm_temp_df, lowfreq = 16)  ## all the terms has a frequency of atleast 16, 
  
  ## temp_corpus is generated from corpus_transformation_custom 
  ## ctrl_list will be n-gram specific
  ## sparsity between 0 and 1 : close to 0.99 
  
}



## testing the above function
temp_feature_df<- fetures_df_from_corpus(corpus = temp_corpus, ctrl_list = ctrl_list_ugbgtg, sparsity = 0.99999)
## temp_corpus is generated from corpus_transformation_custom function above
## ctrl_list will be n-gram specific

dim(temp_feature_df)


## running individual algos: create container and then use it 
container.data<- create_container(matrix =dtm_temp_df,  labels = df_imp_firs300[,2], trainSize = 1:210,
                                  testSize = 211:300,virgin = F)

cv.MX_train<- cross_validate_prf(container.data, nfold = 2, seed= 199, algorithm = "MAXENT")

############  OR ############

## running papa algorithms runner which will do everything by itself
dream<- cv_algo_runner(feature_df = temp_feature_df, rating_df = df_imp_last300, feature_vector = c(1:1345),seed = 192,nfold = 4)
dream



################## A wholesome example #########################
org_df_temp <-  data.frame(Content= c("I love this product! I would give it a 5 star. It has a great screen and nice touch!!!!", 
                                      "This is the worst product ever purchased, I wouldnt recommend this to anyone. Don't buy its a scam",
                                      "This is the best thing I hv ever purchased, cant complaint about it!!!!",
                                      "lovely phone! thanks google",
                                      "terrible service, however good touch screen",
                                      "all the features are great except the price",
                                      "why not buy a cheap phone with decent features",
                                      "I love this product! I would give it a 5 star. It has a great screen and nice touch!!!!", 
                                      "This is the worst product ever purchased, I wouldnt recommend this to anyone. Don't buy its a scam",
                                      "This is the best thing I hv ever purchased, cant complaint about it!!!!",
                                      "lovely phone! thanks google",
                                      "terrible service, however good touch screen",
                                      "all the features are great except the price",
                                      "why not buy a cheap phone with decent features",
                                      "I love this product! I would give it a 5 star. It has a great screen and nice touch!!!!", 
                                      "This is the worst product ever purchased, I wouldnt recommend this to anyone. Don't buy its a scam",
                                      "This is the best thing I hv ever purchased, cant complaint about it!!!!",
                                      "lovely phone! thanks google",
                                      "terrible service, however good touch screen",
                                      "all the features are great except the price",
                                      "why not buy a cheap phone with decent features"),
                           rating= as.factor(c(4,1,4,4,1,4,4,4,1,4,4,1,4,4,4,1,4,4,1,4,4)), stringsAsFactors = F)

str(org_df_temp)


temp_corpus_1 <- corpus_transformation_custom(org_df_temp, removeStopWords = TRUE)
temp_corpus_1[[5]]$content   ## perfect ouput
temp_corpus_1

temp_feature_df_1<- fetures_df_from_corpus(corpus = temp_corpus_1, ctrl_list = ctrl_list_ugbgtg, sparsity = 0.99999)
colnames(temp_feature_df_1)

dream_1<- cv_algo_runner(feature_df = temp_feature_df_1, rating_df = org_df_temp, feature_vector = c(1:ncol(temp_feature_df_1)),seed = 192,nfold = 4)
dream_1


