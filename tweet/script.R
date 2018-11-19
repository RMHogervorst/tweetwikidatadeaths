### download famous people who died today
### select a random word
### create a text from the information
### post to twitter
######################
##setting up
library(glue)
library(WikidataQueryServiceR)
library(rtweet)
request <- 
    query_wikidata(
        'SELECT ?entityLabel (YEAR(?date) AS ?year) ?cause_of_deathLabel ?place_of_deathLabel ?manner_of_deathLabel  ?country_of_citizenshipLabel ?country_of_birth
        ?date_of_birth
        WHERE {
        BIND(MONTH(NOW()) AS ?nowMonth)
        BIND(DAY(NOW()) AS ?nowDay)
        ?entity wdt:P570 ?date.
        SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
        ?entity wdt:P509 ?cause_of_death.
        OPTIONAL { ?entity wdt:P20 ?place_of_death. }
        OPTIONAL { ?entity wdt:P1196 ?manner_of_death. }
        FILTER(((MONTH(?date)) = ?nowMonth) && ((DAY(?date)) = ?nowDay))
        OPTIONAL { ?entity wdt:P27 ?country_of_citizenship. }
        OPTIONAL { ?entity wdt:p19 ?country_of_birth}
        OPTIONAL { ?entity wdt:P569 ?date_of_birth.}
        }
        LIMIT 10')
# select a random row and print the message
id <- sample(1:nrow(request),size = 1)
resultingline <-  
    glue::glue_data(request[id,], "Today in {year} in the place {place_of_deathLabel} died {entityLabel} with cause: {cause_of_deathLabel}. {entityLabel} was born on {as.Date(date_of_birth, '%Y-%m-%d')}. Find more info on this cause of death on www.en.wikipedia.org/wiki/{cause_of_deathLabel} .  #wikidata")

# tweet this line. 
token <- create_token(
    app = "YOUR APP NAME",
    consumer_key = "YOURCONSUMERKEYHERE",
    consumer_secret = "YOURCONSUMERSECRETHERE",
    access_token = "YOURACCESSTOKENHERE",
    access_secret = "YOURACCESSSECRETHERE")

rtweet::post_tweet(status = resultingline, token = token )
