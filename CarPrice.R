library("rvest")

audi<-html("http://www.autovit.ro/autoturisme/audi?l=60&fq%5Bnew_or_used%5D=used")
##pag2 de selectie "http://www.autovit.ro/autoturisme/audi?p=2&l=60&fq%5Bnew_or_used%5D=used"

#css selctor (.basic strong , .om-price-primary .om-price-amount , h3 a )
audi_df<-audi %>%
  html_nodes(" .basic strong , .om-price-amount , h3 a ") %>%
  html_text()

marca<-audi%>%
  html_nodes("h3 a") %>%
  html_text()
pret<-audi%>%
  html_nodes(".om-price-primary .om-price-amount") %>%
  html_text()
detalii<-audi %>%
  html_nodes(" .basic strong") %>%
  html_text()

T<-matrix(detalii,ncol=4,byrow = TRUE)
anFab<-T[,1]