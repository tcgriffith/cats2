require(jsonlite)
require(RCurl)
require(dplyr)
require(ggplot2)
source("~/Rscript/plotting/plotbubble")

lollipop<-function(maf){
  
 
 uniprotid<-maf[1,]$i_HGNC_UniProtIDsuppliedbyUniProt

 pfamurl<-paste0('http://pfam.xfam.org/protein/',uniprotid,'/graphic')
 tmp.pfam<-getURL(pfamurl)
 if(validate(tmp.pfam))
  {
    tmp.json<-fromJSON(tmp.pfam)
    plotdomains(maf,tmp.json) 
  }
 else
  {
    stop(paste0("pfam not found ",uniprotid))
  }

}
