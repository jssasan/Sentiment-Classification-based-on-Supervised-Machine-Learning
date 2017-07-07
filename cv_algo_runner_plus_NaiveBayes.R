
## this script creates a function which runs all the algorithms with their default parameter values defined earlier 
## key inputs are feature-set, output label values

###################################################################################
### start- function to run algoriths on different datasets  ##
###################################################################################


## feature_df comes from numerical_features.R
## rating_df comes from Code1_Clean_All_Full.R



cv_algo_runner  <- function(feature_df, rating_df, feature_vector, seed , nfold){
  
  fdf<- feature_df   ### dataframe which has all the features created earlier
  rdf<- rating_df    ### original dataframe which has all the ratings created at the beginning
  fv<-  feature_vector  #c(2:17)  ### this is vector of features that I want to keep for the models
  seed_num <- seed
  nf<- nfold  

  
  temp_df <- cbind(fdf, "rating"= as.numeric(rdf$rating))   ## adding rating (label) column to the daataframe
  
  matrix_temp <- as.matrix(temp_df)  ## why the fuck the factor values changed
  
  
  rc<- dim(matrix_temp)[2]    ## rating colum, ### Make Sure this is always last column of the matrix 
  
  
  ## creating training size
  floor_train_size<- floor(0.7* nrow(matrix_temp))
  
  
  # I could have created a dtm for create_container function's input instead of using matrix. Right now, I am using core matrix  
  # create_matrix : Creates an object of class DocumentTermMatrix from tm that can be used in the create_container function
  
  ## creating a container
  container.data<- create_container(matrix = matrix_temp[,fv], matrix_temp[,rc],
                                    trainSize = 1:floor_train_size, 
                                    testSize = (floor_train_size+1) : nrow(matrix_temp), virgin = FALSE)
  
  
  
  ## please use the custom PRF function created out of regular  cross_validate
  
  ## currently let's run the function with default values of algoriths, will change the function as per the need
  
  cv.NaiveBayes_train <- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "NaiveBayes")
  
  cv.MX_train<- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "MAXENT")
  
  cv.SVM_train<- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "SVM") 
  
  cv.BG_train<- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "BAGGING")
  
  cv.TREE_train<- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "TREE")
  
  cv.RF_train<- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "RF")
  
  cv.NNET_train<- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "NNET")
  
  cv.SLDA_train<- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "SLDA")
  
  cv.BOOSTING_train<- cross_validate_prf_Plus_naiveBayes(container.data, nfold = nf, seed= seed_num, algorithm = "BOOSTING")
  
  
  
  CV.Algo_output_All <- list("cv_NaiveBayes_train"=cv.NaiveBayes_train,"cv_MX_train"=cv.MX_train, "cv_SVM_train"= cv.SVM_train, 
                             "cv_BG_train"= cv.BG_train, "cv_TREE_train"= cv.TREE_train, "cv_RF_train"= cv.RF_train, 
                             "cv_NNET_train"= cv.NNET_train,"cv_SLDA_train"= cv.SLDA_train, "cv_BOOSTING_train"= cv.BOOSTING_train )
  
  CV.Algo_output_All_df <- as.data.frame(CV.Algo_output_All)
  
  return(CV.Algo_output_All_df)
  
}






##################### Apply algo runner to different datasets  ##########################


seed_vec <-c(15,25,35,45,55,65) #,75,85,95,105,115)

length(df_features_list) ## 11

### original dataframes list
df_org_list<- list(df_imp_firs300,df_imp_last300,df_imp_2k, df_imp_5k, df_imp_10k, df_imp_20k) # ,
            #  df_imp_40k, df_imp_80k, df_imp_100k, df_imp_140k, df_imp_Everything)


### features dataframes list for differt datasets (different sizes)
df_features_list <- list(negpos_feature_df_F300, negpos_feature_df_L300 , negpos_feature_df_2K, negpos_feature_df_5K, negpos_feature_df_10K, negpos_feature_df_20K ) # 
             #            , negpos_feature_df_40K, negpos_feature_df_80K, negpos_feature_df_100K, negpos_feature_df_140K, negpos_feature_df_Everything)


## Apply a Function to Multiple List : Got it working finallyyyyyy
### it saved me lots of time and manual work

features_algo_all_feats_6datasets <- mapply(function(feature_dataset_list, org_dataset_list, seed_x){
  lapply(1,
         function(x)cv_algo_runner(feature_df = feature_dataset_list, rating_df = org_dataset_list, feature_vector = c(2:17) ,seed = seed_x,  nfold = 10)
  )
}, 
feature_dataset_list= df_features_list,
org_dataset_list= df_org_list, 
seed_x= seed_vec,
SIMPLIFY = T

)


features_algo_all_feats_6datasets[[6]]
class(features_algo_all_feats_6datasets[[6]])



## to save the current workspace
save.image()


########   ########   ########   ########   ########   ########   ########   ########   ########   ########   ########   ######## 

######## some checks  ######## 
## test the function

df_org_list <- list(df_imp_firs300,df_imp_last300)  ## this was helpful to run it on a small list 
df_features_list <- list(negpos_feature_df_F300, negpos_feature_df_L300)


temp<- cv_algo_runner(feature_df = negpos_feature_df_F300, rating_df = df_imp_firs300, feature_vector =  c(2:17),seed = 15, nfold = 10 )

seed_vec <-c(15,25)

## Apply a Function to Multiple List : Got it working finallyyyyyy
### it saved me lots of time and manual work

features_algo_all <- mapply(function(feature_dataset_list, org_dataset_list, seed_x){
  lapply(1,
         function(x)cv_algo_runner(feature_df = feature_dataset_list, rating_df = org_dataset_list, feature_vector = c(2:17) ,seed = seed_x,  nfold = 10)
         )
}, 
feature_dataset_list= df_features_list,
org_dataset_list= df_org_list, 
seed_x= seed_vec,
SIMPLIFY = T

)


# some more checks to compare the results of mapply and individual run of the function (cv_algo_runner)
identical(temp, features_algo_all[[1]]) #### there you go

temp$cv_MX_train.allFoldAccuracy 
features_algo_all[[1]]$cv_MX_train.allFoldAccuracy
features_algo_all[[4]]
str(features_algo_all)
names(features_algo_all)









## Apply a Function to Multiple List
features_algo_all <- sapply(function(feature_dataset_list, org_dataset_list, seed_x){
  
         cv_algo_runner(feature_df = feature_dataset_list, rating_df = org_dataset_list, feature_vector = c(2:17) ,seed = seed_x,  nfold = 2)
  
}, 
feature_dataset_list= df_features_list,
org_dataset_list= df_org_list, 
seed_x= seed_vec,
SIMPLIFY = T

)

class(features_algo_all)
dim(features_algo_all[[1]])














### sheer shit  ######


# score_df_all[1] ## it has scores for all the datasets, here is an example of first 300 review dataset

head(score_df_all[11], 6)

## FYI:  lapply(df_num, function(x) x[[2]])  ## this statement will output all the second elements of nested lists. # In above statement we are getting 1 column of all the nested lists (different datasets) which is ofcourse the text column




# ## if score is positive then assign 4(high) else assign 1(low)
pred_score_df_all<- lapply(score_df_all, function(x) ifelse(x>0, 4, 1))
# pred_score_df_all



# ## actual labels of the data
act_df_label_all <- lapply(df_num, function(x) x[1:nrow(x),2])
# act_df_label_all 



## confusionMatrix is an awesome function of caret package to generate confusion matrix and accuracies

act_pred_list_all <- list("act"= act_df_label_all,  "pred"= pred_score_df_all)

list_num<- 11 ## num of lists inside the list, iow: number of datasets in the list

# This list of lists contain the confusion matrix and accuracy for all the data splits: this is the GEM
conf_mat_list_all <- lapply(1:list_num, function(x,dataset) confusionMatrix(dataset$act[[x]],dataset$pred[[x]], positive = "4")  
                            , dataset= act_pred_list_all)

conf_mat_list_all  ### it took 14 minutes to run all together
save(conf_mat_list_all, file = "conf_mat_list_all.Rda")







