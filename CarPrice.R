library("rvest")

url2="http://www.autovit.ro/autoturisme/audi?p=2&l=60&fq%5Bnew_or_used%5D=used"
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



for(i in 1:26){
  urls1<-"http://www.autovit.ro/autoturisme/audi?p="
  urls2<-as.character(i)
  urls3<-"&l=60&fq%5Bnew_or_used%5D=used"
  urls<-paste(urls1,urls2,urls3,sep="")
  audi<-html(urls)
  
  marca_t<-audi%>%
    html_nodes("h3 a") %>%
    html_text()  
  marca<-append(marca,marca_t)
  pret_t<-audi%>%
    html_nodes(".om-price-primary .om-price-amount") %>%
    html_text()
  pret<-append(pret,pret_t)
  detalii_t<-audi %>%
    html_nodes(" .basic strong") %>%
    html_text()
  detalii<-append(detalii,detalii_t)  
  
}

marca<-str_trim(marca)
test<-colsplit(marca," ",c("Marca","Model"))
model<-test["Model"]

pret<-str_replace_all(pret," ","")
pret<-as.numeric(pret)

T<-matrix(detalii,ncol=4,byrow = TRUE)
anFab<-T[,1]

motor<-T[,2]
motor<-str_replace_all(motor," ","")
motor<-str_trim(motor)
test2<-colsplit(motor,"\n",c("Motor","Combust"))

audiDF$motor<-test2$Motor
audiDF$Fuel<-test2$Combust

body<-T[,3]
body<-str_trim(body)
audiDF$Body<-body

km<-str_replace_all(km," km","")
audiDF$mileage<-as.numeric(km)

 audiDF$year<-as.factor(anFab) 