

## creates a function which creates semantic-oriented features based on the positive and negative lexicon






########################################################################################################################
########################################################################################################################
## functin starts here ##

sem_ori_features<- function(sentence, positive_lexicon, negative_lexicon, sample_temp_index= NULL){
  
  
  str <- sentence
  
  str[is.na(str)]<- "zero review" 
  
  # clean up sentences with R's regex-driven global substitute, gsub():
  str  <- tolower(str)
  str <- removeNumbers(str)
  str<- retain_not_words(str) ## this is awesome function  -- creted in the ngram.R script
  str <- gsub('[[:punct:]]', ' ', str )
  str <- gsub('[[:cntrl:]]', '', str)
  str <- stripWhitespace(str)
  
  
  # split into words. str_split is in the stringr package
  word.list <- str_split(str, '\\s+')
  
  # sometimes a list() is one level of hierarchy too much
  words <- unlist(word.list)
  
  p_match <- match(words, positive_lexicon) ##  positive lexicon
  p_match[p_match>0]<- 1
  p_match[is.na(p_match)] <- 0
  n_match <- match(words, c(negative_lexicon,"not")) ## negative lexicon plus not
  n_match[n_match>0]<- -1
  n_match[is.na(n_match)] <- 0
  
  p_sum<- sum(p_match)
  n_sum<- sum(n_match)
  net_SO_score<- p_sum + n_sum
  
  
  # p_match<- as.numeric(gsub(1, replacement = 1, x = p_match))
  # n_match<- as.numeric(gsub(1, replacement = -1, x = n_match))
  sample_temp_index <- p_match + n_match
  
  
  
  
  
  # return(sample_temp_index)  ## if you uncomment this then above function will return  just sample_temp_index .
  ### till above : there is neat implementation of how to detect negative and positive words and set their respective bits
  
  # }   ## if you uncomment this then a separate function will be created till above.
  
  
  ### below is the continuation of other part: this part of the function creates semantic Orientation based-
  ### features based on distance between positive and negative words   
  
  
  # sem_ori_features_2<- function(Semantic_Oriented_sentence){  ## if you uncomment this then a separate function will be created.
  
  
  ### counters need to set to zero for every new text review/document
  
  senti_ctr_pos_pos_1 <- 0
  senti_ctr_neg_neg_1 <- 0
  senti_ctr_pos_pos_2 <- 0
  senti_ctr_neg_neg_2 <- 0
  senti_ctr_pos_pos_3 <- 0
  senti_ctr_neg_neg_3 <- 0
  
  senti_ctr_pos_neg_1 <-0
  senti_ctr_neg_pos_1 <-0
  senti_ctr_pos_neg_2 <-0
  senti_ctr_neg_pos_2 <-0
  senti_ctr_pos_neg_3 <-0
  senti_ctr_neg_pos_3 <-0
  
  
  # sample_temp_index <- Semantic_Oriented_sentence
  
  # print(sample_temp_index)  ## good for debugging
  
  for(i in 1:(length(sample_temp_index))){
    
    
    if (length(sample_temp_index)>0 & (!is.null(sample_temp_index[i]))  ){    ### CORE CONDITION ##
      
      ## case-1                                        ## so here are below if condition clauses: first I am checking if the values I am comparing in the if statement are NULL, if yes, then that will not be executed because null values cannot be compared, second thing: I am checking if the two values at different index are equal or not, Third Condition: checking against stack overflow i.e. if should return false if there are no more elements to compare
      if (  (!is.null(sample_temp_index[i+1])) & (i<length(sample_temp_index))){
        if((sample_temp_index[i]==sample_temp_index[i+1]) ){  
          
          if(sample_temp_index[i]==1 ){
            senti_ctr_pos_pos_1= senti_ctr_pos_pos_1 + 1
          }
          else if (sample_temp_index[i]== -1){
            senti_ctr_neg_neg_1= senti_ctr_neg_neg_1 + 1
          }
        }
      }
      ## case-2
      if (  (!is.null(sample_temp_index[i+2])) & (i<(length(sample_temp_index)-1)) ){
        if((sample_temp_index[i]==sample_temp_index[i+2])   ){
          
          if(sample_temp_index[i]==1 ){
            senti_ctr_pos_pos_2= senti_ctr_pos_pos_2 + 1
          }
          else if (sample_temp_index[i]== -1){
            senti_ctr_neg_neg_2= senti_ctr_neg_neg_2 + 1
          }
        }
      }
      ## case-3
      if ( (!is.null(sample_temp_index[i+3]))  & (i<(length(sample_temp_index)-2)) ){
        if((sample_temp_index[i]==sample_temp_index[i+3])   ){
          
          if(sample_temp_index[i]==1 ){
            senti_ctr_pos_pos_3= senti_ctr_pos_pos_3 + 1
          }
          else if (sample_temp_index[i]== -1){
            senti_ctr_neg_neg_3= senti_ctr_neg_neg_3 + 1
          }
        }
      }
      ## only execute if dealing with positive or negative words (non zero) i,e, !=0
      if (sample_temp_index[i]!= 0  ) {
        
        ## case-4
        if ( (!is.null(sample_temp_index[i+1]))  & (i<length(sample_temp_index)) ){
          if((sample_temp_index[i+1]!= 0) & (sample_temp_index[i]!=sample_temp_index[i+1])  ){
            
            if(sample_temp_index[i]==1 ){
              senti_ctr_pos_neg_1= senti_ctr_pos_neg_1 + 1
            }
            else if (sample_temp_index[i]== -1){
              senti_ctr_neg_pos_1= senti_ctr_neg_pos_1 + 1
            }
          }
        }
        ## case-5
        if ( (!is.null(sample_temp_index[i+2])) & (i<(length(sample_temp_index)-1)) ){
          if((sample_temp_index[i+2]!= 0) & (sample_temp_index[i]!=sample_temp_index[i+2])   ){
            
            if(sample_temp_index[i]==1 ){
              senti_ctr_pos_neg_2= senti_ctr_pos_neg_2 + 1
            }
            else if (sample_temp_index[i]== -1){
              senti_ctr_neg_pos_2= senti_ctr_neg_pos_2 + 1
            }
          }
        }
        ## case-6
        if (  (!is.null(sample_temp_index[i+3])) & (i<(length(sample_temp_index)-2)) ){
          if((sample_temp_index[i+3]!= 0) & (sample_temp_index[i]!=sample_temp_index[i+3])   ){
            
            if(sample_temp_index[i]==1 ){
              senti_ctr_pos_neg_3= senti_ctr_pos_neg_3 + 1
            }
            else if (sample_temp_index[i]== -1){
              senti_ctr_neg_pos_3= senti_ctr_neg_pos_3 + 1
            }
          }
        }
        
      }   ## closing bracket for case 4 to 6's parent  if condition 
      
    }   ## closing bracket of the very first if condition in the for loop   ### CORE CONDITION ##
    
  }   
  ## here ends the for loop
  
  sem_orient_list <- list( "positive_Words_Score"= p_sum,
                           "negative_Words_Score"= n_sum,
                           "net_SO_score"= net_SO_score,
                           "length_of_String"= length(sample_temp_index),
                           "sample_temp_index"= sample_temp_index,
                           "senti_ctr_pos_pos_1"= senti_ctr_pos_pos_1,
                           "senti_ctr_neg_neg_1" = senti_ctr_neg_neg_1,
                           "senti_ctr_pos_pos_2"=senti_ctr_pos_pos_2,
                           "senti_ctr_neg_neg_2"=senti_ctr_neg_neg_2,
                           "senti_ctr_pos_pos_3"=senti_ctr_pos_pos_3,
                           "senti_ctr_neg_neg_3"=senti_ctr_neg_neg_3,
                           "senti_ctr_pos_neg_1"=senti_ctr_pos_neg_1,
                           "senti_ctr_neg_pos_1"=senti_ctr_neg_pos_1,
                           "senti_ctr_pos_neg_2"=senti_ctr_pos_neg_2,
                           "senti_ctr_neg_pos_2"=senti_ctr_neg_pos_2,
                           "senti_ctr_pos_neg_3"=senti_ctr_pos_neg_3,
                           "senti_ctr_neg_pos_3"=senti_ctr_neg_pos_3 )
  
  
  return(sem_orient_list)
  
}  ## here ends the function




######################################### Above function is bug free ###################################################################################
########################################################################################################################################################

## testing  above function 
temp_so_output<- sem_ori_features(sentence = "I love India and USA. I hate crime. I haven't seen good things in a while!!"  , positive_lexicon = pos.words, negative_lexicon = neg.words)
temp_so_output

temp_so_output<- sem_ori_features(sentence = df_imp_firs300$Content[1] , positive_lexicon = pos.words, negative_lexicon = neg.words)
df_imp_firs300$Content[1] 
temp_so_output


temp_so_output<- sem_ori_features(sentence =  temp , positive_lexicon = pos.words, negative_lexicon = neg.words)
temp
temp_so_output





















