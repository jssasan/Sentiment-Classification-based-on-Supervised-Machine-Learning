


## Text Pre-processing such as removing white spaces, removing punctuations, removing stopwords, stemming, removing numbers etc.


################################################################################################
####################              Preparing the positive and negative Lexicon #################
################################################################################################


path_lexicon <- "C:/Users/jsasan/Desktop/Jasmeet/R_work/Data/LiuLexicon/opinion-lexicon-English" 


hu.liu.pos = scan(paste(path_lexicon,"positive-words.txt",sep = "/"),
                  what='character', comment.char=';') 


hu.liu.neg = scan(paste(path_lexicon,"negative-words.txt",sep = "/"),
                  what='character', comment.char=';')

class(hu.liu.pos) ## character vector... great!!!!


## adding some additional words
pos.words = c(hu.liu.pos, 'upgrade')
neg.words = c(hu.liu.neg, 'wtf', 'wait','waiting', 'epicfail', 'mechanical')






####################### custom string manipulation functions #######################
# Function-1
trim_whitespaces <- function (x) gsub("^\\s+|\\s+$", "", x) 

# Function-2
replace_punctuations <- function (x) gsub("[[:punct:]]", " ", x)

# Function-3
## function to retain the words with not
## function to replace a words with some another word
word <- c("isn't", 	"haven't", 	"won't", 	"cannot", 	"aren't", 	"hadn't", 	"wouldn't,", 	"couldn't", 	"wasn't", 	"doesn't", 	"shan't", 	"mustn't", 	"weren't", 	"don't", 	"can't", 	"shouldn't", 	"hasn't", 	"didn't", 	"isnt", 	"havent", 	"wont", 	"cannot", 	"arent", 	"hadnt", 	"wouldnt,", 	"couldnt", 	"wasnt", 	"doesnt", 	"shant", 	"mustnt", 	"werent", 	"dont", 	"cant", 	"shouldn’t", 	"hasnt", 	"didnt", 	"isnot", 	"havent", 	"wont", 	"cannot", 	"arenot", 	"hadnot", 	"wouldnt,", 	"couldnt", 	"wasnot", 	"doesnot", 	"shallnot", 	"mustnt", 	"werenot", 	"dont", 	"canot", 	"shouldnot", 	"hasnot", 	"didnot", "havenot")
tran <- c("is not ", 	"have not ", 	"would not ", 	"can not ", 	"are not ", 	"had not ", 	"would not ", 	"could not ", 	"was not ", 	"does not ", 	"shall not ", 	"must not ", 	"were not ", 	"do not ", 	"can not ", 	"should not ", 	"has not ", 	"did not ", 	"is not ", 	"have not ", 	"would not ", 	"can not ", 	"are not ", 	"had not ", 	"would not ", 	"could not ", 	"was not ", 	"does not ", 	"shall not ", 	"must not ", 	"were not ", 	"do not ", 	"can not ", 	"should not ", 	"has not ", 	"did not ", 	"is not ", 	"have not ", 	"would not ", 	"can not ", 	"are not ", 	"had not ", 	"would not ", 	"could not ", 	"was not ", 	"does not ", 	"shall not ", 	"must not ", 	"were not ", 	"do not ", 	"can not ", 	"should not ", 	"has not ", 	"did not ", "have not ")

## stri_replace_all_fixed is a function from stringi package
retain_not_words<- function(x) stri_replace_all_fixed(x, word, tran, vectorize_all = FALSE)

# Function-4
### an effort to retain the negative words such as not e.g. culdn't  will be culd not ; hvn't will be hv not
### replace words with short form, n't with not e.g. aren't will be replace with are not
replace_not_words<- function(str){
  gsub(pattern = "n't", replacement = " not ", x=str, ignore.case = TRUE)
}

# Function-5 : this is not a new function but I have modified the stopword list for removeWords function and created a modified function
########################################
# TIP :: everytime you want to include certain words in the corpus then just change the stopWordsNotDeleted variable and re-create the Corpus

########## stopwords list  ##########
stopwords.default<- stopwords("english") ## I am merging the default with below because it doesn't cover all the stop words and has only 174 stop words and

## this  stopword list is taken from http://xpo6.com/list-of-english-stop-words/ 
## http://www.lextek.com/manuals/onix/stopwords1.html
stopwords.additional_1 <- c("i" ,"a", "about", "above", "above", "across", "after", "afterwards", "again", "against", "all", "almost", "alone", "along", "already", "also","although","always","am","among", "amongst", "amoungst", "amount",  "an", "and", "another", "any","anyhow","anyone","anything","anyway", "anywhere", "are", "around", "as",  "at", "back","be","became", "because","become","becomes", "becoming", "been", "before", "beforehand", "behind", "being", "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom","but", "by", "call", "can", "cannot", "cant", "co", "con", "could", "couldnt", "cry", "de", "describe", "detail", "do", "done", "down", "due", "during", "each", "eg", "eight", "either", "eleven","else", "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything", "everywhere", "except", "few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "most", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next", "nine", "no", "nobody", "none", "noone", "nor", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto", "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own","part", "per", "perhaps", "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere", "still", "such", "system", "take", "ten", "than", "that", "the", "their", "them", "themselves", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon", "these", "they", "thickv", "thin", "third", "this", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves", "the")
stopwords.additional_2<- c("a",	"about",	"above",	"across",	"after",	"again",	"against",	"all",	"almost",	"alone",	"along",	"already",	"also",	"although",	"always",	"among",	"an",	"and",	"another",	"any",	"anybody",	"anyone",	"anything",	"anywhere",	"are",	"area",	"areas",	"around",	"as",	"ask",	"asked",	"asking",	"asks",	"at",	"away",	"b",	"back",	"backed",	"backing",	"backs",	"be",	"became",	"because",	"become",	"becomes",	"been",	"before",	"began",	"behind",	"being",	"beings",	"best",	"better",	"between",	"big",	"both",	"but",	"by",	"c",	"came",	"can",	"cannot",	"case",	"cases",	"certain",	"certainly",	"clear",	"clearly",	"come",	"could",	"d",	"did",	"differ",	"different",	"differently",	"do",	"does",	"done",	"down",	"down",	"downed",	"downing",	"downs",	"during",	"e",	"each",	"early",	"either",	"end",	"ended",	"ending",	"ends",	"enough",	"even",	"evenly",	"ever",	"every",	"everybody",	"everyone",	"everything",	"everywhere",	"f",	"face",	"faces",	"fact",	"facts",	"far",	"felt",	"few",	"find",	"finds",	"first",	"for",	"four",	"from",	"full",	"fully",	"further",	"furthered",	"furthering",	"furthers",	"g",	"gave",	"general",	"generally",	"get",	"gets",	"give",	"given",	"gives",	"go",	"going",	"good",	"goods",	"got",	"great",	"greater",	"greatest",	"group",	"grouped",	"grouping",	"groups",	"h",	"had",	"has",	"have",	"having",	"he",	"her",	"here",	"herself",	"high",	"high",	"high",	"higher",	"highest",	"him",	"himself",	"his",	"how",	"however",	"i",	"if",	"important",	"in",	"interest",	"interested",	"interesting",	"interests",	"into",	"is",	"it",	"its",	"itself",	"j",	"just",	"k",	"keep",	"keeps",	"kind",	"knew",	"know",	"known",	"knows",	"l",	"large",	"largely",	"last",	"later",	"latest",	"least",	"less",	"let",	"lets",	"like",	"likely",	"long",	"longer",	"longest",	"m",	"made",	"make",	"making",	"man",	"many",	"may",	"me",	"member",	"members",	"men",	"might",	"more",	"most",	"mostly",	"mr",	"mrs",	"much",	"must",	"my",	"myself",	"n",	"necessary",	"need",	"needed",	"needing",	"needs",	"never",	"new",	"new",	"newer",	"newest",	"next",	"no",	"nobody",	"non",	"noone",	"not",	"nothing",	"now",	"nowhere",	"number",	"numbers",	"o",	"of",	"off",	"often",	"old",	"older",	"oldest",	"on",	"once",	"one",	"only",	"open",	"opened",	"opening",	"opens",	"or",	"order",	"ordered",	"ordering",	"orders",	"other",	"others",	"our",	"out",	"over",	"p",	"part",	"parted",	"parting",	"parts",	"per",	"perhaps",	"place",	"places",	"point",	"pointed",	"pointing",	"points",	"possible",	"present",	"presented",	"presenting",	"presents",	"problem",	"problems",	"put",	"puts",	"q",	"quite",	"r",	"rather",	"really",	"right",	"right",	"room",	"rooms",	"s",	"said",	"same",	"saw",	"say",	"says",	"second",	"seconds",	"see",	"seem",	"seemed",	"seeming",	"seems",	"sees",	"several",	"shall",	"she",	"should",	"show",	"showed",	"showing",	"shows",	"side",	"sides",	"since",	"small",	"smaller",	"smallest",	"so",	"some",	"somebody",	"someone",	"something",	"somewhere",	"state",	"states",	"still",	"still",	"such",	"sure",	"t",	"take",	"taken",	"than",	"that",	"the",	"their",	"them",	"then",	"there",	"therefore",	"these",	"they",	"thing",	"things",	"think",	"thinks",	"this",	"those",	"though",	"thought",	"thoughts",	"three",	"through",	"thus",	"to",	"today",	"together",	"too",	"took",	"toward",	"turn",	"turned",	"turning",	"turns",	"two",	"u",	"under",	"until",	"up",	"upon",	"us",	"use",	"used",	"uses",	"v",	"very",	"w",	"want",	"wanted",	"wanting",	"wants",	"was",	"way",	"ways",	"we",	"well",	"wells",	"went",	"were",	"what",	"when",	"where",	"whether",	"which",	"while",	"who",	"whole",	"whose",	"why",	"will",	"with",	"within",	"without",	"work",	"worked",	"working",	"works",	"would",	"x",	"y",	"year",	"years",	"yet",	"you",	"young",	"younger",	"youngest",	"your",	"yours",	"z")

## combining above three and keeping unique stopwords only

stopwords.default<- unique(c(stopwords.default, stopwords.additional_1, stopwords.additional_2)) 


## stop words not to be deleted from the corpus
stopWordsNotDeleted<- c("isn't" ,     "aren't" ,    "wasn't" ,    "weren't"   , "hasn't"    ,
                        "haven't" ,   "hadn't"  ,   "doesn't" ,   "don't"      ,"didn't"    ,
                        "won't"   ,   "wouldn't",   "shan't"  ,   "shouldn't",  "can't"     ,
                        "cannot"    , "couldn't"  , "mustn't", 
                        
                        "isnt" ,     "arent" ,    "wasnt" ,    "werent"   , "hasnt"    ,
                        "havent" ,   "hadnt"  ,   "doesnt" ,   "dont"      ,"didnt"    ,
                        "wont"   ,   "wouldnt",   "shant"  ,   "shouldnt",  "cant"     ,
                        "cannot"    , "couldnt"  , "mustnt",
                        
                        "isnot" ,     "arenot" ,    "wasnot" ,    "werenot"   , "hasnot"    ,
                        "havent" ,   "hadnot"  ,   "doesnot" ,   "dont"      ,"didnot"    ,
                        "wont"   ,   "wouldnt",   "shallnot"  ,   "shouldnot",  "canot"     ,
                        "cannot"    , "couldnt"  , "mustnt",
                        "no", "nor", "never","not", pos.words , neg.words, "t")

stopWord.new<- stopwords.default[! stopwords.default %in% stopWordsNotDeleted] ## new Stopwords list by keeping not words; positive words;  negative words


removeWords_custom<- function(text_str, stopWordsToBeDeleted= stopWord.new ){
  
  output<- removeWords(text_str, stopWordsToBeDeleted)
  return(output)
}

## example below  
sample_temp<- "abcdkfkdfdkgf fgfdgdf to but the I so not no nor never it of i am shudnt shuldn't wasn't mustn't no able to do it so nver more never still"
removeWords_custom(tolower(sample_temp))  ## don't need to give the other arguement as it is already set to a default value




content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte'))


###############################################################################################################
####### converting above transformatons into a function ##########

corpus_transformation_custom <- function(dataset, doremoveStopWords, doStemming, doremoveNumbers){
  
  temp <- dataset$Content
  
  temp_corpus<- Corpus(VectorSource(temp))
  temp_corpus <- tm_map(temp_corpus, FUN = content_transformer(retain_not_words) ,mc.cores=1)  ### replacing words (with n't) which are like shouldn't or don't, couldn't
  temp_corpus <- tm_map(temp_corpus, FUN = content_transformer(replace_not_words) ,mc.cores=1)  ### replacing misspelled words (with n't) which are like shuldn't or dn't, culdn't
  temp_corpus <- tm_map(temp_corpus, FUN = content_transformer(replace_punctuations) ,mc.cores=1)  ### this will replace the punctuation with a space
  
  temp_corpus <- tm_map(temp_corpus,
                        content_transformer(function(x) iconv(x, to='ASCII', sub='byte')),
                        mc.cores=1)
  
  temp_corpus <- tm_map(temp_corpus, FUN = content_transformer(tolower) ,mc.cores=1)  ## it needs to be executed before the next statement always
  if (doremoveStopWords== TRUE){
    temp_corpus <- tm_map(temp_corpus, FUN = content_transformer(function(x)removeWords_custom(x)),mc.cores=1 )  ## this will remove CUSTOM stopwords 
  }
  temp_corpus <- tm_map(temp_corpus, FUN = content_transformer(stripWhitespace),mc.cores=1)
  temp_corpus <- tm_map(temp_corpus, FUN = content_transformer(trim_whitespaces) ,mc.cores=1)  ## custom fucntion: removes trailing and leading spaces
  
  if (doremoveNumbers==TRUE){
    temp_corpus <- tm_map(temp_corpus, FUN = content_transformer(removeNumbers) ,mc.cores=1) 
  }
  
  # temp_corpus <- tm_map(temp_corpus, PlainTextDocument)  ## Run only when nothing works out : running this can produce different behavior at times
  if (doStemming== TRUE){
    temp_corpus <- tm_map(temp_corpus, stemDocument, language="english",mc.cores=1)  ## depends based on the requirement.. Also if this gives error then first convert the corpus to plain document using above statement (commented out)
  }
  
  
  # temp_corpus <- tm_map(temp_corpus, PlainTextDocument,mc.cores=1)
  
  return(temp_corpus)
  
  
  ## first arguement is the dataset original
  ## second arguement is a boolean: if true then stopwords will be removed else stopwords will be retained
  ## third arguement is a boolean: if true then stemming will be performed
  
}



## testing above function  ### works like charm
temp_corpus <- corpus_transformation_custom(df_imp_firs300, removeStopWords = FALSE)
temp_corpus[[12]]$content  ## perfect ouput










