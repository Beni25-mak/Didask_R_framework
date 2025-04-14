# Nettoyage - Vérifier un ensemble de données
# Pipe-able 

# Cleaning - Composition - Analysis - Outputs

library(cleaningtools)
library(dplyr)

my_raw_dataset <- cleaningtools::cleaningtools_raw_data
my_kobo_survey <- cleaningtools::cleaningtools_survey
my_kobo_choice <- cleaningtools::cleaningtools_choices

# check_* (vérifier)

#Les fonctions check_* (vérifier) onctions qui signalent des valeurs sur la base d’une 
#vérification spécifique. Elles renvoient ces valeurs dans un registre (ou journal). 
#Une fonction *check_** renvoie une liste : l’ensemble de données vérifié et le registre(journal).
#Les fonctions check_* sont utilisées uniquement dans l’étape de nettoyage.

# check_outliers

my_log1 <- my_raw_dataset %>% 
  check_outliers(uuid_column = "X_uuid")

#Dans cet exemple, il y a :
  
#-checked_dataset: l’ensemble de données brutes (avec des variables supplémentaires si nécessaire)
#-potential_outliers: un journal des valeurs aberrantes potentielles

typeof(my_log1)
my_log1 %>% 
  names()

# Le journal comporte au moins 4 colonnes :

# uuid : l’identifiant unique
# issue : le problème signalé
# question : le nom de la question
# old_value : la valeur signalée

my_log1$potential_outliers %>% 
  head()

# check_duplicate (doublons)

my_log2 <- my_raw_dataset %>% 
  check_duplicate(uuid_column = "X_uuid")

my_log2$duplicate_log %>% 
  head()

# uuid	old_value	question	issue
# Il n’y a pas de doublon. Le journal est vide.

# Pipe-able

#Pipe-able

#Le framework est construit autour de 2 adjectifs, pipe-able et indépendant. 
#Dans le cadre d’analyse, les fonctions de la même famille sont “pipe-pable” (c’est-à-dire qu’elles peuvent être utilisée l’une après l’autre). 
#Dans l’exemple suivant, deux fonctions check_* sont “pipe-ées”.

my_log3 <- my_raw_dataset %>% 
  check_outliers(uuid_column = "X_uuid") %>% 
  check_duplicate(uuid_column = "X_uuid")

names(my_log3)

my_log3$potential_outliers %>% 
  head()

my_log3$duplicate_log %>% 
  head()

# Plus de vérifications

# Ceci est un exemple d’autres vérifications existantes.

more_logs <- my_raw_dataset %>% 
  check_duplicate(uuid_column = "X_uuid") %>% 
  check_soft_duplicates(uuid_column = "X_uuid", kobo_survey = my_kobo_survey, sm_separator = ".") %>%
  check_outliers(uuid_column = "X_uuid") %>%
  check_value(uuid_column = "X_uuid") 


