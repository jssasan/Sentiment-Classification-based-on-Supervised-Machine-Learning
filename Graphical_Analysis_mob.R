### this script Generates graph for mobile category


## the father package of all plotting shit
require(ggplot2)
install.packages("ggrepel") 
library("ggrepel")

## setting up directory for the plots

setwd("C:/Users/jsasan/Desktop/Jasmeet/R_work/Text_Full/Attempt_3_clean/Analysis/Plots/Mobile")


##  there are six different runs: sample of mobile PRF-A for different features-sets
Baseline_PRF_accuracy_mean_mob_2k
UG_Composite_PRF_accuracy_mean_mob_2k
UGBG_PRF_accuracy_mean_mob_2k
UGBGTG_PRF_accuracy_mean_mob_2k
UGBGTG_Composite_PRF_accuracy_mean_mob_2k
Numerical_Feaetures_PRF_accuracy_mean_mob_2k

## experimenting with mobile category

Sample_Baseline_PRF_accuracy_mean_mob_2k  <- Baseline_PRF_accuracy_mean_mob_2k
Sample_UG_Composite_PRF_accuracy_mean_mob_2k <- UG_Composite_PRF_accuracy_mean_mob_2k
Sample_UGBG_PRF_accuracy_mean_mob_2k  <- UGBG_PRF_accuracy_mean_mob_2k
Sample_UGBGTG_PRF_accuracy_mean_mob_2k <- UGBGTG_PRF_accuracy_mean_mob_2k
Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k  <- UGBGTG_Composite_PRF_accuracy_mean_mob_2k
Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k  <- Numerical_Feaetures_PRF_accuracy_mean_mob_2k


Sample_Baseline_PRF_accuracy_mean_mob_2k$Category <- "Mobile"
Sample_UG_Composite_PRF_accuracy_mean_mob_2k$Category <- "Mobile"
Sample_UGBG_PRF_accuracy_mean_mob_2k$Category <- "Mobile"
Sample_UGBGTG_PRF_accuracy_mean_mob_2k$Category <- "Mobile"
Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k$Category <- "Mobile"
Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k$Category <- "Mobile"


Sample_Baseline_PRF_accuracy_mean_mob_2k$Feature_Types <- "Unigram"
Sample_UG_Composite_PRF_accuracy_mean_mob_2k$Feature_Types <- "Unigram_Composite"
Sample_UGBG_PRF_accuracy_mean_mob_2k$Feature_Types <- "Unigram_Bigram"
Sample_UGBGTG_PRF_accuracy_mean_mob_2k$Feature_Types <- "Unigram_Bigram_Trigram"
Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k$Feature_Types <- "Unigram_Bigram_Trigram_Composite"
Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k$Feature_Types <- "Numerical"




## function to reshape the PRF-A datasets and make it good for easy graphing

column_splitter <- function(dataset){
  
  temp_1<- data.frame(do.call('rbind', strsplit(as.character(dataset$Performance_Metric) , '.', fixed = TRUE)))
  
  temp_2 <- data.frame(do.call('rbind', strsplit(as.character(temp_1$X1) , '_', fixed = TRUE)))
  
  temp<- cbind("Algorithm" = temp_2$X2, "Performance_Metric_New" = temp_1$X2 ,dataset)
  
  return(temp)
  
}


## applying the above function
Sample_Baseline_PRF_accuracy_mean_mob_2k<- column_splitter(dataset = Sample_Baseline_PRF_accuracy_mean_mob_2k)
Sample_Baseline_PRF_accuracy_mean_mob_2k <- Sample_Baseline_PRF_accuracy_mean_mob_2k[,-3]  ## deleting shit

Sample_UG_Composite_PRF_accuracy_mean_mob_2k<- column_splitter(dataset = Sample_UG_Composite_PRF_accuracy_mean_mob_2k)

Sample_UGBG_PRF_accuracy_mean_mob_2k<- column_splitter(dataset = Sample_UGBG_PRF_accuracy_mean_mob_2k)

Sample_UGBGTG_PRF_accuracy_mean_mob_2k<- column_splitter(dataset = Sample_UGBGTG_PRF_accuracy_mean_mob_2k)

Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k<- column_splitter(dataset = Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k)

Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k<- column_splitter(dataset = Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k)
## dviding the numerical features into the respective type that is neg_pos, Part_pf_speech adn composite

Sample_NegPos_Numerical_Feaetures_PRF_accuracy_mean_mob_2k <- cbind(Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,c(1,2,4)], 
                                                                    Baseline_SCore= Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,5],
                                                                    Category= "Mobile",
                                                                    Feature_Types= "Neg_Pos")

Sample_POS_Numerical_Feaetures_PRF_accuracy_mean_mob_2k <- cbind(Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,c(1,2,4)], 
                                                                 Baseline_SCore= Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,6],
                                                                 Category= "Mobile",
                                                                 Feature_Types= "Part_Of_Speech")

Sample_Composite_Numerical_Feaetures_PRF_accuracy_mean_mob_2k <- cbind(Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,c(1,2,4)], 
                                                                       Baseline_SCore= Sample_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,7],
                                                                       Category= "Mobile",
                                                                       Feature_Types= "Composite_Numerical")



colnames(Sample_Baseline_PRF_accuracy_mean_mob_2k)
colnames(Sample_UG_Composite_PRF_accuracy_mean_mob_2k)
colnames(Sample_UGBG_PRF_accuracy_mean_mob_2k)
colnames(Sample_UGBGTG_PRF_accuracy_mean_mob_2k)
colnames(Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k)
colnames(Sample_NegPos_Numerical_Feaetures_PRF_accuracy_mean_mob_2k)
colnames(Sample_POS_Numerical_Feaetures_PRF_accuracy_mean_mob_2k)
colnames(Sample_Composite_Numerical_Feaetures_PRF_accuracy_mean_mob_2k)


#######################################################################################################################################
### this is the final-final dataset
#######################################################################################################################################

## the final Mobile Dataset for all types of features -- This is the long format
Mobile_PRF_A_Final_Datase_Long <- rbind(Sample_Baseline_PRF_accuracy_mean_mob_2k,Sample_UG_Composite_PRF_accuracy_mean_mob_2k,
                                        Sample_UGBG_PRF_accuracy_mean_mob_2k, Sample_UGBGTG_PRF_accuracy_mean_mob_2k,
                                        Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k, 
                                        Sample_NegPos_Numerical_Feaetures_PRF_accuracy_mean_mob_2k,
                                        Sample_POS_Numerical_Feaetures_PRF_accuracy_mean_mob_2k,
                                        Sample_Composite_Numerical_Feaetures_PRF_accuracy_mean_mob_2k
)

Mobile_PRF_A_Final_Datase_Long
write.csv(Mobile_PRF_A_Final_Datase_Long, file = "Mobile_PRF_A_Final_Datase_Long.csv")

# check if all Performance Metric Columns are same or not

identical(Sample_Baseline_PRF_accuracy_mean_mob_2k[,2],Sample_UG_Composite_PRF_accuracy_mean_mob_2k[,2])
identical(Sample_UGBG_PRF_accuracy_mean_mob_2k[,2], Sample_UGBGTG_PRF_accuracy_mean_mob_2k[,2])
identical(Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k[,2],      Sample_NegPos_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,2])
identical(Sample_POS_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,1],Sample_Composite_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,1])

## the final Mobile Dataset for all types of features -- This is the wide format
Mobile_PRF_A_Final_Datase_Wide <- cbind(Sample_Baseline_PRF_accuracy_mean_mob_2k[,1:3], 
                                        Unigram = Sample_Baseline_PRF_accuracy_mean_mob_2k[,4],
                                        Unigram_Composite = Sample_UG_Composite_PRF_accuracy_mean_mob_2k[,4],
                                        Unigram_Bigram= Sample_UGBG_PRF_accuracy_mean_mob_2k[,4],
                                        Unigram_Bigram_Trigram= Sample_UGBGTG_PRF_accuracy_mean_mob_2k[,4],
                                        Unigram_Bigram_Trigram_Composite = Sample_UGBGTG_Composite_PRF_accuracy_mean_mob_2k[,4], 
                                        Neg_Pos = Sample_NegPos_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,4],
                                        Part_Of_Speech = Sample_POS_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,4],
                                        Composite_Numerical = Sample_Composite_Numerical_Feaetures_PRF_accuracy_mean_mob_2k[,4]
)


head(Mobile_PRF_A_Final_Datase_Wide)

write.csv(Mobile_PRF_A_Final_Datase_Wide, file = "Mobile_PRF_A_Final_Datase_Wide.csv")




## function to generate the plots
plot_generator <- function(plot_variable, plot_name){
  
  png(paste(plot_name,".png",sep=""), width = 11, height = 6, units = "in", res=400)
  par(mfrow= c(2,1))
  plot_variable
  # dev.off()
  
  ## brofre calling this function please set the working directory for plots to be save in the right directory
  ## while calling the functions: keep the plot_name same as plot_variable but in quotes
}


head(Mobile_PRF_A_Final_Datase_Long)

unique(x_data_A$Feature_Types)


x_data <- Mobile_PRF_A_Final_Datase_Long
x_data$Baseline_SCore <- round(x_data$Baseline_SCore*100, digits = 5)
head(x_data)
x_data_A <- subset(x_data, Performance_Metric_New %in% c("meanAccuracy"))
x_data_P <- subset(x_data, Performance_Metric_New %in% c("meanPrecision"))
x_data_R <- subset(x_data, Performance_Metric_New %in% c("meanRecall"))
x_data_F <- subset(x_data, Performance_Metric_New %in% c("meanFscore"))

#########  plotting starts here #######




#### plots of Numerical Features  ####

Acc_Numerical_Plot_mob <- ggplot(subset(x_data_A, Feature_Types %in% c("Neg_Pos", "Part_Of_Speech" , "Composite_Numerical")), 
                                 aes(x=Algorithm, y=Baseline_SCore, 
                                     colour=Feature_Types,
                                     group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Accuracy : Numerical Features - Mobile") +
  labs(y=" % Accuracy",x="Algorithm") 


Prec_Numerical_Plot_mob <- ggplot(subset(x_data_P, Feature_Types %in% c("Neg_Pos", "Part_Of_Speech" , "Composite_Numerical")), 
                                  aes(x=Algorithm, y=Baseline_SCore, 
                                      colour=Feature_Types,
                                      group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Precision : Numerical Features- Mobile") +
  labs(y=" % Precision",x="Algorithm") 


Rec_Numerical_Plot_mob <- ggplot(subset(x_data_R, Feature_Types %in% c("Neg_Pos", "Part_Of_Speech" , "Composite_Numerical")), 
                                 aes(x=Algorithm, y=Baseline_SCore, 
                                     colour=Feature_Types,
                                     group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Recall : Numerical Features- Mobile") +
  labs(y=" % Recall",x="Algorithm") 


FScore_Numerical_Plot_mob <- ggplot(subset(x_data_F, Feature_Types %in% c("Neg_Pos", "Part_Of_Speech" , "Composite_Numerical")), 
                                    aes(x=Algorithm, y=Baseline_SCore, 
                                        colour=Feature_Types,
                                        group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("F-Score : Numerical Features- Mobile") +
  labs(y="F-Score",x="Algorithm") 


## all plots
Acc_Numerical_Plot_mob
Prec_Numerical_Plot_mob
Rec_Numerical_Plot_mob
FScore_Numerical_Plot_mob

plot_generator(plot_variable =  Acc_Numerical_Plot_mob , plot_name = "Acc_Numerical_Plot_mob")
dev.off()

plot_generator(plot_variable =  Prec_Numerical_Plot_mob , plot_name ="Prec_Numerical_Plot_mob" )
dev.off()


plot_generator(plot_variable =  Rec_Numerical_Plot_mob , plot_name = "Rec_Numerical_Plot_mob")
dev.off()


plot_generator(plot_variable =  FScore_Numerical_Plot_mob , plot_name = "FScore_Numerical_Plot_mob")
dev.off()

##############
### Plots of n-gram Features  ###



Acc_ngram_Plot_mob <- ggplot(subset(x_data_A, Feature_Types %in% c("Unigram", "Unigram_Bigram" , "Unigram_Bigram_Trigram")), 
                             aes(x=Algorithm, y=Baseline_SCore, 
                                 colour=Feature_Types,
                                 group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Accuracy : ngram Features- Mobile") +
  labs(y=" % Accuracy",x="Algorithm") 


Prec_ngram_Plot_mob <- ggplot(subset(x_data_P, Feature_Types %in% c("Unigram", "Unigram_Bigram" , "Unigram_Bigram_Trigram")), 
                              aes(x=Algorithm, y=Baseline_SCore, 
                                  colour=Feature_Types,
                                  group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Precision : ngram Features- Mobile") +
  labs(y=" % Precision",x="Algorithm") 


Rec_ngram_Plot_mob <- ggplot(subset(x_data_R, Feature_Types %in% c("Unigram", "Unigram_Bigram" , "Unigram_Bigram_Trigram")), 
                             aes(x=Algorithm, y=Baseline_SCore, 
                                 colour=Feature_Types,
                                 group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Recall : ngram Features- Mobile") +
  labs(y=" % Recall",x="Algorithm") 


FScore_ngram_Plot_mob <- ggplot(subset(x_data_F, Feature_Types %in% c("Unigram", "Unigram_Bigram" , "Unigram_Bigram_Trigram")), 
                                aes(x=Algorithm, y=Baseline_SCore, 
                                    colour=Feature_Types,
                                    group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("F-Score : ngram Features- Mobile") +
  labs(y="F-Score",x="Algorithm") 


## all plots
Acc_ngram_Plot_mob
Prec_ngram_Plot_mob
Rec_ngram_Plot_mob
FScore_ngram_Plot_mob


plot_generator(plot_variable =  Acc_ngram_Plot_mob , plot_name = "Acc_ngram_Plot_mob")
dev.off()

plot_generator(plot_variable =  Prec_ngram_Plot_mob , plot_name =  "Prec_ngram_Plot_mob" )
dev.off()


plot_generator(plot_variable = Rec_ngram_Plot_mob  , plot_name = "Rec_ngram_Plot_mob")
dev.off()


plot_generator(plot_variable = FScore_ngram_Plot_mob  , plot_name = "FScore_ngram_Plot_mob")
dev.off()



##############
### Plots of n-gram + Numerical Features  ###



Acc_ngram_numerical_Plot_mob <- ggplot(subset(x_data_A, Feature_Types %in% c("Unigram", "Unigram_Composite" , "Unigram_Bigram_Trigram_Composite")), 
                                       aes(x=Algorithm, y=Baseline_SCore, 
                                           colour=Feature_Types,
                                           group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Accuracy :  ngram + Numerical Features- Mobile") +
  labs(y=" % Accuracy",x="Algorithm") 


Prec_ngram_numerical_Plot_mob <- ggplot(subset(x_data_P, Feature_Types %in% c("Unigram", "Unigram_Composite" , "Unigram_Bigram_Trigram_Composite")), 
                                        aes(x=Algorithm, y=Baseline_SCore, 
                                            colour=Feature_Types,
                                            group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Precision :  ngram + Numerical Features- Mobile") +
  labs(y=" % Precision",x="Algorithm") 


Rec_ngram_numerical_Plot_mob <- ggplot(subset(x_data_R, Feature_Types %in% c("Unigram", "Unigram_Composite" , "Unigram_Bigram_Trigram_Composite")), 
                                       aes(x=Algorithm, y=Baseline_SCore, 
                                           colour=Feature_Types,
                                           group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Recall :  ngram + Numerical Features- Mobile") +
  labs(y=" % Recall",x="Algorithm") 


FScore_ngram_numerical_Plot_mob <- ggplot(subset(x_data_F, Feature_Types %in% c("Unigram", "Unigram_Composite" , "Unigram_Bigram_Trigram_Composite")), 
                                          aes(x=Algorithm, y=Baseline_SCore, 
                                              colour=Feature_Types,
                                              group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("F-Score : ngram + Numerical Features- Mobile") +
  labs(y="F-Score",x="Algorithm") 



## all plots
Acc_ngram_numerical_Plot_mob
Prec_ngram_numerical_Plot_mob
Rec_ngram_numerical_Plot_mob
FScore_ngram_numerical_Plot_mob

plot_generator(plot_variable = Acc_ngram_numerical_Plot_mob  , plot_name = "Acc_ngram_numerical_Plot_mob")
dev.off()

plot_generator(plot_variable =  Prec_ngram_numerical_Plot_mob , plot_name = "Prec_ngram_numerical_Plot_mob")
dev.off()


plot_generator(plot_variable =  Rec_ngram_numerical_Plot_mob , plot_name = "Rec_ngram_numerical_Plot_mob" )
dev.off()


plot_generator(plot_variable =  FScore_ngram_numerical_Plot_mob , plot_name = "FScore_ngram_numerical_Plot_mob")
dev.off()


##############
### Plots of All Features  ###



Acc_All_Features_Plot_mob <- ggplot(x_data_A, 
                                    aes(x=Algorithm, y=Baseline_SCore, 
                                        colour=Feature_Types,
                                        group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Accuracy : All Features- Mobile") +
  labs(y=" % Accuracy",x="Algorithm") 


Prec_All_Features_Plot_mob <- ggplot(x_data_P, 
                                     aes(x=Algorithm, y=Baseline_SCore, 
                                         colour=Feature_Types,
                                         group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Precision : All Features- Mobile") +
  labs(y=" % Precision",x="Algorithm") 


Rec_All_Features__Plot_mob <- ggplot(x_data_R, 
                                     aes(x=Algorithm, y=Baseline_SCore, 
                                         colour=Feature_Types,
                                         group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("Recall :  All Features- Mobile") +
  labs(y=" % Recall",x="Algorithm") 


FScore_All_Features_Plot_mob <- ggplot(x_data_F, 
                                       aes(x=Algorithm, y=Baseline_SCore, 
                                           colour=Feature_Types,
                                           group=(Feature_Types))
) + 
  geom_point() + 
  geom_line(aes( group=(Feature_Types)), size=1) +
  geom_text_repel(aes(label= Baseline_SCore), size = 3)+
  ggtitle("F-Score : All Features- Mobile") +
  labs(y="F-Score",x="Algorithm") 


## all plots
Acc_All_Features_Plot_mob
Prec_All_Features_Plot_mob
Rec_All_Features__Plot_mob
FScore_All_Features_Plot_mob


plot_generator(plot_variable = Acc_All_Features_Plot_mob  , plot_name = "Acc_All_Features_Plot_mob")
dev.off()

plot_generator(plot_variable =  Prec_All_Features_Plot_mob , plot_name ="Prec_All_Features_Plot_mob" )
dev.off()


plot_generator(plot_variable = Rec_All_Features__Plot_mob  , plot_name = "Rec_All_Features__Plot_mob")
dev.off()


plot_generator(plot_variable =  FScore_All_Features_Plot_mob , plot_name = "FScore_All_Features_Plot_mob")
dev.off()





graphics.off()
