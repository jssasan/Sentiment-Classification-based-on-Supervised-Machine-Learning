
## In this script I am creating composite feature set : POS tagged  features and negpos semantic oriented features
## Here, ngram features are also created : with different combinations
## overlook names which has f300 in it: a lot of variables have f300 in their names and I am not going to do this monkey work and change every name

## some sample example
## negpos_feature_df_2K_mob  : this comes from negpos_features_so.R script
## df_imp_2k_f_mob    :   this comes from datasets_final_all_categories.R script : it has pos tagged features: apparently name sucks
## df_imp_2k_f_mob_org :  this comes from datasets_final_all_categories.R script :: this is the original dataset with content and rating only

dim(negpos_feature_df_2K_mob)  # [1] 2000  17
dim(df_imp_2k_f_mob)      # [1] 2000  36
dim(df_imp_2k_f_mob_org)  ## 2000  2

head(negpos_feature_df_2K_mob)  # [1] 300  17
head(df_imp_2k_f_mob[,4:39])      # [1] 300  36
head(df_imp_2k_f_mob_org) 




## this is a kick ass mother fucker function : it generates results in the form of a csv
## only for numerical features
## make category names with its size e.g. mob_2k
# Number_of_rows is the size of the dataset we are desired to run algorithms on e.g. 2000, 4000 etc
results_algo_runner_numerical_features_only <- function(original_df, negpos_so_features_df, pos_tagged_fetues_df, Number_of_rows, category_name){
  
  
# category_name <- "mob_2k"
  
# combining both feature sets
rnum <- Number_of_rows
df_imp_firs300 <-  original_df[1:rnum, ]
negpos_feature_df_F300 <-  negpos_so_features_df[1:rnum, ]
pos_features_f300  <-   pos_tagged_fetues_df[1:rnum, 4:39]
  
# df_imp_firs300 <-  df_imp_2k_f_mob_org
# negpos_feature_df_F300 <-  negpos_feature_df_2K_mob
# pos_features_f300  <-   df_imp_2k_f_mob[,4:39]

negpos_POS_features_f300 <- cbind(negpos_feature_df_F300, pos_features_f300)

dim(negpos_POS_features_f300)  ## [1] 2000  53




## part-1
## running papa runner on negpos_feature_df_F300 feature set only : these are neg pos distance based features
algo_runner_negpos_f300 <- cv_algo_runner(feature_df = negpos_feature_df_F300, rating_df = df_imp_firs300, feature_vector =  c(1:17),seed = 300, nfold = 10 )
str(algo_runner_negpos_f300)
dim(algo_runner_negpos_f300)
head(algo_runner_negpos_f300)

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
algo_runner_negpos_f300<-  algo_runner_negpos_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_negpos_f300 <- data.frame( t(algo_runner_negpos_f300))
colnames(algo_runner_negpos_f300) <- c("score")  ## renaming the only column of df

score_name<- row.names(algo_runner_negpos_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_negpos_f300)  <- NULL
algo_runner_negpos_f300$score_name <- score_name
algo_runner_negpos_f300 <- algo_runner_negpos_f300[c("score_name", "score" )] ## reordering the columns


## part-2
## running papa runner on pos_features_f300 feature set only : these are Part of speech features
algo_runner_POS_f300 <- cv_algo_runner(feature_df = pos_features_f300, rating_df = df_imp_firs300, feature_vector =  c(1:36),seed = 300, nfold = 10 )
str(algo_runner_POS_f300)
dim(algo_runner_POS_f300)
head(algo_runner_POS_f300)

## extractin MEAN PRF-Accuracy Scores only
algo_runner_POS_f300<-  algo_runner_POS_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_POS_f300 <- data.frame( t(algo_runner_POS_f300))
colnames(algo_runner_POS_f300) <- c("score")  ## renaming the only column of df

score_name<- row.names(algo_runner_POS_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_POS_f300)  <- NULL
algo_runner_POS_f300$score_name <- score_name
algo_runner_POS_f300 <- algo_runner_POS_f300[c("score_name", "score" )] ## reordering the columns




## part-3
## running papa runner on composite feature set   : these are part-1 + part-2 features
algo_runner_composite_f300 <- cv_algo_runner(feature_df = negpos_POS_features_f300, rating_df = df_imp_firs300, feature_vector =  c(1:53),seed = 300, nfold = 10 )
str(algo_runner_composite_f300)
dim(algo_runner_composite_f300)
head(algo_runner_composite_f300)

## extractin MEAN PRF-Accuracy Scores only
algo_runner_composite_f300<-  algo_runner_composite_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_composite_f300 <- data.frame( t(algo_runner_composite_f300))
colnames(algo_runner_composite_f300) <- c("score")  ## renaming the only column of df

score_name<- row.names(algo_runner_composite_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_composite_f300)  <- NULL
algo_runner_composite_f300$score_name <- score_name
algo_runner_composite_f300 <- algo_runner_composite_f300[c("score_name", "score" )] ## reordering the columns




### merging outputs of Part-1 , part-2 and part-3

comparison_PRF_accuracy_mean_scores_f300 <- cbind(algo_runner_negpos_f300, algo_runner_POS_f300[,2], algo_runner_composite_f300[,2]) 
## making more sensible colnames
colnames(comparison_PRF_accuracy_mean_scores_f300) <- c("Performance_Metric", "Neg_Pos_Distance_Features", "Part_Of_Speech_Features", "Composite_Features")

filename <-paste("PRF_accuracy_mean_", category_name, sep = "")

write.csv(comparison_PRF_accuracy_mean_scores_f300, file = paste(filename, ".csv", sep = ""))

return(comparison_PRF_accuracy_mean_scores_f300)

}
## here ends the function

head(negpos_feature_df_2K_mob)  # [1] 300  17
head(df_imp_2k_f_mob[,4:39])      # [1] 300  36
head(df_imp_2k_f_mob_org) 


############# this is all I need and is most of the work #############

### running the above function (greatest ever) for each category
## remmeber : make category names with its size e.g. mob_2k

save.image()



sink("PRF_accuracy_mean_scores_2k_6_categories.txt")

time_1 <- Sys.time()

print(Sys.time())


PRF_accuracy_mean_scores_2k_mob  <- results_algo_runner_numerical_features_only(original_df = df_imp_2k_f_mob_org, 
                                                                                negpos_so_features_df = negpos_feature_df_2K_mob,
                                                                                pos_tagged_fetues_df = df_imp_2k_f_mob,
                                                                                Number_of_rows = 2000,
                                                                                category_name = "mob_2k")



print("Camera")
PRF_accuracy_mean_scores_2k_cam  <- results_algo_runner_numerical_features_only(original_df = df_imp_2k_f_cam_org, 
                                                                                negpos_so_features_df = negpos_feature_df_2K_cam,
                                                                                pos_tagged_fetues_df = df_imp_2k_f_cam,
                                                                                Number_of_rows = 2000,
                                                                                category_name = "cam_2k")


print("Laptop")
PRF_accuracy_mean_scores_2k_lap  <- results_algo_runner_numerical_features_only(original_df = df_imp_2k_f_lap, 
                                                                                negpos_so_features_df = negpos_feature_df_2K_lap,
                                                                                pos_tagged_fetues_df = df_imp_2k_f_lap,
                                                                                Number_of_rows = 2000,
                                                                                category_name = "lap_2k")


print("Tablet")
PRF_accuracy_mean_scores_2k_tab  <- results_algo_runner_numerical_features_only(original_df = df_imp_2k_f_tab_org, 
                                                                                negpos_so_features_df = negpos_feature_df_2K_tab,
                                                                                pos_tagged_fetues_df = df_imp_2k_f_tab,
                                                                                Number_of_rows = 2000,
                                                                                category_name = "tab_2k")


print("TV")
PRF_accuracy_mean_scores_2k_tv  <- results_algo_runner_numerical_features_only(original_df = df_imp_2k_f_tv_org, 
                                                                                negpos_so_features_df = negpos_feature_df_2K_tv,
                                                                                pos_tagged_fetues_df = df_imp_2k_f_tv,
                                                                                Number_of_rows = 2000,
                                                                                category_name = "tv_2k")


print("Video Surviellance")
PRF_accuracy_mean_scores_2k_vs  <- results_algo_runner_numerical_features_only(original_df = df_imp_2k_f_vs_org, 
                                                                                negpos_so_features_df = negpos_feature_df_2K_vs,
                                                                                pos_tagged_fetues_df = df_imp_2k_f_vs,
                                                                                Number_of_rows = 2000,
                                                                                category_name = "vs_2k")


print(Sys.time())

print(Sys.time()- time_1)

sink()

save.image()


## till above point:  perfectly working for 2k Reviews 




######################################################################################################################
##  Yet to check: Below is for reference only. ACtual can be seen in baseline_all_categories.R script  ###
######################################################################################################################


###########  ngram features #########


## corpus_transformation_custom    :   this comes from ngram.R script
## fetures_df_from_corpus          :   this comes from ngram.R script
## ctrl_list_ug                    :   this comes from ngram.R script



corpus_f300 <- corpus_transformation_custom(df_imp_firs300, doremoveStopWords = TRUE, doStemming = TRUE, doremoveNumbers = TRUE)


###########  unigram    #########
ug_features_f300<- fetures_df_from_corpus(corpus = corpus_f300, ctrl_list = ctrl_list_ug, sparsity = 0.99999)
ug_feature_size <- dim(ug_features_f300)[2]
## running papa runner again on ngram features
algo_runner_unigram_f300<- cv_algo_runner(feature_df = ug_features_f300, rating_df = df_imp_firs300, feature_vector = c(1:ug_feature_size),seed = 300,nfold = 2)
str(algo_runner_unigram_f300)
dim(algo_runner_unigram_f300)
head(algo_runner_unigram_f300)

## extractin MEAN PRF-Accuracy Scores only
algo_runner_unigram_f300<-  algo_runner_unigram_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
algo_runner_unigram_f300 <- data.frame( t(algo_runner_unigram_f300))
colnames(algo_runner_unigram_f300) <- c("score")  ## renaming the only column of df

score_name<- row.names(algo_runner_unigram_f300)  ## effort to create rownames as a column of the dataframe
rownames(algo_runner_unigram_f300)  <- NULL
algo_runner_unigram_f300$score_name <- score_name
algo_runner_unigram_f300 <- algo_runner_unigram_f300[c("score_name", "score" )] ## reordering the columns



# corpus_f300[[1]]$content  ## checking
# head(ngram_features_f300)  ## checking
# dim(ngram_features_f300)  ## [1]  300 2649


save.image()


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






##############################################################################################################################
###########  Here comes the Savior: Feature Selection: FUck yesssssssssssssss    #########
##############################################################################################################################

class(ugbgtg_Composite_features_f300)

tail(colnames(ugbgtg_Composite_features_f300))


## adding rating colum to the feature dataset 
ugbgtg_Composite_features_f300_rating  <- cbind(ugbgtg_Composite_features_f300, rating= df_imp_firs300$rating )


tail(colnames(ugbgtg_Composite_features_f300_rating))


require(FSelector)



weights_ig<- information.gain(formula = rating~ . , data = ugbgtg_Composite_features_f300_rating)

weights_ig <- as.data.frame(weights_ig)

dim(weights_ig)  ## 1] 3162    1

weights_ig$variable <- row.names(weights_ig) 

weights_ig <- weights_ig[c("variable", "attr_importance")]

row.names(weights_ig) <- NULL

temp_weights_ig<-  weights_ig[order(-weights_ig$attr_importance),]
str(temp_weights_ig)
head(temp_weights_ig,30)


head(weights_ig, 20)

# Zero is a valid value for feature importance -- it means that the feature does not have any 
# information with respect to the classification target.


##he algorithms select a subset from a ranked attributes.
subset <- cutoff.k(weights_ig, 500)  ## character

subset<- as.numeric(subset)

weights_ig[c(subset),]


selected_var_ig<- (weights_ig[c(subset),1])
selected_var_ig

formula_ig  <- as.simple.formula(selected_var_ig, "label")

dim(test)



########################################################################################################


## The algorithms find weights of discrete attributes basing on their correlation with continous class attribute.
weights_gr<- gain.ratio(formula = rating~ . , data = ugbgtg_Composite_features_f300_rating)


weights_gr <- as.data.frame(weights_gr)

dim(weights_gr)

weights_gr$variable <- row.names(weights_gr) 

weights_gr <- weights_gr[c("variable", "attr_importance")]

row.names(weights_gr) <- NULL

temp_weights_gr<-  weights_gr[order(-weights_gr$attr_importance),]
str(temp_weights_gr)
head(temp_weights_gr,30)


head(weights_gr, 20)

# Zero is a valid value for feature importance -- it means that the feature does not have any 
# information with respect to the classification target.


##he algorithms select a subset from a ranked attributes.
subset <- cutoff.k(weights_gr, 10)  ## character

subset<- as.numeric(subset)

weights_gr[c(subset),]


selected_var_gr<- (weights_gr[c(subset),1])
selected_var_gr

formula_gr  <- as.simple.formula(selected_var_gr, "label")

glm_gr <- glm(formula = formula_gr, data = final_temp)




########################################################################################################



# The algorithm finds weights of discrete attributes basing on a chi-squared test.
# The result is equal to Cramer's V coefficient between source attributes and destination attribute.

weights_cs<- chi.squared(formula = rating~ . , data = ugbgtg_Composite_features_f300_rating)


weights_cs <- as.data.frame(weights_cs)

dim(weights_cs)

weights_cs$variable <- row.names(weights_cs) 

weights_cs <- weights_cs[c("variable", "attr_importance")]

row.names(weights_cs) <- NULL

temp_weights_cs<-  weights_gr[order(-weights_gr$attr_importance),]
str(temp_weights_cs)
head(temp_weights_cs,30)

head(weights_cs, 20)

# Zero is a valid value for feature importance -- it means that the feature does not have any 
# information with respect to the classification target.


##he algorithms select a subset from a ranked attributes.
subset <- cutoff.k(weights_cs, 10)  ## character

subset<- as.numeric(subset)

weights_cs[c(subset),]


selected_var_cs<- (weights_cs[c(subset),1])
selected_var_cs

formula_cs  <- as.simple.formula(selected_var_cs, "label")


glm_cs <- glm(formula = formula_cs, data = final_temp)








save.image()





sessionInfo()









