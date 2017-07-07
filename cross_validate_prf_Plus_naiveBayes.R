
## This script creates a function which runs the following 10 algorithm on n-fold CV dataset
## Algorithms - "NaiveBayes","SVM", "SLDA", "BOOSTING", "BAGGING", "RF", "GLMNET", "TREE", "NNET", "MAXENT"
## Input - dataframe containing text reviews and ratings
## Output - Precision , Recall, Accuracy and F-score

## Hyper-parameters can be set in this function, however I have selected standard values
## nfold- Number of folds in the Cross-vaidation 
## container - dataset

### Including Naive Bayes Classifier too

require(e1071)


# sample Naive Bayes
# nb_classifier<- naiveBayes(dtm_temp_matrix[1:11,], as.factor(df_imp_firs300[1:11,2]))
# predicted<- predict(nb_classifier, dtm_temp_matrix[12:nrow(dtm_temp_matrix),])


## this custom function will be run to get values from Naive Bayes Algorithms
# custom cross valiate function of R with PRF values
## here I have merged two different functions -- cross_validate and create_precisionRecallSummary
## because original cross_validate doesnt generate PRF values


# rm(cross_validate_prf)



cross_validate_prf_Plus_naiveBayes<- function (container, nfold, algorithm = c("NaiveBayes","SVM", "SLDA", "BOOSTING", 
                                                                               "BAGGING", "RF", "GLMNET", "TREE", "NNET", "MAXENT"), seed = NA, 
                               method = "C-classification", cross = 0, cost = 100, kernel = "radial", 
                               maxitboost = 100, maxitglm = 10^5, size = 1, maxitnnet = 1000, 
                               MaxNWts = 10000, rang = 0.1, decay = 5e-04, ntree = 200, 
                               l1_regularizer = 0, l2_regularizer = 0, use_sgd = FALSE, 
                               set_heldout = 0, verbose = FALSE) 
{
  
  if(require("e1071")==FALSE) install.packages("e1071", repos="http://cran.rstudio.com/")
  require(e1071)
  
  environment(cross_validate) <- environment()
  
  options(warn = -1)
  if (!is.na(seed)) 
    set.seed(seed)
  extract_label_from_prob_names <- function(x) return(rownames(as.matrix(which.max(x))))
  alldata <- rbind(container@training_matrix, container@classification_matrix)
  allcodes <- as.factor(c(container@training_codes, container@testing_codes))
  rand <- sample(nfold, dim(alldata)[1], replace = T)
  
  
  ## here adding custom functions taken from create_precisionRecallSummary
  confusion <- function(true, pred) {
    conf_out <- table(factor(true, levels = sort(unique(true))), 
                      factor(pred, levels = sort(unique(true))))
    return(conf_out)
  }
  precision <- function(confusion) {
    correct <- diag(confusion)
    precision_sums <- colSums(confusion)
    precision_out <- round(correct/precision_sums, 2)
    return(precision_out)
  }
  recall <- function(confusion) {
    correct <- diag(confusion)
    recall_sums <- rowSums(confusion)
    recall_out <- round(correct/recall_sums, 2)
    return(recall_out)
  }
  ## removed b_value variable because its value is always 1, for weighte F score different b_value is selected
  fscore <- function( precision, recall) {   
    B <- 1
    fscore <- ((B^2 + 1) * precision * recall)/((B^2 * precision) + 
                                                  recall)
    return(fscore)
  }
  
  
  cv_accuracy <- NULL
  cv_precision <- NULL
  cv_recall <- NULL
  cv_fscore <- NULL
  
  for (i in sort(unique(rand))) {
    
    tryCatch({                         ## trycatch starts here
      
      
      if (algorithm == "NaiveBayes") {
        
      alldata <- rbind(as.matrix(container@training_matrix), 
                       as.matrix(container@classification_matrix))
      
      colnames(alldata) <- container@column_names
      
      model <- naiveBayes(alldata[rand != i, ], allcodes[rand != i])
      
      pred <- predict(model, alldata[rand == i, ])

      }
      
      else if (algorithm == "SVM") {
        model <- svm(x = alldata[rand != i, ], y = allcodes[rand != 
                                                              i], method = method, cross = cross, cost = cost, 
                     kernel = kernel)
        pred <- predict(model, alldata[rand == i, ])
      }
      else if (algorithm == "SLDA") {
        alldata <- rbind(as.matrix(container@training_matrix), 
                         as.matrix(container@classification_matrix))
        colnames(alldata) <- container@column_names
        data_and_codes <- cbind(as.matrix(alldata), allcodes)
        model <- slda(as.factor(allcodes) ~ ., data = data.frame(data_and_codes[rand != 
                                                                                  i, ]))
        pred <- predict(model, data.frame(alldata[rand == 
                                                    i, ]))
        pred <- as.numeric(pred$class)
      }
      else if (algorithm == "RF") {
        alldata <- rbind(as.matrix(container@training_matrix), 
                         as.matrix(container@classification_matrix))
        data_and_codes <- cbind(alldata, allcodes)
        model <- randomForest(as.factor(allcodes) ~ ., data = data_and_codes[rand != 
                                                                               i, ], ntree = ntree)
        pred <- predict(model, newdata = alldata[rand == 
                                                   i, ])
      }
      else if (algorithm == "GLMNET") {
        sparsedata <- as(as.matrix.csc(alldata[rand != i, 
                                               ]), "dgCMatrix")
        model <- glmnet(x = sparsedata, y = as.vector(allcodes[rand != 
                                                                 i]), family = "multinomial", maxit = maxitglm)
        prob <- predict(model, sparsedata, s = 0.01, type = "response")
        pred <- apply(prob[, , 1], 1, extract_label_from_prob_names)
        pred <- as.numeric(pred)
      }
      else if (algorithm == "BOOSTING") {
        alldata <- rbind(as.matrix(container@training_matrix), 
                         as.matrix(container@classification_matrix))
        colnames(alldata) <- container@column_names
        data_and_codes <- cbind(alldata, allcodes)
        model <- LogitBoost(xlearn = alldata[rand != i, ], 
                            ylearn = allcodes[rand != i], maxitboost)
        pred <- predict(model, data.frame(alldata[rand == 
                                                    i, ]))
      }
      else if (algorithm == "BAGGING") {
        alldata <- rbind(as.matrix(container@training_matrix), 
                         as.matrix(container@classification_matrix))
        data_and_codes <- cbind(alldata, allcodes)
        model <- bagging(as.factor(allcodes) ~ ., data = data.frame(data_and_codes[rand != 
                                                                                     i, ]))
        pred <- predict(model, newdata = alldata[rand == 
                                                   i, ])
      }
      else if (algorithm == "TREE") {
        alldata <- rbind(as.matrix(container@training_matrix), 
                         as.matrix(container@classification_matrix))
        colnames(alldata) <- container@column_names
        data_and_codes <- cbind(alldata, allcodes)
        model <- tree(as.factor(allcodes) ~ ., data = data.frame(data_and_codes[rand != 
                                                                                  i, ]))
        prob <- predict(model, newdata = data.frame(alldata[rand == 
                                                              i, ]), type = "vector")
        pred <- apply(prob, 1, which.max)
      }
      else if (algorithm == "NNET") {
        alldata <- rbind(as.matrix(container@training_matrix), 
                         as.matrix(container@classification_matrix))
        colnames(alldata) <- container@column_names
        data_and_codes <- cbind(alldata, allcodes)
        model <- nnet(as.factor(allcodes) ~ ., data = data.frame(data_and_codes[rand != 
                                                                                  i, ]), size = size, maxit = maxitnnet, MaxNWts = MaxNWts, 
                      rang = rang, decay = decay, trace = FALSE)
        prob <- predict(model, newdata = data.frame(alldata[rand == 
                                                              i, ]))
        pred <- apply(prob, 1, which.max)
      }
      else if (algorithm == "MAXENT") {
        model <- maxent(container@training_matrix, as.vector(container@training_codes), 
                        l1_regularizer, l2_regularizer, use_sgd, set_heldout, 
                        verbose)
        pred <- predict(model, alldata[rand == i, ])
        pred <- pred[, 1]
      }
      
      cv_accuracy[i] <- recall_accuracy(allcodes[rand == i], pred)
      cv_precision[i] <- precision(confusion(allcodes[rand == i], pred))  ## custom stuff
      cv_recall[i] <- recall(confusion(allcodes[rand == i], pred))   ## custom stuff
      cv_fscore[i] <- fscore( cv_precision[i],  cv_recall[i])    ## custom stuff
      
      cat("Fold ", i, " Out of Sample Accuracy", " = ", cv_accuracy[i], 
          "\n", sep = "")
      cat("Fold ", i, " Out of Sample Precision", " = ", cv_precision[i], 
          "\n", sep = "")
      cat("Fold ", i, " Out of Sample Recall", " = ", cv_recall[i], 
          "\n", sep = "")
      cat("Fold ", i, " Out of Sample F-Score", " = ", cv_fscore[i], 
          "\n", sep = "")
      
    }, error=function(e){cat("ERROR :",conditionMessage(e), " - Error at fold number: ", i  , "\n")})  ## trycatch ends here
    
  }
  
  ##     ## customized the output too
  return(list(allFoldAccuracy= cv_accuracy, meanAccuracy = mean(cv_accuracy, na.rm=TRUE), 
              allFoldPrecision= cv_precision, meanPrecision = mean(cv_precision, na.rm=TRUE),
              allFoldRecall= cv_recall, meanRecall = mean(cv_recall, na.rm=TRUE),
              allFoldFscore= cv_fscore, meanFscore = mean(cv_fscore, na.rm=TRUE)))
}



## VIMP: Now I have added the above created custom Function to the RTextTools package's Namespace by assigning it the  Namespace
environment(cross_validate_prf_Plus_naiveBayes) <- asNamespace('RTextTools')  ### most important step in order to add a custom function to an existing package



## few checks
environment(cross_validate)
environment(cross_validate_prf_Plus_naiveBayes)   
loadedNamespaces()



###  please DON'T execute below statements as it will not work
environment(cross_validate_prf) <- as.environment("package:RTextTools")  ## didn't work

fixInNamespace("cross_validate", pos = "package:RTextTools") ## didn't work
cross_validate <- RTextTools:::cross_validate   ## didn't work
























