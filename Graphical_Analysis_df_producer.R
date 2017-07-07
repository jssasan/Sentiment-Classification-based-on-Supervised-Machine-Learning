## this script creates dataframe for graphical analysis of all 6 categories

## COmposite and NUmerical are synonmous

## graphical analysis

require(ggplot2)

## loading the PRF-A files

# => I used AWS for the following scripts to generate PRF-A scores:
#   ug_numerical_features.R : Sparsity was 0.999
# baseline_all_categories.R  : Sparsity was 0.999
# files in the following two folders are being pulled from AWS  
# 1. Baseline_output_AWS 2. UG_Numerical  
# just load them when you do graphical analysis



############

#### for reference purpose only: Start  : this was done in the attempt_3_clean####

## Unigram Features only : This comes from AWS instance and I fogot to save the dataset, so I have created it at the bottom using the csv file 

Baseline_PRF_accuracy_mean_mob_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_mob_2k.csv", 
         header = T,
         sep = ","
         )

Baseline_PRF_accuracy_mean_tab_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_tab_2k.csv", 
                                              header = T,
                                              sep = ","
)

Baseline_PRF_accuracy_mean_tv_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_tv_2k.csv", 
                                              header = T,
                                              sep = ","
)

Baseline_PRF_accuracy_mean_vs_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_vs_2k.csv", 
                                              header = T,
                                              sep = ","
)

Baseline_PRF_accuracy_mean_lap_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_lap_2k.csv", 
                                              header = T,
                                              sep = ","
)

Baseline_PRF_accuracy_mean_cam_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_cam_2k.csv", 
                                              header = T,
                                              sep = ","
)



## saving above shit in my directory
save(Baseline_PRF_accuracy_mean_mob_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_mob_2k.Rda")
save(Baseline_PRF_accuracy_mean_tab_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_tab_2k.Rda")
save(Baseline_PRF_accuracy_mean_tv_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_tv_2k.Rda")
save(Baseline_PRF_accuracy_mean_vs_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_vs_2k.Rda")
save(Baseline_PRF_accuracy_mean_lap_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_lap_2k.Rda")
save(Baseline_PRF_accuracy_mean_cam_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Baseline_output_AWS/Baseline_PRF_accuracy_mean_cam_2k.Rda")


#### for reference purpose only: Start  :


(Baseline_PRF_accuracy_mean_lap_2k)
(Baseline_PRF_accuracy_mean_vs_2k)
(Baseline_PRF_accuracy_mean_tv_2k)
(Baseline_PRF_accuracy_mean_tab_2k)
(Baseline_PRF_accuracy_mean_mob_2k)
(Baseline_PRF_accuracy_mean_cam_2k)



############

### loading UG-Composite PRF-A dataset : there is a catch here: the name of the dataset and the actual file are different so renaming them here: so when I
## load data it, the name will be different i.e. algo_runner_ug_composite_f300: I should have named it different

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UG_Numerical/UG_Composite_PRF_accuracy_mean_cam_2k.Rda")
UG_Composite_PRF_accuracy_mean_cam_2k <- algo_runner_ug_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UG_Numerical/UG_Composite_PRF_accuracy_mean_lap_2k.Rda")
UG_Composite_PRF_accuracy_mean_lap_2k <- algo_runner_ug_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UG_Numerical/UG_Composite_PRF_accuracy_mean_mob_2k.Rda")
UG_Composite_PRF_accuracy_mean_mob_2k <- algo_runner_ug_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UG_Numerical/UG_Composite_PRF_accuracy_mean_tab_2k.Rda")
UG_Composite_PRF_accuracy_mean_tab_2k <- algo_runner_ug_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UG_Numerical/UG_Composite_PRF_accuracy_mean_tv_2k.Rda")
UG_Composite_PRF_accuracy_mean_tv_2k <- algo_runner_ug_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UG_Numerical/UG_Composite_PRF_accuracy_mean_vs_2k.Rda")
UG_Composite_PRF_accuracy_mean_vs_2k <-algo_runner_ug_composite_f300

rm(algo_runner_ug_composite_f300)

UG_Composite_PRF_accuracy_mean_cam_2k
UG_Composite_PRF_accuracy_mean_lap_2k
UG_Composite_PRF_accuracy_mean_mob_2k
UG_Composite_PRF_accuracy_mean_tab_2k
UG_Composite_PRF_accuracy_mean_tv_2k
UG_Composite_PRF_accuracy_mean_vs_2k


###########
### loading UGBG PRF-A dataset :  there is a catch here: the name of the dataset and the actual file are different so renaming them here: so when I
## load data it, the name will be different i.e. algo_runner_ug_composite_f300: I should have named it different

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBG/UGBG_PRF_accuracy_mean_cam_2k.Rda")
UGBG_PRF_accuracy_mean_cam_2k <- algo_runner_ugbg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBG/UGBG_PRF_accuracy_mean_lap_2k.Rda")
UGBG_PRF_accuracy_mean_lap_2k <- algo_runner_ugbg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBG/UGBG_PRF_accuracy_mean_mob_2k.Rda")
UGBG_PRF_accuracy_mean_mob_2k <- algo_runner_ugbg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBG/UGBG_PRF_accuracy_mean_tab_2k.Rda")
UGBG_PRF_accuracy_mean_tab_2k <- algo_runner_ugbg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBG/UGBG_PRF_accuracy_mean_tv_2k.Rda")
UGBG_PRF_accuracy_mean_tv_2k <- algo_runner_ugbg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBG/UGBG_PRF_accuracy_mean_vs_2k.Rda")
UGBG_PRF_accuracy_mean_vs_2k <- algo_runner_ugbg_f300

rm(algo_runner_ugbg_f300)

UGBG_PRF_accuracy_mean_cam_2k
UGBG_PRF_accuracy_mean_lap_2k
UGBG_PRF_accuracy_mean_mob_2k
UGBG_PRF_accuracy_mean_tab_2k
UGBG_PRF_accuracy_mean_tv_2k
UGBG_PRF_accuracy_mean_vs_2k


###########
### loading UGBGTG PRF-A dataset : 

###########
### loading UGBGTG PRF-A dataset : 

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBGTG/UGBGTG_PRF_accuracy_mean_cam_2k.Rda")
UGBGTG_PRF_accuracy_mean_cam_2k <- algo_runner_ugbgtg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBGTG/UGBGTG_PRF_accuracy_mean_lap_2k.Rda")
UGBGTG_PRF_accuracy_mean_lap_2k <- algo_runner_ugbgtg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBGTG/UGBGTG_PRF_accuracy_mean_mob_2k.Rda")
UGBGTG_PRF_accuracy_mean_mob_2k <- algo_runner_ugbgtg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBGTG/UGBGTG_PRF_accuracy_mean_tab_2k.Rda")
UGBGTG_PRF_accuracy_mean_tab_2k <- algo_runner_ugbgtg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBGTG/UGBGTG_PRF_accuracy_mean_tv_2k.Rda")
UGBGTG_PRF_accuracy_mean_tv_2k <- algo_runner_ugbgtg_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/UGBGTG/UGBGTG_PRF_accuracy_mean_vs_2k.Rda")
UGBGTG_PRF_accuracy_mean_vs_2k <- algo_runner_ugbgtg_f300

rm(algo_runner_ugbgtg_f300)

UGBGTG_PRF_accuracy_mean_cam_2k
UGBGTG_PRF_accuracy_mean_lap_2k
UGBGTG_PRF_accuracy_mean_mob_2k
UGBGTG_PRF_accuracy_mean_tab_2k
UGBGTG_PRF_accuracy_mean_tv_2k
UGBGTG_PRF_accuracy_mean_tv_2k




###########
### loading UGBGTG-Composite PRF-A dataset : 

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/ugbgtg_Numerical/UGBGTG_Composite_PRF_accuracy_mean_cam_2k.Rda")
UGBGTG_Composite_PRF_accuracy_mean_cam_2k <- algo_runner_ugbgtg_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/ugbgtg_Numerical/UGBGTG_Composite_PRF_accuracy_mean_lap_2k.Rda")
UGBGTG_Composite_PRF_accuracy_mean_lap_2k <- algo_runner_ugbgtg_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/ugbgtg_Numerical/UGBGTG_Composite_PRF_accuracy_mean_mob_2k.Rda")
UGBGTG_Composite_PRF_accuracy_mean_mob_2k <- algo_runner_ugbgtg_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/ugbgtg_Numerical/UGBGTG_Composite_PRF_accuracy_mean_tab_2k.Rda")
UGBGTG_Composite_PRF_accuracy_mean_tab_2k <- algo_runner_ugbgtg_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/ugbgtg_Numerical/UGBGTG_Composite_PRF_accuracy_mean_tv_2k.Rda")
UGBGTG_Composite_PRF_accuracy_mean_tv_2k <- algo_runner_ugbgtg_composite_f300

load("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/ugbgtg_Numerical/UGBGTG_Composite_PRF_accuracy_mean_vs_2k.Rda")
UGBGTG_Composite_PRF_accuracy_mean_vs_2k <- algo_runner_ugbgtg_composite_f300

rm(algo_runner_ugbgtg_composite_f300)

UGBGTG_Composite_PRF_accuracy_mean_cam_2k
UGBGTG_Composite_PRF_accuracy_mean_lap_2k
UGBGTG_Composite_PRF_accuracy_mean_mob_2k
UGBGTG_Composite_PRF_accuracy_mean_tab_2k
UGBGTG_Composite_PRF_accuracy_mean_tv_2k
UGBGTG_Composite_PRF_accuracy_mean_tv_2k




###########
## Numerical Features only : This comes from AWS instance and I fogot to save the dataset, so I have created it at the bottom using the csv file 

Numerical_Feaetures_PRF_accuracy_mean_mob_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/PRF_accuracy_mean_mob_2k.csv", 
                                                         header = T,
                                                         sep = ","
)

Numerical_Feaetures_PRF_accuracy_mean_tab_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/PRF_accuracy_mean_tab_2k.csv", 
                                                         header = T,
                                                         sep = ","
)

Numerical_Feaetures_PRF_accuracy_mean_tv_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/PRF_accuracy_mean_tv_2k.csv", 
                                                        header = T,
                                                        sep = ","
)

Numerical_Feaetures_PRF_accuracy_mean_vs_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/PRF_accuracy_mean_vs_2k.csv", 
                                                        header = T,
                                                        sep = ","
)

Numerical_Feaetures_PRF_accuracy_mean_lap_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/PRF_accuracy_mean_lap_2k.csv", 
                                                         header = T,
                                                         sep = ","
)

Numerical_Feaetures_PRF_accuracy_mean_cam_2k <- read.csv("C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/PRF_accuracy_mean_cam_2k.csv", 
                                                         header = T,
                                                         sep = ","
)


## saving above shit in my directory
save(Numerical_Feaetures_PRF_accuracy_mean_mob_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/Numerical_Feaetures_PRF_accuracy_mean_mob_2k.Rda")
save(Numerical_Feaetures_PRF_accuracy_mean_tab_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/Numerical_Feaetures_PRF_accuracy_mean_tab_2k.Rda")
save(Numerical_Feaetures_PRF_accuracy_mean_tv_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/Numerical_Feaetures_PRF_accuracy_mean_tv_2k.Rda")
save(Numerical_Feaetures_PRF_accuracy_mean_vs_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/Numerical_Feaetures_PRF_accuracy_mean_vs_2k.Rda")
save(Numerical_Feaetures_PRF_accuracy_mean_lap_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/Numerical_Feaetures_PRF_accuracy_mean_lap_2k.Rda")
save(Numerical_Feaetures_PRF_accuracy_mean_cam_2k, file = "C:/Users/jsasan/Desktop/Jasmeet/Thesis/Thesis_NewStart/R_work/Text_Full/Attempt_3_clean/Composite_Numerical_Features_Outputs/Numerical_Feaetures_PRF_accuracy_mean_cam_2k.Rda")


Numerical_Feaetures_PRF_accuracy_mean_lap_2k
Numerical_Feaetures_PRF_accuracy_mean_vs_2k
Numerical_Feaetures_PRF_accuracy_mean_tv_2k
Numerical_Feaetures_PRF_accuracy_mean_tab_2k
Numerical_Feaetures_PRF_accuracy_mean_mob_2k
Numerical_Feaetures_PRF_accuracy_mean_cam_2k


#############
## Final image with all the Graphical Analysis including 

save.image("All_The_Way_Final_Thesis.RData")

