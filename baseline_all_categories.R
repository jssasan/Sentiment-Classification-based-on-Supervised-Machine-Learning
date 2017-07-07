
## creating a baseline  : based on unigrams 

load(".RData")



###########  Unigram features BASELINE #########




baseline_PRF_accuracy_UNIGRAM <- function(original_df, sparsity, category_name){
  
  
## original_df comes from datasets_final_all_categories.R  
  
## corpus_transformation_custom    :   this comes from corpus_transformation_custom script
## fetures_df_from_corpus          :   this comes from ngram_Tokenizers.R script
## ctrl_list_ug                    :   this comes from ngram_Tokenizers.R script


df_imp_firs300  <- original_df
sparsity_var <- sparsity

corpus_f300 <- corpus_transformation_custom(df_imp_firs300, doremoveStopWords = TRUE, doStemming = TRUE, doremoveNumbers = TRUE)


###########  unigram    #########

ug_features_f300<- fetures_df_from_corpus(corpus = corpus_f300, ctrl_list = ctrl_list_ug, sparsity = sparsity_var)
ug_feature_size <- dim(ug_features_f300)[2]
## running papa runner again on ngram features
algo_runner_unigram_f300<- cv_algo_runner(feature_df = ug_features_f300, rating_df = df_imp_firs300, feature_vector = c(1:ug_feature_size),seed = 400,nfold = 10)
str(algo_runner_unigram_f300)
dim(algo_runner_unigram_f300)
head(algo_runner_unigram_f300)

## run this after running Part-1 
temp_colnames<- colnames(algo_runner_negpos_f300)


PRF_accuracy_mean_scores <- c("cv_NaiveBayes_train.meanAccuracy", "cv_NaiveBayes_train.meanPrecision",  "cv_NaiveBayes_train.meanRecall", "cv_NaiveBayes_train.meanFscore",
                              "cv_MX_train.meanAccuracy", "cv_MX_train.meanPrecision",  "cv_MX_train.meanRecall", "cv_MX_train.meanFscore",
                              "cv_SVM_train.meanAccuracy", "cv_SVM_train.meanPrecision",  "cv_SVM_train.meanRecall", "cv_SVM_train.meanFscore",
                              "cv_BG_train.meanAccuracy", "cv_BG_train.meanPrecision",  "cv_BG_train.meanRecall", "cv_BG_train.meanFscore",
                              "cv_TREE_train.meanAccuracy", "cv_TREE_train.meanPrecision",  "cv_TREE_train.meanRecall", "cv_TREE_train.meanFscore",
                              "cv_RF_train.meanAccuracy", "cv_RF_train.meanPrecision",  "cv_RF_train.meanRecall", "cv_RF_train.meanFscore",
                              "cv_NNET_train.meanAccuracy", "cv_NNET_train.meanPrecision",  "cv_NNET_train.meanRecall", "cv_NNET_train.meanFscore",
                              "cv_SLDA_train.meanAccuracy", "cv_SLDA_train.meanPrecision",  "cv_SLDA_train.meanRecall", "cv_SLDA_train.meanFscore",
                              "cv_BOOSTING_train.meanAccuracy", "cv_BOOSTING_train.meanPrecision",  "cv_BOOSTING_train.meanRecall", "cv_BOOSTING_train.meanFscore"
                              
                              )

## extractin MEAN PRF-Accuracy Scores only
algo_runner_unigram_f300<-  algo_runner_unigram_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_unigram_f300 <- data.frame( t(algo_runner_unigram_f300))
colnames(algo_runner_unigram_f300) <- c("score")  ## renaming the only column of df



dim(df_imp_2k_f[df_imp_2k_f$rating==1,])


score_name<- row.names(algo_runner_unigram_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_unigram_f300)  <- NULL
algo_runner_unigram_f300$score_name <- score_name
algo_runner_unigram_f300 <- algo_runner_unigram_f300[c("score_name", "score" )] ## reordering the columns


colnames(algo_runner_unigram_f300) <- c("Performance_Metric", "Baseline_SCore")

filename <-paste("Baseline_PRF_accuracy_mean_", category_name, sep = "")

save(algo_runner_unigram_f300, file = paste(filename, ".Rda", sep = ""))

write.csv(algo_runner_unigram_f300, file = paste(filename, ".csv", sep = ""))

return(algo_runner_unigram_f300)


}


save.image()
save.image(file = "Allset_BeforeBaseline_2k.RData")  ## till this part I have created results aka PRFA for numerical features only for all categories


#########   Very Important   ########
## OLD comment: I ran this baseline individually on different AWS instances, did make changes in the function call on the fly : will document it later here
## NEW Comment : Aug-26 - 1. I am creating baseline with sparsity of 0.99 which was 0.999 in Attempt_3_clean when ran on multiple AWS instances.
##                      2. I have put everything in sink to capture the outputs as below



sink("baseline_PRFA_unigram_2k_all_categories.txt")

baseline_PRFA_UNIGRAM_2k_mob <- baseline_PRF_accuracy_UNIGRAM(original_df = df_imp_2k_f_mob_org,
                                                              sparsity = 0.99,
                                                              category_name = "mob_2k")

baseline_PRFA_UNIGRAM_2k_cam <- baseline_PRF_accuracy_UNIGRAM(original_df = df_imp_2k_f_cam_org,
                                                              sparsity = 0.99,
                                                              category_name = "cam_2k")

baseline_PRFA_UNIGRAM_2k_tab <- baseline_PRF_accuracy_UNIGRAM(original_df = df_imp_2k_f_tab_org,
                                                              sparsity = 0.99,
                                                              category_name = "tab_2k")

baseline_PRFA_UNIGRAM_2k_tv <- baseline_PRF_accuracy_UNIGRAM(original_df = df_imp_2k_f_tv_org,
                                                              sparsity = 0.99,
                                                              category_name = "tv_2k")

baseline_PRFA_UNIGRAM_2k_vs <- baseline_PRF_accuracy_UNIGRAM(original_df = df_imp_2k_f_vs_org,
                                                              sparsity = 0.99,
                                                              category_name = "vs_2k")

baseline_PRFA_UNIGRAM_2k_lap <- baseline_PRF_accuracy_UNIGRAM(original_df = df_imp_2k_f_lap_org,
                                                              sparsity = 0.99,
                                                              category_name = "lap_2k")

save.image()

sink()




save.image(file = "TillBaseline.RData")



#######################################################################################################################
####    Below are just reference code chunks I used for creating other ngram based functions   #####
#######################################################################################################################
    

# corpus_f300[[1]]$content  ## checking
# head(ngram_features_f300)  ## checking
# dim(ngram_features_f300)  ## [1]  300 2649


###########  Unigram  + Bigram    #########

ugbg_features_f300<- fetures_df_from_corpus(corpus = corpus_f300, ctrl_list = ctrl_list_ugbg, sparsity = 0.99999)
ugbg_feature_size <- dim(ugbg_features_f300)[2]
## running papa runner again on ngram features
algo_runner_ugbg_f300<- cv_algo_runner(feature_df = ugbg_features_f300, rating_df = df_imp_firs300, feature_vector = c(1:ugbg_feature_size),seed = 300,nfold = 2)
str(algo_runner_ugbg_f300)
dim(algo_runner_ugbg_f300)
head(algo_runner_ugbg_f300)

## extractin MEAN PRF-Accuracy Scores only
algo_runner_ugbg_f300<-  algo_runner_ugbg_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_ugbg_f300 <- data.frame( t(algo_runner_ugbg_f300))
colnames(algo_runner_ugbg_f300) <- c("score")  ## renaming the only column of df

score_name<- row.names(algo_runner_ugbg_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_ugbg_f300)  <- NULL
algo_runner_ugbg_f300$score_name <- score_name
algo_runner_ugbg_f300 <- algo_runner_ugbg_f300[c("score_name", "score" )] ## reordering the columns









###########  ug+bg+tg    #########

ugbgtg_features_f300<- fetures_df_from_corpus(corpus = corpus_f300, ctrl_list = ctrl_list_ugbgtg, sparsity = 0.996)
ugbgtg_feature_size <- dim(ugbgtg_features_f300)[2]   ## 24035
## running papa runner again on ngram features
algo_runner_ugbgtg_f300<- cv_algo_runner(feature_df = ugbgtg_features_f300, rating_df = df_imp_firs300, feature_vector = c(1:ugbgtg_feature_size),seed = 300,nfold = 2)
str(algo_runner_ugbgtg_f300)
dim(algo_runner_ugbgtg_f300)
head(algo_runner_ugbgtg_f300)

## extractin MEAN PRF-Accuracy Scores only
algo_runner_ugbgtg_f300<-  algo_runner_ugbgtg_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_ugbgtg_f300 <- data.frame( t(algo_runner_ugbgtg_f300))
colnames(algo_runner_ugbgtg_f300) <- c("score")  ## renaming the only column of df

score_name<- row.names(algo_runner_ugbgtg_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_ugbgtg_f300)  <- NULL
algo_runner_ugbgtg_f300$score_name <- score_name
algo_runner_ugbgtg_f300 <- algo_runner_ugbgtg_f300[c("score_name", "score" )] ## reordering the columns






###########  ug+bg+tg  + composite  #########

ugbgtg_Composite_features_f300<- cbind(ugbgtg_features_f300, negpos_POS_features_f300 )

# ugbgtg_features_f300<- fetures_df_from_corpus(corpus = corpus_f300, ctrl_list = ctrl_list_ugbgtg, sparsity = 0.99999)
ugbgtg_composite_feature_size <- dim(ugbgtg_Composite_features_f300)[2]
## running papa runner again on ngram features
algo_runner_ugbgtg_composite_f300<- cv_algo_runner(feature_df = ugbgtg_Composite_features_f300, rating_df = df_imp_firs300, feature_vector = c(1:ugbgtg_composite_feature_size),seed = 300,nfold = 2)
str(algo_runner_ugbgtg_composite_f300)
dim(algo_runner_ugbgtg_composite_f300)
head(algo_runner_ugbgtg_composite_f300)

## extractin MEAN PRF-Accuracy Scores only
algo_runner_ugbgtg_composite_f300<-  algo_runner_ugbgtg_composite_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_ugbgtg_composite_f300 <- data.frame( t(algo_runner_ugbgtg_composite_f300))
colnames(algo_runner_ugbgtg_composite_f300) <- c("score")  ## renaming the only column of df

score_name<- row.names(algo_runner_ugbgtg_composite_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_ugbgtg_composite_f300)  <- NULL
algo_runner_ugbgtg_composite_f300$score_name <- score_name
algo_runner_ugbgtg_composite_f300 <- algo_runner_ugbgtg_composite_f300[c("score_name", "score" )] ## reordering the columns
algo_runner_ugbgtg_composite_f300





###########  ug  + composite  #########

ug_Composite_features_f300<- cbind(ug_features_f300, negpos_POS_features_f300 )

# ugbgtg_features_f300<- fetures_df_from_corpus(corpus = corpus_f300, ctrl_list = ctrl_list_ugbgtg, sparsity = 0.99999)
ug_composite_feature_size <- dim(ug_Composite_features_f300)[2]
## running papa runner again on ngram features
algo_runner_ug_composite_f300<- cv_algo_runner(feature_df = ug_Composite_features_f300, rating_df = df_imp_firs300, feature_vector = c(1:ug_composite_feature_size),seed = 300,nfold = 2)
str(algo_runner_ug_composite_f300)
dim(algo_runner_ug_composite_f300)
head(algo_runner_ug_composite_f300)

## extractin MEAN PRF-Accuracy Scores only
algo_runner_ug_composite_f300<-  algo_runner_ug_composite_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_ug_composite_f300 <- data.frame( t(algo_runner_ug_composite_f300))
colnames(algo_runner_ug_composite_f300) <- c("score")  ## renaming the only column of df

score_name<- row.names(algo_runner_ug_composite_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_ug_composite_f300)  <- NULL
algo_runner_ug_composite_f300$score_name <- score_name
algo_runner_ug_composite_f300 <- algo_runner_ug_composite_f300[c("score_name", "score" )] ## reordering the columns
algo_runner_ug_composite_f300

save.image()













