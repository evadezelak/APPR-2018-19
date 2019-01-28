# Analiza podatkov s programom R, 2018/19

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2018/19

* [![Shiny](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/evadezelak/APPR-2018-19/master?urlpath=shiny/APPR-2018-19/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/evadezelak/APPR-2018-19/master?urlpath=rstudio) RStudio

## Letalski promet po Evropi

V projektu bom analizirala gibanje prebivalstva preko letalskega prometa po Evropi. Osredotočila se bom na to, koliko ljudi je v posamezni državi potovalo z letalom v določenih obdobjih. 

Prvo področje bo na splošno turizem. Tu se bom osredotočila predvsem na to, katere države so turistično najbolj oblegane. Pri tem se bom osredotočila na več dejavnikov ter si hkrati ogledala tudi ravoj turizma v smislu, koliko izdatkov posamezna država letno nameni za turizem ter posebej še, koliko za potniški promet turistov ter koliko enot je bilo na novo ustanovljenih v določenem letu za turizem in koliko od tega za potniški promet turistov. Poskušala bom najti povezavo med samim razvojem turizma in tem, koliko turistov je v istem letu prišlo v državo. V tem delu se bom osredotočila na podatke med leti 1995 in 2017. 

Prva tabela bo vsebovala: 
* `države`
* `prihode turistov v posameznem letu`
* `prihode turistov preko letalskega prometa v posameznem letu`
* `izdatke za turizem v posameznem letu`
* `izdatke za potniški promet v posameznem letu`
* `število ustanovljenih enot za turizem v posameznem letu`
* `število ustanovljenih enot za potniški promet turistov v posameznem letu`

Iz tega bom poskušala najti povezavo, katere regije oziroma države se najhitreje razvijajo, glede na to, koliko namenijo za samo področje turizma letno in koliko vlagajo v napredek. 

Drugo področje pa bo sama analiza letalskega prometa v Evropi, kjer bo zajetih 34 držav. Časovno se bom osredotočila na 10 let, analizirala pa bom po četrtletjih. Torej podatki se bodo začeli s prvim četrtletjem leta 2008 in končali z drugim četrtletjem leta 2018. 

Druga tabela bo torej vsebovala:
* `države`
* `število turistov, ki so v posamezni državi potovali preko letalskega prometa`

Tretja tabela:
* `države`
* `število prebivalcev posamezne države`

Tretjo tabelo bom uporabila v namen, da si ogledam relativne primerjave držav, saj bo na ta način analiza bolj relevantna.

Cilj: Predvidevam, da je število potnikov skozi leta naraščalo, hkrati pa tudi, da je v drugem in tretjem kvartilu leta največ potnikov v letalskem prometu, saj je to čas dopustov. Prav tako bom poskušala najti povezavo med tem, da je evropska država močno turistično obljudena in tem, da ima veliko potnikov, ki potujejo preko letalskega prometa. Kot sem že omenila, me bo zanimalo tudi, če je kakšna povezava med rastjo turizma v določeni državi in številom turistov, ki jo obiščejo.

Za vir podatkov bom uporabila [Eurostat](https://ec.europa.eu/eurostat/data/database), organizacijo [World Tourism Organization UNWTO](http://www2.unwto.org/) in [Wikipedijo](https://en.wikipedia.org/wiki/Demographics_of_Europe).

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-201819)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem.zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
