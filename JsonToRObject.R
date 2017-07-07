
##### combining all (4471) json files of Amazon Mobile Reviews into one file  ####
###  Amazon Mobile Reviews

## assuming all the json files are in this working directory, 
## if not then change the below path and direct it to the directory containint json files

setwd("C:\\Users\\jsasan\\Desktop\\Jasmeet\\R_work\\Data\\AllDatasets\\Six Categories of Amazon Product Reviews\\AmazonReviews\\mobilephone")

install.packages("rjson")
require(rjson)


# Get the files names
jsonFiles <- list.files( pattern="*.json")
head(jsonFiles)

# First apply read.csv, then rbind
myJsonFiles <- do.call("rbind", lapply(jsonFiles, function(x) fromJSON(file=x, method="C", unexpected.escape = "error")))

## below command has given me only review data
reviewOfAlljson<- myJsonFiles[,1]  #### this has been converted to a list from Matrix


## converting list of list into a single list
newjsonAll<- unlist(reviewOfAlljson,recursive = FALSE)

### function to replace null values with NA
nullToNA <- function(x) {
  x[sapply(x, is.null)] <- NA
  return(x)
}

reviewOfAlljsonNA <- lapply( newjsonAll,nullToNA)


###  need to use the function to replace null with NA before executing step below
unlistAlljson<- matrix(unlist(reviewOfAlljsonNA),ncol=6,byrow = TRUE)

### Giving column names to the final data set
colnames(unlistAlljson)<- c("Title","Name","ReviewID","OverAllRating","Content","Date")

### converting matrix into data frame
mobileRevTotal.df<- as.data.frame(unlistAlljson, row.names=NULL, stringsAsFactors = FALSE)

str(mobileRevTotal.df)

#converting character (numeric) to factors (categorical variables)
mobileRevTotal.df$OverAllRating<- as.factor(mobileRevTotal.df$OverAllRating)

# creating the pre-final dataset required for my thesis
mobileRev.df<- mobileRevTotal.df[,c("Title","OverAllRating" ,"Content")]

head(mobileRev.df,6)   ### this looks good now!!

#saving the dataframe in R format
save(mobileRev.df, file="mobileRev.df")

### creating csv, the output csv has 150 rows with some rubbish code in it, need to delete those rows
write.csv(mobileRev.df, file = "mobileRev.csv")

## importing the updated mobileRev,csv after deleting those filthy 150 rows
mobileRevUpdated.df<- read.csv(file="mobileRev_updated.csv",header=TRUE,stringsAsFactors=FALSE)
class(mobileRevUpdated.df$OverAllRating)  ## integer, change it to factor

#converting character (numeric) to factors (categorical variables)
mobileRevUpdated.df$OverAllRating<- as.factor(mobileRevUpdated.df$OverAllRating)

# creating the final dataset required for my thesis containing rating and reviews only
mobileRevContentRating.df<- mobileRevUpdated.df[,c("OverAllRating" ,"Content")]

#saving the dataframe in R format
save(mobileRevContentRating.df, file="mobileRevContentRating.df")

### creating csv, the output csv does not contain 150 bad rows
write.csv(mobileRevContentRating.df, file = "mobileRevContentRating.csv")



#### remove large size files created in between and relax little bit ###
rm(myJsonFiles,reviewOfAlljson,newjsonAll,reviewOfAlljsonNA)
