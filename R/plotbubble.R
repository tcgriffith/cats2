#' Plot the Pfam Domains
#'
#' deal with graphic .json file scraped from pfam and imported using jsonlite
#'
#' useful info : pfam$length , pfam$regions , pfam$motifs, 
#' regions: text, start, end , motifs:start end
#' start, end should be converted to numeric
#' @param maf.file The .maf containing mutations for one gene
#' @param pfam.file The df object of the graphic json from jsonlite
#' @examples 
#' plotdomains(p53.maf,pfam.maf)
#' @seealso \code{\link{}}
plotdomains<-function(maf.file,pfam.file) {
 pfam=pfam.file
 maf=maf.file
 regions<-pfam$regions[[1]]
 regions$start<-as.numeric(regions$start)
 regions$end<-as.numeric(regions$end)

 motifs<-pfam$motifs[[1]]
 motifs$start<-as.numeric(motifs$start)
 motifs$end<-as.numeric(motifs$end)
## a test of mapping
  maf %>% filter()
  maf %>% group_by(Hugo_Symbol,Entrez_Gene_Id,Chromosome,Start_position,Variant_Classification,is_missense,is_indel,is_nonsense,cDNA_Change,Protein_Change) %>% summarise(recur_i=n())->maf2
  as.numeric(gsub("[^0-9]|_.*","",maf2$Protein_Change))->maf2$Prot_pos
## plotting using ggplot2
 ggplot()+
 #lollipops
 geom_segment(data=maf2,aes(x=Prot_pos,xend=Prot_pos,y=ifelse(is_nonsense>0,recur_i,-recur_i),yend=0,colour=Variant_Classification))+
 geom_point(data=maf2,aes(x=Prot_pos,y=ifelse(is_nonsense>0,recur_i,-recur_i),colour=Variant_Classification))+
# geom_text_repel(data=maf2[which(maf2$recur_i >20),],aes(x=Prot_pos,y=ifelse(is_nonsense>0,recur_i,-recur_i),label=Protein_Change))+
 geom_segment(aes(x=1,xend=as.numeric(pfam$length),y=0,yend=0),size=2,colour="grey")+
 #motif
 #geom_segment(data=motifs[which(motifs$display),],aes(x=start,xend=end,y=0,yend=0,colour=type),size=8)+
 #domain
 geom_segment(data=regions,aes(x=start,xend=end,y=0,yend=0),size=4,colour="purple")+
 geom_text(data=regions,aes(label=metadata$description,x=0.5*(start+end),y=0),vjust=2,size=6)+
 theme_minimal()+ 
 theme(legend.position="bottom",
       axis.text.x=element_blank(),       
 )+ 
 theme_void()+
 xlab("") 
}
