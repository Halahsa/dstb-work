# install.packages("ROAuth") 
# install.packages("twitteR")
library("ROAuth")
library (twitteR)

download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
cred <- OAuthFactory$new(consumerKey='JoGlRyVA9BsOMHeG4fTtbZXtt',
                         consumerSecret='b5bEldT1ptOHYETYsbt6fVPz0KtnJG4Phxl7pGq8Y6ZlgQKnIL',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')
cred$handshake(cainfo="cacert.pem") # This completes the handshake and loads a twitter page that asks for your permissions to provide access. Once accepted it returns a PIN which needs to be entered in R
#stop at this point to enter PIN!!!, don't run futher line yet


save(cred, file="twitter_authentication.Rdata") # This saves the credentials for future use
load ("twitter_authentication.Rdata") #To load the credentials without extra steps


registerTwitterOAuth(cred) #If successfully connected returns [1] TRUE

#Check if R is reading the data from Twitter
twitter_data<- searchTwitter("Data Science", n=150, cainfo="cacert.pem") 

#To extract the Tweets and put in a data frame
twitter_data_frame <- data.frame(sapply(twitter_data, function(x) x$getText()))


