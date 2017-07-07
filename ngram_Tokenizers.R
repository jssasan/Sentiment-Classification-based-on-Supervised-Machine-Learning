
## creating n-gram features


#######################################################################################################################################
###########################  creating n-grams ###########################

##unigram

UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))


ctrl_list_ug<-  list(
  wordLengths=c(4, 15),
  ##bounds = list(global = c(5,Inf)),
  weighting = function(x) weightTfIdf(x, normalize =FALSE), 
  tokenize=UnigramTokenizer
)

### its an example
tdm_temp<- TermDocumentMatrix(temp_corpus, control= ctrl_list_ug)
# inspect(tdm_temp[,1])
tdm_temp_matrix<- as.matrix(tdm_temp)
tdm_temp_matrix

## creating DTM by taking a transponse
dtm_temp_matrix<- t(tdm_temp_matrix)
dim(dtm_temp_matrix)
dtm_temp_matrix
dtm_temp_matrix[,1:10]

### fitting the models

### Naive Bayes

nb_classifier<- naiveBayes(dtm_temp_matrix[1:11,], as.factor(df_imp_firs300[1:11,2]))
nb_classifier

rm(predicted)
## testing the validity, accuracy of the predictions
predicted<- predict(nb_classifier, dtm_temp_matrix[12:nrow(dtm_temp_matrix),])
predicted

## confusion matrix  : simply awesome
con.matrix<- table(df_imp_firs300[12:nrow(dtm_temp_matrix),2], predicted)
con.matrix
rm(con.matrix)
## finding recall accuracy
recall_accuracy(dtm_temp_matrix[12:nrow(dtm_temp_matrix),2],predicted)   ## something is terribly wrong with this statement


confusionMatrix(df_imp_firs300[12:nrow(dtm_temp_matrix),2], predicted, positive = "4") ## 0.2837    really bad


## bigram

BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))

ctrl_list_bg<-  list(
  wordLengths=c(4, 15),
  ##bounds = list(global = c(5,Inf)),
  weighting = function(x) weightTfIdf(x, normalize =FALSE), 
  tokenize=BigramTokenizer
)


tdm_temp<- TermDocumentMatrix(temp_corpus, control= ctrl_list_bg)
tdm_temp_matrix<- as.matrix(tdm_temp)
tdm_temp_matrix



## trigram

TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

ctrl_list_tg<-  list(
  wordLengths=c(4, 15),
  ##bounds = list(global = c(5,Inf)),
  weighting = function(x) weightTfIdf(x, normalize =FALSE), 
  tokenize=TrigramTokenizer
)


tdm_temp<- TermDocumentMatrix(temp_corpus, control= ctrl_list_tg)
tdm_temp_matrix<- as.matrix(tdm_temp)
tdm_temp_matrix



## unigram + bigram

ugbgTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 2))

ctrl_list_ugbg<-  list(
  wordLengths=c(4, 15),
  ##bounds = list(global = c(5,Inf)),
  weighting = function(x) weightTfIdf(x, normalize =FALSE), 
  tokenize=ugbgTokenizer
)


## unigram + bigram + trigram

ugbgtgTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 3))

ctrl_list_ugbgtg<-  list(
  wordLengths=c(4, 15),
  ##bounds = list(global = c(5,Inf)),
  weighting = function(x) weightTfIdf(x, normalize =FALSE), 
  tokenize=ugbgtgTokenizer
)



























