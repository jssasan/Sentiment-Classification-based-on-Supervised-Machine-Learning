
# The downloaded source packages are in ‘C:\Users\jsasan\AppData\Local\Temp\RtmpsblHkP\downloaded_packages’
detach("package:caret", unload=TRUE)




################################################################################################################################################################################
######################################    Below function takes original dataset as input and returns tagged dataframe    ######################################
######################################    with other relevant columns including original review data, ratings and counts of relevant POS features  ##########
################################################################################################################################################################################


options(stringsAsFactors=FALSE)  ## please run this prior running below script: VIMP


sent_token_annotator <- Maxent_Sent_Token_Annotator()
word_token_annotator <- Maxent_Word_Token_Annotator()
pos_tag_annotator <- Maxent_POS_Tag_Annotator()


annotated_df <- function(dataset_to_annotate){
  
  # dataset_to_annotate is the original dataset we want to annotate  e.g. df_imp_last300 or may be the entire dataset
  
  temp_corpus <- corpus_transformation_custom(dataset_to_annotate, doremoveStopWords =  FALSE, doStemming = FALSE, doremoveNumbers = FALSE)
  # temp_corpus[[11]]$content  ## perfect ouput
  
  corpus_to_df <-data.frame("Content"=unlist(sapply(temp_corpus, `[`, "content")), "rating"= dataset_to_annotate$rating,
                            stringsAsFactors=F)
  row.names(corpus_to_df)<- NULL
  
  
  org_df_temp <- corpus_to_df  ## corpus_to_df
  
  org_df_temp$Content<- sapply(1:dim(org_df_temp)[1], function(x,dataset) as.String(dataset$Content[x]) , dataset=  org_df_temp)
  
  
  a2 <- lapply(1:dim(org_df_temp)[1], function(x,dataset,sta,wta) annotate(dataset$Content[x], list(sta, wta))  , dataset=  org_df_temp, sta= sent_token_annotator, wta= word_token_annotator)
  # a2[[21]]
  
  a3 <- lapply(1:dim(org_df_temp)[1], function(x,dataset, atr) annotate(dataset$Content[x], pos_tag_annotator, atr[[x]])  , dataset=  org_df_temp, atr=a2)
  # a3[21]
  
  
  ## creating an empty dataframe
  tagged_df  <- data.frame(Tagged_Content= character(0), Content =character(0), rating= numeric(0),
                           cc=  numeric(0),
                           cn=  numeric(0),
                           d=  numeric(0),
                           et=  numeric(0),
                           fw=  numeric(0),
                           posc=  numeric(0),
                           adj=  numeric(0),
                           adj_c=  numeric(0),
                           adj_s=  numeric(0),
                           lim=  numeric(0),
                           modal=  numeric(0),
                           nsom=  numeric(0),
                           np=  numeric(0),
                           pns=  numeric(0),
                           pnp=  numeric(0),
                           predeterminer=  numeric(0),
                           pe=  numeric(0),
                           pp=  numeric(0),
                           pp_1=  numeric(0),
                           adverb=  numeric(0),
                           ad_c=  numeric(0),
                           ad_s=  numeric(0),
                           particle=  numeric(0),
                           symbol=  numeric(0),
                           to=  numeric(0),
                           interjection=  numeric(0),
                           vbs=  numeric(0),
                           vps=  numeric(0),
                           vgopp=  numeric(0),
                           vpp=  numeric(0),
                           vnpsp=  numeric(0),
                           vpsp=  numeric(0),
                           whd=  numeric(0),
                           whp=  numeric(0),
                           pwp=  numeric(0),
                           wha=  numeric(0)
                           
                           
  )
  
  colnames_temp <- colnames(tagged_df)
  
  
  # tagged_df<- data.frame(Tagged_Content= character(0), stringsAsFactors = FALSE) ## empty dataframe to hold tagge values
  # temp_rating<- data.frame(rating= numeric(0), stringsAsFactors = FALSE) ## empty dataframe to hold ratings
  tryCatch(
    {
  
    for (i in 1:dim(org_df_temp)[1]) {
    
    y<- stripWhitespace(org_df_temp[i,1])
    y<- trim_whitespaces(y)
    y<-  sapply(y, function(z) strsplit(z," "))
    y_len <- dim(data.frame(y))[1]
    
    x<- a3[[i]]
    temp_x <- subset(x, type=='word')
    tags <- sapply(temp_x$features, '[[', "POS")
    tags_len <- dim(data.frame(tags))[1]
    
    ## second if condition is not required though haha
    if(y_len>0 &&
       tags_len>0 &&
       y_len==tags_len){
      
      ## count of POS feature starts here ##
      cc <- length(grep('\\bCC\\b',  tags))
      cn <- length(grep('\\bCD\\b',  tags))
      d <- length(grep('\\bDT\\b',  tags))
      et <- length(grep('\\bEX\\b',  tags))
      fw <- length(grep('\\bFW\\b',  tags))
      posc <- length(grep('\\bIN\\b',  tags))
      adj <- length(grep('\\bJJ\\b',  tags))
      adj_c <- length(grep('\\bJJR\\b',  tags))
      adj_s <- length(grep('\\bJJS\\b',  tags))
      lim <- length(grep('\\bLS\\b',  tags))
      modal <- length(grep('\\bMD\\b',  tags))
      nsom <- length(grep('\\bNN\\b',  tags))
      np <- length(grep('\\bNNS\\b',  tags))
      pns <- length(grep('\\bNNP\\b',  tags))
      pnp <- length(grep('\\bNNPS\\b',  tags))
      predeterminer <- length(grep('\\bPDT\\b',  tags))
      pe <- length(grep('\\bPOS\\b',  tags))
      pp <- length(grep('\\bPRP\\b',  tags))
      pp_1 <- length(grep('\\bPRP$\\b',  tags))
      adverb <- length(grep('\\bRB\\b',  tags))
      ad_c <- length(grep('\\bRBR\\b',  tags))
      ad_s <- length(grep('\\bRBS\\b',  tags))
      particle <- length(grep('\\bRP\\b',  tags))
      symbol <- length(grep('\\bSYM\\b',  tags))
      to <- length(grep('\\bTO\\b',  tags))
      interjection <- length(grep('\\bUH\\b',  tags))
      vbs <- length(grep('\\bVB\\b',  tags))
      vps <- length(grep('\\bVBD\\b',  tags))
      vgopp <- length(grep('\\bVBG\\b',  tags))
      vpp <- length(grep('\\bVBN\\b',  tags))
      vnpsp <- length(grep('\\bVBP\\b',  tags))
      vpsp <- length(grep('\\bVBZ\\b',  tags))
      whd <- length(grep('\\bWDT\\b',  tags))
      whp <- length(grep('\\bWP\\b',  tags))
      pwp <- length(grep('\\bWP$\\b',  tags))
      wha <- length(grep('\\bWRB\\b',  tags))
      
      ## count of POS feature ends here ##
      
      
      ## pos tagged text
      r1<- sapply(y, function(x,tags)sprintf("%s/%s", x, tags), tags= tags)
      temp_y <- paste(r1, collapse = " ")
    
      ## temp dataframe
      temp <- data.frame('Tagged_Content'=temp_y,
                         'Content'=dataset_to_annotate$Content[i],
                         'rating'=dataset_to_annotate$rating[i],
                         'cc'=cc,
                         'cn'=cn,
                         'd'=d,
                         'et'=et,
                         'fw'=fw,
                         'posc'=posc,
                         'adj'=adj,
                         'adj_c'=adj_c,
                         'adj_s'=adj_s,
                         'lim'=lim,
                         'modal'=modal,
                         'nsom'=nsom,
                         'np'=np,
                         'pns'=pns,
                         'pnp'=pnp,
                         'predeterminer'=predeterminer,
                         'pe'=pe,
                         'pp'=pp,
                         'pp_1'=pp_1,
                         'adverb'=adverb,
                         'ad_c'=ad_c,
                         'ad_s'=ad_s,
                         'particle'=particle,
                         'symbol'=symbol,
                         'to'=to,
                         'interjection'=interjection,
                         'vbs'=vbs,
                         'vps'=vps,
                         'vgopp'=vgopp,
                         'vpp'=vpp,
                         'vnpsp'=vnpsp,
                         'vpsp'=vpsp,
                         'whd'=whd,
                         'whp'=whp,
                         'pwp'=pwp,
                         'wha'=wha
                         
                         
      )   
      
      
      ## rbinding
      tagged_df <- rbind(tagged_df, temp)
      
      
    }
    
  }  ## for loop ends here
      
    },  error=function(e){cat("ERROR :",conditionMessage(e), "\n")}
  )
   # tagged_df <- cbind(tagged_df, temp_rating)
  
  row.names(tagged_df)<- NULL
  colnames(tagged_df) <- colnames_temp
  
  return(tagged_df)
  
}



### running above function in small chunks of data and then bind them together  ###

## VIMP: ## just create an empty data frame main_annotated_df_org from the bottom of this script



annotated_df_chunker <-  function(dataset, chunks){
  
  # chunks=5
  size <- nrow(dataset)/chunks
  upper_lim <- 0
  
  main_annotated_df <- main_annotated_df_org
  temp_cn<- colnames(main_annotated_df_org)
  
  for(i in 1:chunks){
    
    lower_lim <- upper_lim +1
    upper_lim <- i*size
    temp_annotated_df <- annotated_df(dataset[lower_lim:upper_lim , ])   ## this is handling smaller chunks of data
    colnames(temp_annotated_df) <- temp_cn
   tryCatch({ 
        main_annotated_df <- rbind(main_annotated_df, temp_annotated_df)  ## this is doing heavy lifting
   },  
    error=function(e){cat("ERROR :",conditionMessage(e), " in Chunk - ", i ,"\n")}
  )
    
  }
  
  return(main_annotated_df)
  
}


####   ## creating an empty dataframe to be used in annotated_df_chunker function
main_annotated_df_org  <- data.frame(Tagged_Content= character(0), Content =character(0), rating= numeric(0), stringsAsFactors = FALSE,
                                     cc=  numeric(0),
                                     cn=  numeric(0),
                                     d=  numeric(0),
                                     et=  numeric(0),
                                     fw=  numeric(0),
                                     posc=  numeric(0),
                                     adj=  numeric(0),
                                     adj_c=  numeric(0),
                                     adj_s=  numeric(0),
                                     lim=  numeric(0),
                                     modal=  numeric(0),
                                     nsom=  numeric(0),
                                     np=  numeric(0),
                                     pns=  numeric(0),
                                     pnp=  numeric(0),
                                     predeterminer=  numeric(0),
                                     pe=  numeric(0),
                                     pp=  numeric(0),
                                     pp_1=  numeric(0),
                                     adverb=  numeric(0),
                                     ad_c=  numeric(0),
                                     ad_s=  numeric(0),
                                     particle=  numeric(0),
                                     symbol=  numeric(0),
                                     to=  numeric(0),
                                     interjection=  numeric(0),
                                     vbs=  numeric(0),
                                     vps=  numeric(0),
                                     vgopp=  numeric(0),
                                     vpp=  numeric(0),
                                     vnpsp=  numeric(0),
                                     vpsp=  numeric(0),
                                     whd=  numeric(0),
                                     whp=  numeric(0),
                                     pwp=  numeric(0),
                                     wha=  numeric(0)
                         
                         
)




save.image()


## example
pos_features_2k_cam_temp <- annotated_df(df_imp_2k_f_cam[1:10,])

annotated_df_chunker(dataset = df_imp_2k_f_cam[1:100,], chunks = 10)


