


### Zapisz swój plik przy pomocy komendy 
```
:w<ENTER>
```

Opuść edytor przy pomocy komendy 
```
:q<ENTER>
```


***
### poruszanie ("") 
```
strzałki

h - lewo
l - prawa
j - dół
k - góra

0 początek linii
$ koniec linii

"w" skakanie do przodu po słowach
"b" skakanie do tyłu po słowach

"shift + w" skakanie do przodu po całym ciągu omija np ala-ala
"shift + b" skakanie do tyłu po całym ciągu 

"ctrl + f" następna strona
"ctrl + b" poprzednia strona

":12" skok do 12 linii

"shift + g" - koniec pliku
"gg" - poczatek linii

```
***
### kasowanie(wycinanie) tekstu("")
```
dh/dl - kasowanie litery lewo/prawo
dj/dk - kasowanie linni dół/góra

dd - kasowanie linii
2dw/d2w - kasowanie dwóch słów 
d0 - kasowanie do poczatku linni od kurosra
d$ - kasowanie do końca linii od kursora
"shift + d" kasowanie do konca linii

```
***
### kopiowanie tekstu("")
```
dd - wycinanie linii (schowek)
yy - kopiowanie lini
p - wklejenie poniżej linii
"shift + p" - wklejenie powyżej  linii

```

***
### dodawnie/łączenie tekstu tekstu("")
```
"3 + shift + o --> ala"  -> resultat 3 linie z ala
"40 + i --> #"  -> resultat 40 znków #
"shitf + a" - tryb wprowadzania na kon:iec tekstu
cw - podmiana słowa
c$ - podmiana od kursora do konca linii
g + u + u -(u-małe) małe litery w całej linii
g + U + U -(U-dduże) duże litery w całej linii
```
***
### wyszukiwanie ("")
```
f{znak} -> wyszukiwanie po znaku w linii w przud od kursora
F{znak} -> wyszukiwanie po znaku w linii w tył od kursora

t{znak} -> wyszukiwanie po znaku w linii w przud od kursora kursor przed znakiem
T{znak} -> wyszukiwanie po znaku w linii w tył od kursora ->  kursor za znakiem


/{tekst} -> szuka w całym teksie wystąpenia tego tekstu w przód
?{tekst} -> szuka w całym teksie wystąpenia tego tekstu w tył

/{tekst}<enter> n/N -> następne/poprzednie wystąpenie

*/# -> szuka tego słowa na którym znajduje się kursor następne/poprzednie wystąpenie

```
***
### podmiana ("")
```

```