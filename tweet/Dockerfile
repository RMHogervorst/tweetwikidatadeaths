# A small example of a dockerfile
# That has R and packages installed and 
# runs a script
FROM r-base
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
libcurl4-openssl-dev \
libssl-dev \
&& install2.r --error \ 
    --deps FALSE \ 
    jsonlite\
    curl\
    openssl\
    mime\
    R6\
    httr\
    assertthat\
    crayon\
    cli\
    rlang\
    fansi \
    utf8 \
    pillar\
    tibble\
    rtweet\
    BH\ plogr\
     Rcpp\ 
     bindr\
    bindrcpp\
    pkgconfig\
    purrr\
   tidyselect\ 
    dplyr\
    WikidataQueryServiceR
COPY . /usr/local/src/myscripts/
WORKDIR /usr/local/src/
CMD ["Rscript", "myscripts/script.R"]