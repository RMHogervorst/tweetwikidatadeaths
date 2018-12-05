# tweetbot with R

A small demonstration of a docker container that runs a R-script
Keep in mind that this is a rather unsafe method to use your twitter keys
you're much better of supplying them as arguments at build time. 


## Instructions to run the docker container

- CD into the tweet folder 
- modify the Rscript
- docker build to build the container
- docker run to run the container

```
cd tweet
# modify the R script (you'd be wise to change the keys or use 
# a different way to add these keys to the image)
sudo docker build -t 'wikidatabot:v1'  .
sudo docker run wikidatabot:v1
```

## Explanation of technology used
This container builds on the r-base container and installs all packages needed
for the script to run. Unfortunately those are a lot of packages. 

The script uses wikidataqueryr to query wikidata and retrieve a list of deaths.
It selects one of those, glues the information from that death together and 
sends a tweet out with rtweet.

# Running this script on heroku
The init.R file is used on heroku.

- Install the heroku commandline app.
- Select the init.R and script.R file and commit them 

- run the following commands (the buildpack is external)

```
heroku --create 
heroku buildpacks:set https://github.com/virtualstaticvoid/heroku-buildpack-r.git#heroku-16
heroku stack:set 'heroku-16'
git push heroku master
```
To make it run automatically every day you have to enable the scheduler.
You need to add a creditcard.

- in the schedular set this command: `Rscript app/script.R`

it now runs whenever you want to. 