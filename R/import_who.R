# Jeu de données `who`
#
# description et métadonnées :
#   https://www.kaggle.com/datasets/lashagoch/life-expectancy-who-updated
# données :
#   https://www.kaggle.com/datasets/lashagoch/life-expectancy-who-updated/download?datasetVersionNumber=1
# (il n'est pas possible d'utiliser read() avec cette URL car Kaggle ne permet
# pas le téléchargement direct des données. Il faut les charger manuellement)
# Ces données sont donc placées dans data/raw/Life-Expectancy-Data-Updated.csv
# à la main

# Note : vous n'avez pas besoin d'exécuter ce script ! Les données finales
# `who.rds` sont déjà dans le dossier `data` du projet. Il est ici à des fins
# de reproductibilité comme trace du prétraitement qui a été effectué.

# Configuration de l'environnement
SciViews::R("model", lang = "fr")

# Étape 1 : importation des données ---------------------------------------

who <- read$csv("data/raw/Life-Expectancy-Data-Updated.csv")
attr(who, "spec") <- NULL
attr(who, "problems") <- NULL


# Étape 2 : prétraitement des données -------------------------------------

# Nous ne traiterons pas toutes les variables -> sélection de celles qui nous
# intéressent
who <- sselect(who, Country, Year, Mortality = Adult_mortality, BMI,
  Schooling, Developed = Economy_status_Developed, Expectancy = Life_expectancy)
# Conversion en variable factor et création d'une version alternative
# plus explicite pour le libellé des facettes des graphiques
who$Developed <- as.factor(who$Developed)
who$Status <- recode(who$Developed,
  "0" = "Pays non développé", "1" = "Pays développé")


# Étape 3 : ajout des labels et des unités --------------------------------

who <- labelise(who,
  label = list(
    Country    = "Pays",
    Year       = "Année",
    Mortality  = "Mortalité adulte",
    BMI        = "Indice de masse corporelle",
    Schooling  = "Éducation",
    Developed  = "Pays développé",
    Expectancy = "Espérance de vie",
    Status     = "Statut économique"
  ), units = list(
    Mortality  = "par 1000 habitants",
    BMI        = "kg/m^2",
    Schooling  = "années d'études",
    Expectancy = "années"
  )
)


# Étape 4 : sauvegarde des données ----------------------------------------

# Sauvegarder la version finale du jeu de données et nettoyer l'environnement
write$rds(who, "data/who.rds")
rm(who)
