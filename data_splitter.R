
### split the dataframe and create new smaller chunks
## individual category datasets from this point : 2k, 4k, 6k, 8k, 10k


## 1. mobile
## 2. Camera
## 3. TV
## 4. Laptop
## 5. Tablets
## 6. Video Surviellance


## no need to create separate splitting code for each category : just load the respective dataset and keep rest of the names identical
## except the specific ones

## loading the entire review data set and dividing them in equal polarity

load("df_imp_Everything_laptop.Rda")
head(df_imp_Everything_laptop)


df_imp_Everything <- df_imp_Everything_laptop
rm(df_imp_Everything_laptop)

dim(df_imp_Everything)


## big assumption: only considering those review which have characters greater than 10
## deleting blank content columns and reviews which have which have characters less than 10
df_imp_Everything <- df_imp_Everything[nchar(df_imp_Everything$Content) >10, ]



dim(df_imp_Everything)


head(df_imp_Everything[nchar(df_imp_Everything$Content) <10, ])  # test

head(df_imp_Everything)

## Please dont run it : 
# applying function on everything
# tagged_everything<- annotated_df(df_imp_Everything) ## does not work

# tagged_everything<- annotated_df(df_imp_Everything[1:1000,])  ## works great for first 1000 rows



#####################################################################################################################################

### dividing data into equal polarity   ####  also make sure you run above thing to delete rows with less than 10 chars in the review   
#####################################################################################################################################


dim(df_imp_Everything)  ## [1] 435490      2

dim(df_imp_Everything[df_imp_Everything$rating==1,])   ## [1] 49664     2   ## there are 49664 negative reviews
dim(df_imp_Everything[df_imp_Everything$rating==4,])   ## [1] 118697      2  ## there are 118697 negative reviews

negative_reviews_all<- df_imp_Everything[df_imp_Everything$rating==1,]
positive_reviews_all<- df_imp_Everything[df_imp_Everything$rating==4,] 

### sampling the reviews  ###
negative_reviews_all <- negative_reviews_all[sample(1:nrow(negative_reviews_all)),]
row.names(negative_reviews_all) <- NULL

positive_reviews_all <- positive_reviews_all[sample(1:nrow(positive_reviews_all)),]
row.names(positive_reviews_all) <- NULL


head(negative_reviews_all)
head(positive_reviews_all)

dim(negative_reviews_all)
dim(positive_reviews_all)


rm(df_imp_Everything)

### till above point : run for each category and then use the negative_reviews_all and positive_reviews_all to create individual 
## datasets for each category as below ### 


## individual category datasets from this point : 2k, 4k, 6k, 8k, 10k, 20k

############################################################################################################
###########################       Video Surviellance  ###########################

##running it for 2k reviews even though it has already been done in the previous project
## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_vs <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_vs <- df_imp_2k_f_vs[sample(1:nrow(df_imp_2k_f_vs)),] ## sampling
row.names(df_imp_2k_f_vs) <- NULL



## 4000 reviews = 2000 pos + 2000 neg
df_imp_4k_f_vs <- rbind(negative_reviews_all[1001:3000,], positive_reviews_all[1001:3000,])
df_imp_4k_f_vs <- df_imp_4k_f_vs[sample(1:nrow(df_imp_4k_f_vs)),]  ## sampling
row.names(df_imp_4k_f_vs) <- NULL


## 6000 reviews = 3000 pos + 3000 neg
df_imp_6k_f_vs <- rbind(negative_reviews_all[1001:4000,], positive_reviews_all[1001:4000,])
df_imp_6k_f_vs <- df_imp_6k_f_vs[sample(1:nrow(df_imp_6k_f_vs)),]  ## sampling
row.names(df_imp_6k_f_vs) <- NULL


## 8000 reviews = 4000 pos + 4000 neg
df_imp_8k_f_vs <- rbind(negative_reviews_all[8001:12000,], positive_reviews_all[8001:12000,])
df_imp_8k_f_vs <- df_imp_8k_f_vs[sample(1:nrow(df_imp_8k_f_vs)),]  ## sampling
row.names(df_imp_8k_f_vs) <- NULL


## 10000 reviews = 5000 pos + 5000 neg  : randomly selected the row numbers below
df_imp_10k_f_vs <- rbind(negative_reviews_all[1:5000,], positive_reviews_all[1:5000,])
df_imp_10k_f_vs <- df_imp_10k_f_vs[sample(1:nrow(df_imp_10k_f_vs)),]   ## sampling
row.names(df_imp_10k_f_vs) <- NULL



## 20000 reviews = 10000 pos + 10000 neg  : randomly selected the row numbers below
df_imp_20k_f_vs <- rbind(negative_reviews_all[1:10000,], positive_reviews_all[1:10000,])
df_imp_20k_f_vs <- df_imp_20k_f_vs[sample(1:nrow(df_imp_20k_f_vs)),]   ## sampling
row.names(df_imp_20k_f_vs) <- NULL




tail(df_imp_10k_f_vs)


## saving the files for distributed running on AWS's instances
save(df_imp_2k_f_vs, file = "df_imp_2k_f_vs.Rda")
save(df_imp_4k_f_vs, file = "df_imp_4k_f_vs.Rda")
save(df_imp_6k_f_vs, file = "df_imp_6k_f_vs.Rda")
save(df_imp_8k_f_vs, file = "df_imp_8k_f_vs.Rda")
save(df_imp_10k_f_vs, file = "df_imp_10k_f_vs.Rda")
save(df_imp_20k_f_vs, file = "df_imp_20k_f_vs.Rda")

save.image()



############################################################################################################
###########################       TV         ###########################

##running it for 2k reviews even though it has already been done in the previous project
## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_tv <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_tv <- df_imp_2k_f_tv[sample(1:nrow(df_imp_2k_f_tv)),] ## sampling
row.names(df_imp_2k_f_tv) <- NULL



## 4000 reviews = 2000 pos + 2000 neg
df_imp_4k_f_tv <- rbind(negative_reviews_all[1001:3000,], positive_reviews_all[1001:3000,])
df_imp_4k_f_tv <- df_imp_4k_f_tv[sample(1:nrow(df_imp_4k_f_tv)),]  ## sampling
row.names(df_imp_4k_f_tv) <- NULL


## 6000 reviews = 3000 pos + 3000 neg
df_imp_6k_f_tv <- rbind(negative_reviews_all[1001:4000,], positive_reviews_all[1001:4000,])
df_imp_6k_f_tv <- df_imp_6k_f_tv[sample(1:nrow(df_imp_6k_f_tv)),]  ## sampling
row.names(df_imp_6k_f_tv) <- NULL

## 8000 reviews = 4000 pos + 4000 neg
df_imp_8k_f_tv <- rbind(negative_reviews_all[8001:12000,], positive_reviews_all[8001:12000,])
df_imp_8k_f_tv <- df_imp_8k_f_tv[sample(1:nrow(df_imp_8k_f_tv)),]  ## sampling
row.names(df_imp_8k_f_tv) <- NULL


## 10000 reviews = 5000 pos + 5000 neg  : randomly selected the row numbers below
df_imp_10k_f_tv <- rbind(negative_reviews_all[1:5000,], positive_reviews_all[1:5000,])
df_imp_10k_f_tv <- df_imp_10k_f_tv[sample(1:nrow(df_imp_10k_f_tv)),]   ## sampling
row.names(df_imp_10k_f_tv) <- NULL



## 20000 reviews = 10000 pos + 10000 neg  : randomly selected the row numbers below
df_imp_20k_f_tv <- rbind(negative_reviews_all[5001:15000,], positive_reviews_all[5001:15000,])
df_imp_20k_f_tv <- df_imp_20k_f_tv[sample(1:nrow(df_imp_20k_f_tv)),]   ## sampling
row.names(df_imp_20k_f_tv) <- NULL



tail(df_imp_20k_f_tv)


## saving the files for distributed running on AWS's instances
save(df_imp_2k_f_tv, file = "df_imp_2k_f_tv.Rda")
save(df_imp_4k_f_tv, file = "df_imp_4k_f_tv.Rda")
save(df_imp_6k_f_tv, file = "df_imp_6k_f_tv.Rda")
save(df_imp_8k_f_tv, file = "df_imp_8k_f_tv.Rda")
save(df_imp_10k_f_tv, file = "df_imp_10k_f_tv.Rda")
save(df_imp_20k_f_tv, file = "df_imp_20k_f_tv.Rda")


# 118697 +49664 



############################################################################################################
###########################       Camera  ###########################

##running it for 2k reviews even though it has already been done in the previous project
## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_cam <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_cam <- df_imp_2k_f_cam[sample(1:nrow(df_imp_2k_f_cam)),] ## sampling
row.names(df_imp_2k_f_cam) <- NULL



## 4000 reviews = 2000 pos + 2000 neg
df_imp_4k_f_cam <- rbind(negative_reviews_all[1001:3000,], positive_reviews_all[1001:3000,])
df_imp_4k_f_cam <- df_imp_4k_f_cam[sample(1:nrow(df_imp_4k_f_cam)),]  ## sampling
row.names(df_imp_4k_f_cam) <- NULL


## 6000 reviews = 3000 pos + 3000 neg
df_imp_6k_f_cam <- rbind(negative_reviews_all[1001:4000,], positive_reviews_all[1001:4000,])
df_imp_6k_f_cam <- df_imp_6k_f_cam[sample(1:nrow(df_imp_6k_f_cam)),]  ## sampling
row.names(df_imp_6k_f_cam) <- NULL


## 8000 reviews = 4000 pos + 4000 neg
df_imp_8k_f_cam <- rbind(negative_reviews_all[8001:12000,], positive_reviews_all[8001:12000,])
df_imp_8k_f_cam <- df_imp_8k_f_cam[sample(1:nrow(df_imp_8k_f_cam)),]  ## sampling
row.names(df_imp_8k_f_cam) <- NULL


## 10000 reviews = 5000 pos + 5000 neg  : randomly selected the row numbers below
df_imp_10k_f_cam <- rbind(negative_reviews_all[1:5000,], positive_reviews_all[1:5000,])
df_imp_10k_f_cam <- df_imp_10k_f_cam[sample(1:nrow(df_imp_10k_f_cam)),]   ## sampling
row.names(df_imp_10k_f_cam) <- NULL


## 20000 reviews = 10000 pos + 10000 neg  : randomly selected the row numbers below
df_imp_20k_f_cam <- rbind(negative_reviews_all[5001:15000,], positive_reviews_all[5001:15000,])
df_imp_20k_f_cam <- df_imp_20k_f_cam[sample(1:nrow(df_imp_20k_f_cam)),]   ## sampling
row.names(df_imp_20k_f_cam) <- NULL



tail(df_imp_20k_f_cam)


## saving the files for distributed running on AWS's instances
save(df_imp_2k_f_cam, file = "df_imp_2k_f_cam.Rda")
save(df_imp_4k_f_cam, file = "df_imp_4k_f_cam.Rda")
save(df_imp_6k_f_cam, file = "df_imp_6k_f_cam.Rda")
save(df_imp_8k_f_cam, file = "df_imp_8k_f_cam.Rda")
save(df_imp_10k_f_cam, file = "df_imp_10k_f_cam.Rda")
save(df_imp_20k_f_cam, file = "df_imp_20k_f_cam.Rda")


############################################################################################################
###########################       Tablet    ###########################

##running it for 2k reviews even though it has already been done in the previous project
## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_tab <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_tab <- df_imp_2k_f_tab[sample(1:nrow(df_imp_2k_f_tab)),] ## sampling
row.names(df_imp_2k_f_tab) <- NULL



## 4000 reviews = 2000 pos + 2000 neg
df_imp_4k_f_tab <- rbind(negative_reviews_all[1001:3000,], positive_reviews_all[1001:3000,])
df_imp_4k_f_tab <- df_imp_4k_f_tab[sample(1:nrow(df_imp_4k_f_tab)),]  ## sampling
row.names(df_imp_4k_f_tab) <- NULL


## 6000 reviews = 3000 pos + 3000 neg
df_imp_6k_f_tab <- rbind(negative_reviews_all[1001:4000,], positive_reviews_all[1001:4000,])
df_imp_6k_f_tab <- df_imp_6k_f_tab[sample(1:nrow(df_imp_6k_f_tab)),]  ## sampling
row.names(df_imp_6k_f_tab) <- NULL


## 8000 reviews = 4000 pos + 4000 neg
df_imp_8k_f_tab <- rbind(negative_reviews_all[8001:12000,], positive_reviews_all[8001:12000,])
df_imp_8k_f_tab <- df_imp_8k_f_tab[sample(1:nrow(df_imp_8k_f_tab)),]  ## sampling
row.names(df_imp_8k_f_tab) <- NULL


## 10000 reviews = 5000 pos + 5000 neg  : randomly selected the row numbers below
df_imp_10k_f_tab <- rbind(negative_reviews_all[1:5000,], positive_reviews_all[1:5000,])
df_imp_10k_f_tab <- df_imp_10k_f_tab[sample(1:nrow(df_imp_10k_f_tab)),]   ## sampling
row.names(df_imp_10k_f_tab) <- NULL


## 20000 reviews = 10000 pos + 10000 neg  : randomly selected the row numbers below
df_imp_20k_f_tab <- rbind(negative_reviews_all[5001:15000,], positive_reviews_all[5001:15000,])
df_imp_20k_f_tab <- df_imp_20k_f_tab[sample(1:nrow(df_imp_20k_f_tab)),]   ## sampling
row.names(df_imp_20k_f_tab) <- NULL




tail(df_imp_20k_f_tab)


## saving the files for distributed running on AWS's instances
save(df_imp_2k_f_tab, file = "df_imp_2k_f_tab.Rda")
save(df_imp_4k_f_tab, file = "df_imp_4k_f_tab.Rda")
save(df_imp_6k_f_tab, file = "df_imp_6k_f_tab.Rda")
save(df_imp_8k_f_tab, file = "df_imp_8k_f_tab.Rda")
save(df_imp_10k_f_tab, file = "df_imp_10k_f_tab.Rda")
save(df_imp_20k_f_tab, file = "df_imp_20k_f_tab.Rda")


############################################################################################################
###########################       Laptop  ###########################

##running it for 2k reviews even though it has already been done in the previous project
## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_lap <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_lap <- df_imp_2k_f_lap[sample(1:nrow(df_imp_2k_f_lap)),] ## sampling
row.names(df_imp_2k_f_lap) <- NULL



## 4000 reviews = 2000 pos + 2000 neg
df_imp_4k_f_lap <- rbind(negative_reviews_all[1001:3000,], positive_reviews_all[1001:3000,])
df_imp_4k_f_lap <- df_imp_4k_f_lap[sample(1:nrow(df_imp_4k_f_lap)),]  ## sampling
row.names(df_imp_4k_f_lap) <- NULL


## 6000 reviews = 3000 pos + 3000 neg
df_imp_6k_f_lap <- rbind(negative_reviews_all[1001:4000,], positive_reviews_all[1001:4000,])
df_imp_6k_f_lap <- df_imp_6k_f_lap[sample(1:nrow(df_imp_6k_f_lap)),]  ## sampling
row.names(df_imp_6k_f_lap) <- NULL


## 8000 reviews = 4000 pos + 4000 neg
df_imp_8k_f_lap <- rbind(negative_reviews_all[3001:7000,], positive_reviews_all[3001:7000,])
df_imp_8k_f_lap <- df_imp_8k_f_lap[sample(1:nrow(df_imp_8k_f_lap)),]  ## sampling
row.names(df_imp_8k_f_lap) <- NULL


## 10000 reviews = 5000 pos + 5000 neg  : randomly selected the row numbers below
df_imp_10k_f_lap <- rbind(negative_reviews_all[1:5000,], positive_reviews_all[1:5000,])
df_imp_10k_f_lap <- df_imp_10k_f_lap[sample(1:nrow(df_imp_10k_f_lap)),]   ## sampling
row.names(df_imp_10k_f_lap) <- NULL


## 15670 reviews = 7835 pos + 7835 neg  : randomly selected the row numbers below
df_imp_20k_f_lap <- rbind(negative_reviews_all[1:7835,], positive_reviews_all[1:7835,])
df_imp_20k_f_lap <- df_imp_20k_f_lap[sample(1:nrow(df_imp_20k_f_lap)),]   ## sampling
row.names(df_imp_20k_f_lap) <- NULL



tail(df_imp_20k_f_lap)


## saving the files for distributed running on AWS's instances
save(df_imp_2k_f_lap, file = "df_imp_2k_f_lap.Rda")
save(df_imp_4k_f_lap, file = "df_imp_4k_f_lap.Rda")
save(df_imp_6k_f_lap, file = "df_imp_6k_f_lap.Rda")
save(df_imp_8k_f_lap, file = "df_imp_8k_f_lap.Rda")
save(df_imp_10k_f_lap, file = "df_imp_10k_f_lap.Rda")
save(df_imp_20k_f_lap, file = "df_imp_20k_f_lap.Rda")




load("df_imp_Everything.Rda")
head(df_imp_Everything)




############################################################################################################
###########################       Mobile  ###########################

##running it for 2k reviews even though it has already been done in the previous project
## 2000 reviews = 1000 pos + 1000 neg
df_imp_2k_f_mob <- rbind(negative_reviews_all[1:1000,], positive_reviews_all[1:1000,])
df_imp_2k_f_mob <- df_imp_2k_f_mob[sample(1:nrow(df_imp_2k_f_mob)),] ## sampling
row.names(df_imp_2k_f_mob) <- NULL



## 4000 reviews = 2000 pos + 2000 neg
df_imp_4k_f_mob <- rbind(negative_reviews_all[1001:3000,], positive_reviews_all[1001:3000,])
df_imp_4k_f_mob <- df_imp_4k_f_mob[sample(1:nrow(df_imp_4k_f_mob)),]  ## sampling
row.names(df_imp_4k_f_mob) <- NULL


## 6000 reviews = 3000 pos + 3000 neg
df_imp_6k_f_mob <- rbind(negative_reviews_all[1001:4000,], positive_reviews_all[1001:4000,])
df_imp_6k_f_mob <- df_imp_6k_f_mob[sample(1:nrow(df_imp_6k_f_mob)),]  ## sampling
row.names(df_imp_6k_f_mob) <- NULL


## 8000 reviews = 4000 pos + 4000 neg
df_imp_8k_f_mob <- rbind(negative_reviews_all[8001:12000,], positive_reviews_all[8001:12000,])
df_imp_8k_f_mob <- df_imp_8k_f_mob[sample(1:nrow(df_imp_8k_f_mob)),]  ## sampling
row.names(df_imp_8k_f_mob) <- NULL


## 10000 reviews = 5000 pos + 5000 neg  : randomly selected the row numbers below
df_imp_10k_f_mob <- rbind(negative_reviews_all[1:5000,], positive_reviews_all[1:5000,])
df_imp_10k_f_mob <- df_imp_10k_f_mob[sample(1:nrow(df_imp_10k_f_mob)),]   ## sampling
row.names(df_imp_10k_f_mob) <- NULL


## 20000 reviews = 10000 pos + 10000 neg  : randomly selected the row numbers below
df_imp_20k_f_mob <- rbind(negative_reviews_all[5001:15000,], positive_reviews_all[5001:15000,])
df_imp_20k_f_mob <- df_imp_20k_f_mob[sample(1:nrow(df_imp_20k_f_mob)),]   ## sampling
row.names(df_imp_20k_f_mob) <- NULL



tail(df_imp_20k_f_mob)


## saving the files for distributed running on AWS's instances
save(df_imp_2k_f_mob, file = "df_imp_2k_f_mob.Rda")
save(df_imp_4k_f_mob, file = "df_imp_4k_f_mob.Rda")
save(df_imp_6k_f_mob, file = "df_imp_6k_f_mob.Rda")
save(df_imp_8k_f_mob, file = "df_imp_8k_f_mob.Rda")
save(df_imp_10k_f_mob, file = "df_imp_10k_f_mob.Rda")
save(df_imp_20k_f_mob, file = "df_imp_20k_f_mob.Rda")



###############    Load all the datasets  ###################


load("df_imp_8k_f_vs.Rda")
load("df_imp_8k_f_tv.Rda")
load("df_imp_8k_f_tab.Rda")
load("df_imp_8k_f_lap.Rda")
load("df_imp_8k_f_cam.Rda")
load("df_imp_6k_f_vs.Rda")
load("df_imp_6k_f_tv.Rda")
load("df_imp_6k_f_tab.Rda")
load("df_imp_6k_f_lap.Rda")
load("df_imp_6k_f_cam.Rda")
load("df_imp_4k_f_vs.Rda")
load("df_imp_4k_f_tv.Rda")
load("df_imp_4k_f_tab.Rda")
load("df_imp_4k_f_lap.Rda")
load("df_imp_4k_f_cam.Rda")
load("df_imp_2k_f_vs.Rda")
load("df_imp_2k_f_tv.Rda")
load("df_imp_2k_f_tab.Rda")
load("df_imp_2k_f_lap.Rda")
load("df_imp_2k_f_cam.Rda")
load("df_imp_10k_f_vs.Rda")
load("df_imp_10k_f_tv.Rda")
load("df_imp_10k_f_tab.Rda")
load("df_imp_10k_f_lap.Rda")
load("df_imp_10k_f_cam.Rda")
load("df_imp_2k_f_mob.Rda")
load("df_imp_4k_f_mob.Rda")
load("df_imp_6k_f_mob.Rda")
load("df_imp_8k_f_mob.Rda")
load("df_imp_10k_f_mob.Rda")

###################  ###################  ###################

















