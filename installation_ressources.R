## installation et ressource

# Tout d'abord, vous devrez installer les paquets nécessaires. Pour ce faire, vous pouvez installer la version de développement de cleaningtools depuis le
# répertoire de cleaningtools sur GitHub avec :

install.packages("devtools")
install.packages("remotes")

#Sys.which("make")


#Sys.setenv(GITHUB_PAT = "ton_token_personnel")


devtools::install_github("impact-initiatives/cleaningtools")

#Alternativement, vous pouvez installer la version de développement de *analysistools* depuis le répertoire de *analysistools* sur GitHub
#avec :

devtools::install_github("impact-initiatives/analysistools")

#Sur GitHub, vous trouverez également quelques guides sur les outils, et de la documentation sur les différentes fonctions incluses dans chaque
#paquet. N'hésitez pas à explorer et à vous familiariser avec les ressources disponibles !


#Vous trouverez également quelques modèles de jeux de données bruts, ainsi que des enquêtes KOBO et les options correspondantes pour
#explorer. Vous pouvez y accéder en utilisant :

library(cleaningtools)
library(dplyr)

my_raw_dataset <- cleaningtools::cleaningtools_raw_data
my_kobo_survey <- cleaningtools::cleaningtools_survey
my_kobo_choice <- cleaningtools::cleaningtools_choices
