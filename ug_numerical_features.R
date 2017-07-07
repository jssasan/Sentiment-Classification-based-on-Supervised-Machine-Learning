

## unigram + numerical Features


############    IMPORTANT PTNB   ############
# here all variables in the function look exactly similar to the ugbgtg function to save some time 
# main change is in the control list :  ctrl_list = ctrl_list_ug



## negpos_feature_df_2K_mob  : this comes from negpos_features_so.R script
## df_imp_2k_f_mob    :   this comes from datasets_final_all_categories.R script : it has pos tagged features: apparently name sucks
## df_imp_2k_f_mob_org :  this comes from datasets_final_all_categories.R script :: this is the original dataset with content and rating only


results_algo_runner_ug_Numerical_features_only <- function(original_df, negpos_so_features_df, pos_tagged_fetues_df, sparsity, category_name){
  
  
  ## negpos_feature_df_2K_mob  : this comes from negpos_features_so.R script
  ## df_imp_2k_f_mob    :   this comes from datasets_final_all_categories.R script : it has pos tagged features: apparently name sucks
  ## df_imp_2k_f_mob_org :  this comes from datasets_final_all_categories.R script :: this is the original dataset with content and rating only
  
  
  ## original_df comes from datasets_final_all_categories.R  
  ## corpus_transformation_custom    :   this comes from corpus_transformation_custom script
  ## fetures_df_from_corpus          :   this comes from ngram_Tokenizers.R script
  ## ctrl_list_ugbg                    :   this comes from ngram_Tokenizers.R script
  
  
  df_imp_firs300  <- original_df
  sparsity_var <- sparsity
  
  # combining both types of numerical feature sets
  
  negpos_feature_df_F300 <-  negpos_so_features_df
  pos_features_f300  <-   pos_tagged_fetues_df[, 4:39]
  
  # df_imp_firs300 <-  df_imp_2k_f_mob_org
  # negpos_feature_df_F300 <-  negpos_feature_df_2K_mob
  # pos_features_f300  <-   df_imp_2k_f_mob[,4:39]
  
  ## ngram features
  corpus_f300 <- corpus_transformation_custom(df_imp_firs300, doremoveStopWords = TRUE, doStemming = TRUE, doremoveNumbers = TRUE)
  
  ugbgtg_features_f300<- fetures_df_from_corpus(corpus = corpus_f300, ctrl_list = ctrl_list_ug, sparsity = sparsity_var)
  
  # numerical feature: combining both types of numerical feature sets
  negpos_POS_features_f300 <- cbind(negpos_feature_df_F300, pos_features_f300)
  
  ugbgtg_Composite_features_f300<- cbind(ugbgtg_features_f300, negpos_POS_features_f300 )
  
  # ugbgtg_features_f300<- fetures_df_from_corpus(corpus = corpus_f300, ctrl_list = ctrl_list_ugbgtg, sparsity = 0.99999)
  ugbgtg_composite_feature_size <- dim(ugbgtg_Composite_features_f300)[2]
  ## running papa runner again on ngram features
  algo_runner_ugbgtg_composite_f300<- cv_algo_runner(feature_df = ugbgtg_Composite_features_f300, rating_df = df_imp_firs300, feature_vector = c(1:ugbgtg_composite_feature_size),seed = 900,nfold = 10)
  str(algo_runner_ugbgtg_composite_f300)
  dim(algo_runner_ugbgtg_composite_f300)
  head(algo_runner_ugbgtg_composite_f300)
  
  
  ## run this after running Part-1 
  temp_colnames<- colnames(algo_runner_ugbgtg_composite_f300)
  
  
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
  algo_runner_ugbgtg_composite_f300<-  algo_runner_ugbgtg_composite_f300[1,PRF_accuracy_mean_scores] ## need only first row because all rows are identical
  algo_runner_ugbgtg_composite_f300 <- data.frame( t(algo_runner_ugbgtg_composite_f300))
  colnames(algo_runner_ugbgtg_composite_f300) <- c("score")  ## renaming the only column of df
  
  score_name<- row.names(algo_runner_ugbgtg_composite_f300)  ## effort to create rownames as a column of the dataframe
  rownames(algo_runner_ugbgtg_composite_f300)  <- NULL
  algo_runner_ugbgtg_composite_f300$score_name <- score_name
  algo_runner_ugbgtg_composite_f300 <- algo_runner_ugbgtg_composite_f300[c("score_name", "score" )] ## reordering the columns
  algo_runner_ugbgtg_composite_f300
  
  
  colnames(algo_runner_ugbgtg_composite_f300) <- c("Performance_Metric", "Baseline_SCore")
  
  algo_runner_ug_composite_f300  <- algo_runner_ugbgtg_composite_f300 ## just creating a new df with its actual name 
 
  rm(algo_runner_ugbgtg_composite_f300)  ## removing the bad name df because this is a UG_numerical not ugbgtg_numerical function
  
  filename <-paste("UG_Composite_PRF_accuracy_mean_", category_name, sep = "")
  
  save(algo_runner_ug_composite_f300, file = paste(filename, ".Rda", sep = ""))
  
  write.csv(algo_runner_ug_composite_f300, file = paste(filename, ".csv", sep = ""))
  
  return(algo_runner_ug_composite_f300)
  
  
}


## negpos_feature_df_2K_mob  : this comes from negpos_features_so.R script
## df_imp_2k_f_mob    :   this comes from datasets_final_all_categories.R script : it has pos tagged features: apparently name sucks
## df_imp_2k_f_mob_org :  this comes from datasets_final_all_categories.R script :: this is the original dataset with content and rating only


## Run each of these below in their own instances

sink("PRFA_unigram_Numerical_2k_all_categories.txt")

UG_Numerical_PRF_accuracy_mean_scores_2k_mob <- results_algo_runner_ug_Numerical_features_only(original_df = df_imp_2k_f_mob_org,
                                                                                              negpos_so_features_df = negpos_feature_df_2K_mob,
                                                                                              pos_tagged_fetues_df = df_imp_2k_f_mob,
                                                                                              sparsity = 0.99,
                                                                                              category_name = "mob_2k")


UG_Numerical_PRF_accuracy_mean_scores_2k_mob <- results_algo_runner_ug_Numerical_features_only(original_df = df_imp_2k_f_mob_org,
                                                                                                       negpos_so_features_df = negpos_feature_df_2K_mob,
                                                                                                       pos_tagged_fetues_df = df_imp_2k_f_mob ,
                                                                                                       sparsity = 0.99,
                                                                                                       category_name = "mob_2k")


UG_Numerical_PRF_accuracy_mean_scores_2k_cam <- results_algo_runner_ug_Numerical_features_only(original_df = df_imp_2k_f_cam_org,
                                                                                                       negpos_so_features_df = negpos_feature_df_2K_cam,
                                                                                                       pos_tagged_fetues_df = df_imp_2k_f_cam ,
                                                                                                       sparsity = 0.99,
                                                                                                       category_name = "cam_2k")



UG_Numerical_PRF_accuracy_mean_scores_2k_tab <- results_algo_runner_ug_Numerical_features_only(original_df = df_imp_2k_f_tab_org,
                                                                                                       negpos_so_features_df = negpos_feature_df_2K_tab,
                                                                                                       pos_tagged_fetues_df = df_imp_2k_f_tab ,
                                                                                                       sparsity = 0.99,
                                                                                                       category_name = "tab_2k")



UG_Numerical_PRF_accuracy_mean_scores_2k_lap <- results_algo_runner_ug_Numerical_features_only(original_df = df_imp_2k_f_lap_org,
                                                                                                       negpos_so_features_df = negpos_feature_df_2K_lap,
                                                                                                       pos_tagged_fetues_df = df_imp_2k_f_lap ,
                                                                                                       sparsity = 0.99,
                                                                                                       category_name = "lap_2k")



UG_Numerical_PRF_accuracy_mean_scores_2k_tv <- results_algo_runner_ug_Numerical_features_only(original_df = df_imp_2k_f_tv_org,
                                                                                                      negpos_so_features_df = negpos_feature_df_2K_tv,
                                                                                                      pos_tagged_fetues_df = df_imp_2k_f_tv ,
                                                                                                      sparsity = 0.99,
                                                                                                      category_name = "tv_2k")



UG_Numerical_PRF_accuracy_mean_scores_2k_vs <- results_algo_runner_ug_Numerical_features_only(original_df = df_imp_2k_f_vs_org,
                                                                                                      negpos_so_features_df = negpos_feature_df_2K_vs,
                                                                                                      pos_tagged_fetues_df = df_imp_2k_f_vs ,
                                                                                                      sparsity = 0.99,
                                                                                                      category_name = "vs_2k")


save.image()

sink()


dim(df_imp_2k_f_tab_org)
dim(negpos_feature_df_2K_tab)
dim(df_imp_2k_f_tab)
