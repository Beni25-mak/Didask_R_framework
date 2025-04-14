## 02. Add, Durations and other

library(cleaningtools)
library(dplyr)

my_raw_dataset <- cleaningtools::cleaningtools_raw_data
my_kobo_survey <- cleaningtools::cleaningtools_survey
my_kobo_choice <- cleaningtools::cleaningtools_choices

more_logs <- my_raw_dataset %>% 
  check_duplicate(uuid_column = "X_uuid") %>% 
  check_soft_duplicates(uuid_column = "X_uuid", kobo_survey = my_kobo_survey, sm_separator = ".") %>%
  check_outliers(uuid_column = "X_uuid") %>%
  check_value(uuid_column = "X_uuid") 


# add_duration

#Les fonctions add_* ajouteront une variable (colonne) à l’ensemble de données. 
#Par exemple, pour ajouter la durée d’une enquête, pour ajouter la catégorie de score de consommation alimentaire, etc.
#Les fonctions add_* prennent un ensemble de données en entrée et renvoient l’ensemble de données + le nouvel indicateur 
#(et toutes les étapes intermédiaires utilisées pour le calcul).
#Par exemple, pour vérifier la durée d’une enquête, il n’y a que les colonnes start et end, mais pas la colonne durée.

more_logs$checked_dataset <- more_logs$checked_dataset %>% 
  add_duration(uuid_column = "X_uuid", start_column = "X.U.FEFF.start", end_column = "end")

more_logs$checked_dataset[1:6, c("start_date", "start_time", "end_date", "end_time", "days_diff", "duration")]



#Avertissement

#La colonne duration est ajoutée au dataframe checked_dataset dans la liste, pas dans le dataframe my_raw_dataset. 
#Les fonctions check_* sont utilisées dans une chaîne, donc il faut modifier l’ensemble de données utilisé.


#Avertissement

#Pour l’instant, add_duration prend un format très spécifique. 
#Elle deviendra plus robuste avec lubridate dans le futur.


#check_duration peut maintenant être utilisé avec les autres vérifications.

more_logs <- more_logs %>% 
  check_duration(column_to_check = "duration", uuid_column = "X_uuid")


#As much as possible, check_* functions take default argument or the functions will be able to guess some information, 
# e.g. the check_outliers function guesses some numerical values. Some functions need more information.

# other/text columns

# check_other needs the list of columns to be checked. It currently, it cannot detect the open text question. 
# KOBO tool can be used.

# check_other nécessite que la liste des colonnes soit vérifiée. Actuellement, il ne peut pas détecter la question ouverte. 
# L'outil KOBO peut être utilisé.

other_columns_to_check <- my_kobo_survey %>% 
  dplyr::filter(type == "text") %>% 
  dplyr::filter(name %in% names(my_raw_dataset)) %>%
  dplyr::pull(name) 

more_logs <- more_logs %>% 
  check_others(uuid_column = "X_uuid", columns_to_check = other_columns_to_check) 


