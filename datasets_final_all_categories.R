## in this script I have created equal polarity 2k datasets, which has POS features 
## 4K can be created but I have not created yet


# function creates n reviews for a specific category dataset

annotated_dataset_producer<- function(dataset_df_imp_nk, num_rows, num_chunks){
  
  temp <- annotated_df_chunker(dataset =dataset_df_imp_nk, chunks = num_chunks)
  
  print(dim(temp))
  print(tail(temp))
  
  negative_reviews_all<- temp[temp$rating==1,]
  positive_reviews_all<- temp[temp$rating==4,] 
  
  print(dim(negative_reviews_all)) 
  print(dim(positive_reviews_all)) 
  
  negative_reviews_all <- negative_reviews_all[sample(1:nrow(negative_reviews_all)),]
  row.names(negative_reviews_all) <- NULL
  
  positive_reviews_all <- positive_reviews_all[sample(1:nrow(positive_reviews_all)),]
  row.names(positive_reviews_all) <- NULL
  
  ## 2n reviews = n pos + n neg
  temp_x <- rbind(negative_reviews_all[1:num_rows,], positive_reviews_all[1:num_rows,])
  temp_x <- temp_x[sample(1:nrow(temp_x)),] ## sampling
  row.names(temp_x) <- NULL
  
  
  return(temp_x)
  
  
  ## num_rows           : if you want 2k rows then this arg should be 1000
  ## df_imp_20k_f_mob   : if if the the master dataset
  ## num_chunks         : 50 and 100 for a master dataset of 10K and 20K respectively
  
}


save.image()
head(df_imp_20k_f_mob)


sink("Error_check_2k.txt")

df_imp_2k_f_mob <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_4k_f_mob, num_rows = 1000 , num_chunks = 50)
# df_imp_4k_f_mob <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_6k_f_mob, num_rows = 2000 , num_chunks = 50)
# df_imp_6k_f_mob <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_8k_f_mob, num_rows = 3000 , num_chunks = 50)
# df_imp_8k_f_mob <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_10k_f_mob, num_rows = 4000 , num_chunks = 50)
# df_imp_10k_f_mob <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_20k_f_mob, num_rows = 5000 , num_chunks = 50)



df_imp_2k_f_cam <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_4k_f_cam, num_rows = 1000 , num_chunks = 50)
# df_imp_4k_f_cam <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_6k_f_cam, num_rows = 2000 , num_chunks = 50)
# df_imp_6k_f_cam <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_8k_f_cam, num_rows = 3000 , num_chunks = 50)
# df_imp_8k_f_cam <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_10k_f_cam, num_rows = 4000 , num_chunks = 50)
# df_imp_10k_f_cam <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_20k_f_cam, num_rows = 5000 , num_chunks = 50)


df_imp_2k_f_lap <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_4k_f_lap, num_rows = 1000 , num_chunks = 50)
# df_imp_4k_f_lap <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_6k_f_lap, num_rows = 2000 , num_chunks = 50)
# df_imp_6k_f_lap <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_8k_f_lap, num_rows = 3000 , num_chunks = 50)
# df_imp_8k_f_lap <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_10k_f_lap, num_rows = 4000 , num_chunks = 50)
# df_imp_10k_f_lap <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_20k_f_lap, num_rows = 5000 , num_chunks = 50)


df_imp_2k_f_tab <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_4k_f_tab, num_rows = 1000 , num_chunks = 50)
# df_imp_4k_f_tab <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_6k_f_tab, num_rows = 2000 , num_chunks = 50)
# df_imp_6k_f_tab <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_8k_f_tab, num_rows = 3000 , num_chunks = 50)
# df_imp_8k_f_tab <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_10k_f_tab, num_rows = 4000 , num_chunks = 50)
# df_imp_10k_f_tab <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_20k_f_tab, num_rows = 5000 , num_chunks = 50)


df_imp_2k_f_tv <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_4k_f_tv, num_rows = 1000 , num_chunks = 50)
# df_imp_4k_f_tv <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_6k_f_tv, num_rows = 2000 , num_chunks = 50)
# df_imp_6k_f_tv <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_8k_f_tv, num_rows = 3000 , num_chunks = 50)
# df_imp_8k_f_tv <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_10k_f_tv, num_rows = 4000 , num_chunks = 50)
# df_imp_10k_f_tv <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_20k_f_tv, num_rows = 5000 , num_chunks = 50)


df_imp_2k_f_vs <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_4k_f_vs, num_rows = 1000 , num_chunks = 50)
# df_imp_4k_f_vs <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_6k_f_vs, num_rows = 2000 , num_chunks = 50)
# df_imp_6k_f_vs <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_8k_f_vs, num_rows = 3000 , num_chunks = 50)
# df_imp_8k_f_vs <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_10k_f_vs, num_rows = 4000 , num_chunks = 50)
# df_imp_10k_f_vs <- annotated_dataset_producer(dataset_df_imp_nk = df_imp_20k_f_vs, num_rows = 5000 , num_chunks = 50)


sink()

save.image()


### Now here is a thing, in Attempt_3 project the name of my annotated df was same as the input 
### df e.g. df_imp_2k_f_mob . However, I have overridden the actual dataset with this new dataset

head(df_imp_2k_f_mob)
dim(df_imp_2k_f_mob)

head(df_imp_2k_f_cam)
dim(df_imp_2k_f_cam)

head(df_imp_2k_f_lap)
dim(df_imp_2k_f_lap)


head(df_imp_2k_f_tab)
dim(df_imp_2k_f_tab)


head(df_imp_2k_f_tv)
dim(df_imp_2k_f_tv)

head(df_imp_2k_f_vs)
dim(df_imp_2k_f_vs)


save(df_imp_2k_f_mob, file = "df_imp_2k_f_mob.Rda")





##################################  Old methodology used in Attempt_3. Instead used avove function to create same datasets   #######################################################
############################################################################################################################################


###############################################################################################################
# for Reference only : starts here
###############################################################################################################


############  mobile  ###########

## preparing 2000 workable rows out of 10000 rows
head(df_imp_2k_f_mob)
dim(df_imp_2k_f_mob)


pos_features_2k_mob <- annotated_df_chunker(dataset =df_imp_2k_f_mob, chunks =  50)

dim(pos_features_2k_mob)   ## [1] 9314   39   : awesomeeee
tail(pos_features_10k_mob)

## again splitting in equal positive an negative reviews

negative_reviews_all<- pos_features_10k_mob[pos_features_10k_mob$rating==1,]
positive_reviews_all<- pos_features_10k_mob[pos_features_10k_mob$rating==4,] 

dim(negative_reviews_all)  ## [1] 4675   39
dim(positive_reviews_all)  ## [1] 4639   39


### sampling the reviews  ###
negative_reviews_all <- negative_reviews_all[sample(1:nrow(negative_reviews_all)),]
row.names(negative_reviews_all) <- NULL

positive_reviews_all <- positive_reviews_all[sample(1:nrow(positive_reviews_all)),]
row.names(positive_reviews_all) <- NULL


head(negative_reviews_all)
head(positive_reviews_all)

## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_mob <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_mob <- df_imp_2k_f_mob[sample(1:nrow(df_imp_2k_f_mob)),] ## sampling
row.names(df_imp_2k_f_mob) <- NULL

save(df_imp_2k_f_mob, file = "df_imp_2k_f_mob.Rda")

save.image()

## created n reviews for mobile dataset


###############################################################################################################

head(df_imp_2k_f_mob)

getwd()



sink(file = "CategoriesDataset_Prep.txt")

start_time <- Sys.time()
############  camera  ##########

print("Camera")

## preparing 2000 workable rows out of 10000 rows

pos_features_10k_cam <- annotated_df_chunker(dataset =df_imp_10k_f_cam, chunks =  50)
  
dim(pos_features_10k_cam)   ## [1] 9314   39   : awesomeeee
tail(pos_features_10k_cam)

## again splitting in equal positive an negative reviews

negative_reviews_all<- pos_features_10k_cam[pos_features_10k_cam$rating==1,]
positive_reviews_all<- pos_features_10k_cam[pos_features_10k_cam$rating==4,] 

dim(negative_reviews_all)  ## [1] 4675   39
dim(positive_reviews_all)  ## [1] 4639   39


### sampling the reviews  ###
negative_reviews_all <- negative_reviews_all[sample(1:nrow(negative_reviews_all)),]
row.names(negative_reviews_all) <- NULL

positive_reviews_all <- positive_reviews_all[sample(1:nrow(positive_reviews_all)),]
row.names(positive_reviews_all) <- NULL


head(negative_reviews_all)
head(positive_reviews_all)

## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_cam <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_cam <- df_imp_2k_f_cam[sample(1:nrow(df_imp_2k_f_cam)),] ## sampling
row.names(df_imp_2k_f_cam) <- NULL

save(df_imp_2k_f_cam, file = "df_imp_2k_f_cam.Rda")

save.image()

## created 2000 reviews for camera dataset
###############################################################################################################




############  Laptop  ##########

print("Laptop")

## preparing 2000 workable rows out of 10000 rows

pos_features_10k_lap <- annotated_df_chunker(dataset =df_imp_10k_f_lap, chunks =  50)

dim(pos_features_10k_lap)   ## [1] 9314   39   : awesomeeee
tail(pos_features_10k_lap)

## again splitting in equal positive an negative reviews

negative_reviews_all<- pos_features_10k_lap[pos_features_10k_lap$rating==1,]
positive_reviews_all<- pos_features_10k_lap[pos_features_10k_lap$rating==4,] 

dim(negative_reviews_all)  ## [1] 4675   39
dim(positive_reviews_all)  ## [1] 4639   39


### sampling the reviews  ###
negative_reviews_all <- negative_reviews_all[sample(1:nrow(negative_reviews_all)),]
row.names(negative_reviews_all) <- NULL

positive_reviews_all <- positive_reviews_all[sample(1:nrow(positive_reviews_all)),]
row.names(positive_reviews_all) <- NULL


head(negative_reviews_all)
head(positive_reviews_all)

## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_lap <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_lap <- df_imp_2k_f_lap[sample(1:nrow(df_imp_2k_f_lap)),] ## sampling
row.names(df_imp_2k_f_lap) <- NULL

save(df_imp_2k_f_lap, file = "df_imp_2k_f_lap.Rda")

save.image()

## created 2000 reviews for laptop dataset
###############################################################################################################

head(df_imp_2k_f_lap)




############  Tablet  ##########

print("Tablet")

## preparing 2000 workable rows out of 10000 rows

pos_features_10k_tab <- annotated_df_chunker(dataset =df_imp_10k_f_tab, chunks =  50)

dim(pos_features_10k_tab)   ## [1] 9314   39   : awesomeeee
tail(pos_features_10k_tab)

## again splitting in equal positive an negative reviews

negative_reviews_all<- pos_features_10k_tab[pos_features_10k_tab$rating==1,]
positive_reviews_all<- pos_features_10k_tab[pos_features_10k_tab$rating==4,] 

dim(negative_reviews_all)  ## [1] 4675   39
dim(positive_reviews_all)  ## [1] 4639   39


### sampling the reviews  ###
negative_reviews_all <- negative_reviews_all[sample(1:nrow(negative_reviews_all)),]
row.names(negative_reviews_all) <- NULL

positive_reviews_all <- positive_reviews_all[sample(1:nrow(positive_reviews_all)),]
row.names(positive_reviews_all) <- NULL


head(negative_reviews_all)
head(positive_reviews_all)

## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_tab <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_tab <- df_imp_2k_f_tab[sample(1:nrow(df_imp_2k_f_tab)),] ## sampling
row.names(df_imp_2k_f_tab) <- NULL

save(df_imp_2k_f_tab, file = "df_imp_2k_f_tab.Rda")

save.image()

head(df_imp_2k_f_tab)

## created 2000 reviews for tablet dataset
###############################################################################################################






############  TV  ##########

print("TV")

## preparing 2000 workable rows out of 10000 rows

pos_features_10k_tv <- annotated_df_chunker(dataset =df_imp_10k_f_tv, chunks =  50)

dim(pos_features_10k_tv)   ## [1] 9314   39   : awesomeeee
tail(pos_features_10k_tv)

## again splitting in equal positive an negative reviews

negative_reviews_all<- pos_features_10k_tv[pos_features_10k_tv$rating==1,]
positive_reviews_all<- pos_features_10k_tv[pos_features_10k_tv$rating==4,] 

dim(negative_reviews_all)  ## [1] 4675   39
dim(positive_reviews_all)  ## [1] 4639   39


### sampling the reviews  ###
negative_reviews_all <- negative_reviews_all[sample(1:nrow(negative_reviews_all)),]
row.names(negative_reviews_all) <- NULL

positive_reviews_all <- positive_reviews_all[sample(1:nrow(positive_reviews_all)),]
row.names(positive_reviews_all) <- NULL


head(negative_reviews_all)
head(positive_reviews_all)

## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_tv <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_tv <- df_imp_2k_f_tv[sample(1:nrow(df_imp_2k_f_tv)),] ## sampling
row.names(df_imp_2k_f_tv) <- NULL

save(df_imp_2k_f_tv, file = "df_imp_2k_f_tv.Rda")

save.image()


head(df_imp_2k_f_tv)
## created 2000 reviews for TV dataset
###############################################################################################################






############  Video Surviellance  ##########

print("Video Surveillance")

## preparing 2000 workable rows out of 10000 rows

pos_features_10k_vs <- annotated_df_chunker(dataset =df_imp_10k_f_vs, chunks =  50)

dim(pos_features_10k_vs)   ## [1] 9314   39   : awesomeeee
tail(pos_features_10k_vs)

## again splitting in equal positive an negative reviews

negative_reviews_all<- pos_features_10k_vs[pos_features_10k_vs$rating==1,]
positive_reviews_all<- pos_features_10k_vs[pos_features_10k_vs$rating==4,] 

dim(negative_reviews_all)  ## [1] 4675   39
dim(positive_reviews_all)  ## [1] 4639   39


### sampling the reviews  ###
negative_reviews_all <- negative_reviews_all[sample(1:nrow(negative_reviews_all)),]
row.names(negative_reviews_all) <- NULL

positive_reviews_all <- positive_reviews_all[sample(1:nrow(positive_reviews_all)),]
row.names(positive_reviews_all) <- NULL


head(negative_reviews_all)
head(positive_reviews_all)

## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_vs <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_vs <- df_imp_2k_f_vs[sample(1:nrow(df_imp_2k_f_vs)),] ## sampling
row.names(df_imp_2k_f_vs) <- NULL


save(df_imp_2k_f_vs, file = "df_imp_2k_f_vs.Rda")

save.image()

head(df_imp_2k_f_vs)

## created 2000 reviews for Video Surviellance dataset
###############################################################################################################
end_time <- Sys.time()

print(end_time - start_time)

sink()

###############################################################################################################
# Reference Ends here
###############################################################################################################


### Run the below statements


#### creating datasets which looks like original  : it is equal polarity dataset plus ####
df_imp_2k_f_mob_org<- df_imp_2k_f_mob[,c(2:3)]
df_imp_2k_f_lap_org <- df_imp_2k_f_lap[,c(2:3)]
df_imp_2k_f_cam_org<- df_imp_2k_f_cam[,c(2:3)]
df_imp_2k_f_tab_org<- df_imp_2k_f_tab[,c(2:3)]
df_imp_2k_f_tv_org<- df_imp_2k_f_tv[,c(2:3)]
df_imp_2k_f_vs_org<- df_imp_2k_f_vs[,c(2:3)]

colnames(df_imp_2k_f_tab_org)


head(df_imp_2k_f_mob)
head(df_imp_2k_f_mob[,c(2:3)])
head(df_imp_2k_f_mob_org)

save.image()





