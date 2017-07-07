
## features based on sentiment orientation and distance

head(negpos_feat_list_2K_f_mob)
#######################################################################################################################
## this will create features for datasets of 2k size only:  it can be scaled per requirement 
#######################################################################################################################

sink("report_1_2k.txt")

time_1 <- Sys.time()

print(Sys.time())

print("mobile")

negpos_feat_list_2K_f_mob<- lapply(1:length(df_imp_2k_f_mob_org$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_2k_f_mob_org)
print(Sys.time()- time_1)

print("Camera")

negpos_feat_list_2K_f_cam<- lapply(1:length(df_imp_2k_f_cam_org$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_2k_f_cam_org)
print(Sys.time()- time_1)

print("Laptop")

negpos_feat_list_2K_f_lap<- lapply(1:length(df_imp_2k_f_lap_org$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_2k_f_lap_org)
print(Sys.time()- time_1)

print("Tablet")

negpos_feat_list_2K_f_tab<- lapply(1:length(df_imp_2k_f_tab_org$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_2k_f_tab_org)
print(Sys.time()- time_1)

print("TV")

negpos_feat_list_2K_f_tv<- lapply(1:length(df_imp_2k_f_tv_org$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_2k_f_tv_org)
print(Sys.time()- time_1)

print("Video Surveillance")

negpos_feat_list_2K_f_vs<- lapply(1:length(df_imp_2k_f_vs_org$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_2k_f_vs_org)
print(Sys.time()- time_1)


print(Sys.time()- time_1)


sink()

## checks 
head(negpos_feat_list_2K_f_mob)
head(negpos_feat_list_2K_f_cam)
head(negpos_feat_list_2K_f_tab)
head(negpos_feat_list_2K_f_tv)
head(negpos_feat_list_2K_f_lap)
head(negpos_feat_list_2K_f_vs)


#######################################################################################################################
## Starts: For Reference only : can be used to scale up the dataset .this will create features for datasets of all sizes: 
#######################################################################################################################
sink("report_1.txt")

time_1 <- Sys.time()

print(Sys.time())

negpos_feat_list_F300<- lapply(1:length(df_imp_firs300$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_firs300)
print(Sys.time())

negpos_feat_list_L300<- lapply(1:length(df_imp_last300$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_last300)
print(Sys.time())

negpos_feat_list_2K_f_cam<- lapply(1:length(df_imp_2k_f_cam$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_2k_f_cam)
print(Sys.time())

negpos_feat_list_5K<- lapply(1:length(df_imp_5k$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_5k)
print(Sys.time())

negpos_feat_list_10K<- lapply(1:length(df_imp_10k$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_10k)
print(Sys.time())

negpos_feat_list_20K<- lapply(1:length(df_imp_20k$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_20k)
print(Sys.time())

negpos_feat_list_40K<- lapply(1:length(df_imp_40k$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_40k)
print(Sys.time())

negpos_feat_list_80K<- lapply(1:length(df_imp_80k$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_80k)
print(Sys.time())

negpos_feat_list_100K<- lapply(1:length(df_imp_100k$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_100k)
print(Sys.time())

negpos_feat_list_140K<- lapply(1:length(df_imp_140k$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_140k)
print(Sys.time())

negpos_feat_list_Everything<- lapply(1:length(df_imp_Everything$Content),  function(x, mydata) sem_ori_features (sentence = mydata$Content[x], positive_lexicon = pos.words, negative_lexicon = neg.words) , mydata= df_imp_Everything)
print(Sys.time())

print(Sys.time()- time_1)

sink()



### testing the above created lists of features
negpos_feat_list_Everything[[168140]]
df_imp_Everything[168140,]

negpos_feat_list_80K[[79999]]
df_imp_Everything[79999,]

# if(NULL != "role") print('test')

## some basic Checks  
df_imp_Everything[is.na(df_imp_Everything),]
df_imp_Everything[is.null(df_imp_Everything),]
anyNA(df_imp_10k$Content)
anyNA(df_imp_20k$rating)
df_imp_Everything[is.null(df_imp_Everything),]




#######################################################################################################################
## Reference ends here
#######################################################################################################################


######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### 
######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### 

## now adding all the list together to create the final features dataframe
### function to create the dataframe from the list that is created above
## note that we have eliminated sample_temp_index (a vector at index 5) from the biglist because we want only numeric features

df_features_creator<- function(biglist, num_of_rows= NULL){
  
  num_of_rows <- length(biglist)
  
  pos_score_temp<-  sapply(biglist, function(x) x[[1]] )
  neg_score_temp<-  sapply(biglist, function(x) x[[2]] )
  net_score_temp<-  sapply(biglist, function(x) x[[3]] )
  length_of_String <- sapply(biglist, function(x) x[[4]] )
  senti_ctr_pos_pos_1 <- sapply(biglist, function(x) x[[6]] )
  senti_ctr_neg_neg_1 <- sapply(biglist, function(x) x[[7]] )
  senti_ctr_pos_pos_2 <- sapply(biglist, function(x) x[[8]] )
  senti_ctr_neg_neg_2 <- sapply(biglist, function(x) x[[9]] )
  senti_ctr_pos_pos_3 <- sapply(biglist, function(x) x[[10]] )
  senti_ctr_neg_neg_3 <- sapply(biglist, function(x) x[[11]] )
  senti_ctr_pos_neg_1 <- sapply(biglist, function(x) x[[12]] )
  senti_ctr_neg_pos_1 <- sapply(biglist, function(x) x[[13]] )
  senti_ctr_pos_neg_2 <- sapply(biglist, function(x) x[[14]] )
  senti_ctr_neg_pos_2 <- sapply(biglist, function(x) x[[15]] )
  senti_ctr_pos_neg_3 <- sapply(biglist, function(x) x[[16]] )
  senti_ctr_neg_pos_3 <- sapply(biglist, function(x) x[[17]] )
  
  final_numeric_feature_df<- data.frame("Document_Index"= 1:num_of_rows, "pos_score_temp" =  pos_score_temp,	
                                        "neg_score_temp" =  neg_score_temp,	"net_score_temp" =  net_score_temp,	
                                        "length_of_String" =  length_of_String,	"senti_ctr_pos_pos_1" =  senti_ctr_pos_pos_1,	
                                        "senti_ctr_neg_neg_1" =  senti_ctr_neg_neg_1,	"senti_ctr_pos_pos_2" =  senti_ctr_pos_pos_2,
                                        "senti_ctr_neg_neg_2" =  senti_ctr_neg_neg_2,	"senti_ctr_pos_pos_3" =  senti_ctr_pos_pos_3,
                                        "senti_ctr_neg_neg_3" =  senti_ctr_neg_neg_3,	"senti_ctr_pos_neg_1" =  senti_ctr_pos_neg_1,	
                                        "senti_ctr_neg_pos_1" =  senti_ctr_neg_pos_1,	"senti_ctr_pos_neg_2" =  senti_ctr_pos_neg_2,	
                                        "senti_ctr_neg_pos_2" =  senti_ctr_neg_pos_2,	"senti_ctr_pos_neg_3" =  senti_ctr_pos_neg_3,	
                                        "senti_ctr_neg_pos_3" =  senti_ctr_neg_pos_3)
  
  rownames(final_numeric_feature_df)<-  NULL
  
  return(final_numeric_feature_df)
  
}




###### final feature list for different sizes datasets using above daddy function : df_features_creator #######
## woo woo 


negpos_feature_df_2K_mob <-  df_features_creator(biglist = negpos_feat_list_2K_f_mob)
negpos_feature_df_2K_cam <-  df_features_creator(biglist = negpos_feat_list_2K_f_cam)
negpos_feature_df_2K_lap <-  df_features_creator(biglist = negpos_feat_list_2K_f_lap)
negpos_feature_df_2K_tab <-  df_features_creator(biglist = negpos_feat_list_2K_f_tab)
negpos_feature_df_2K_tv <-  df_features_creator(biglist = negpos_feat_list_2K_f_tv)
negpos_feature_df_2K_vs <-  df_features_creator(biglist = negpos_feat_list_2K_f_vs)


## checks
head(negpos_feature_df_2K_mob)
head(negpos_feature_df_2K_cam)
head(negpos_feature_df_2K_lap)
head(negpos_feature_df_2K_tab)
head(negpos_feature_df_2K_tv)
head(negpos_feature_df_2K_vs)



save.image()
#######################################################################################################################
## Starts: For Reference only : can be used to scale up the dataset .this will create features for datasets of all sizes: 
## caution: Don't run
#######################################################################################################################


###### final feature list for different sizes datasets using above daddy function : df_features_creator #######
## woo woo 

negpos_feature_df_F300 <-  df_features_creator(biglist = negpos_feat_list_F300)
negpos_feature_df_L300 <-  df_features_creator(biglist = negpos_feat_list_L300)
negpos_feature_df_2K <-  df_features_creator(biglist = negpos_feat_list_2K)
negpos_feature_df_5K <-  df_features_creator(biglist = negpos_feat_list_5K)
negpos_feature_df_10K <-  df_features_creator(biglist = negpos_feat_list_10K)
negpos_feature_df_20K <-  df_features_creator(biglist = negpos_feat_list_20K)
negpos_feature_df_40K <-  df_features_creator(biglist = negpos_feat_list_40K)
negpos_feature_df_80K <-  df_features_creator(biglist = negpos_feat_list_80K)
negpos_feature_df_100K <-  df_features_creator(biglist = negpos_feat_list_100K)
negpos_feature_df_140K <-  df_features_creator(biglist = negpos_feat_list_140K)
negpos_feature_df_Everything <-  df_features_creator(biglist = negpos_feat_list_Everything)

# negpos_feature_df_Everything[is.na(negpos_feature_df_Everything),]  ### No NAs in this 

#######################################################################################################################
## Reference ends here
#######################################################################################################################



######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### 
######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### ######### 


### two things come here before I start building models 
## Idea 1. Either run models just with features created above
## Idea 2. Run models by combining the unigrams/bigrams/trigrams with the features created above


## Idea 1.

#######################################################################################################################
                ### below are just trials
#######################################################################################################################
temp_df <- cbind(negpos_feature_df_F300, as.numeric(df_imp_firs300$rating))   ## adding rating (label) column to the daataframe

temp_df <- cbind(negpos_feature_df_10K, "rating"= as.numeric(df_imp_10k$rating))   ## adding rating (label) column to the daataframe
# str(temp_df)

matrix_temp <- as.matrix(temp_df)  ## why the fuck the factor values changed
matrix_temp[1:10,]  
dim(matrix_temp)

## creating training size
floor_train_size<- floor(0.7* nrow(matrix_temp))

container.data<- create_container(matrix = matrix_temp[,2:17], matrix_temp[,18],
                                  trainSize = 1:floor_train_size, 
                                  testSize = (floor_train_size+1) : nrow(matrix_temp), virgin = FALSE)


container.data<- NULL

temp_feature<- c(2:17)
temp_rating<- 18
dim(matrix_temp)[2]

container.data<- create_container(matrix = matrix_temp[,temp_feature], matrix_temp[,temp_rating],
                                  trainSize = 1:floor_train_size, 
                                  testSize = (floor_train_size+1) : nrow(matrix_temp), virgin = FALSE)

container.data@training_codes

## please use the custom PRF function created out of regular  cross_validate
cv.MX_train<- cross_validate_prf(container.data, nfold = 10, seed=24, algorithm = "TREE")

cv.SVM_train<- cross_validate_prf(container.data, nfold = 10, seed=24,algorithm = "SVM") 

cv.BG_train<- cross_validate_prf(container.data, nfold = 10, seed=24,"BAGGING")

cv.TREE_train<- cross_validate_prf(container.data, nfold = 10, seed=24,"TREE")

cv.RF_train<- cross_validate_prf(container.data, nfold = 10, seed=24,"RF")

CV.Algo_output_All <- list("cv.MX_train"=cv.MX_train, "cv.SVM_train"= cv.SVM_train, "cv.BG_train"= cv.BG_train,
                           "cv.TREE_train"= cv.TREE_train, "cv.RF_train"= cv.RF_train)

as.data.frame(CV.Algo_output_All)



## for first 300 reviews
cv.MX_train   ##  0.8117463
cv.SVM_train  ## 0.7151864
cv.BG_train    ##  0.7858202
cv.TREE_train   ##  0.7762675
cv.RF_train    ##   0.7989492


## for 10K reviews
cv.MX_train   ##  0.8164952
cv.SVM_train  ## 0.6475634
cv.BG_train    ##  0.8086503
cv.TREE_train   ##  0.7819701
cv.RF_train    ##   0.8206242








