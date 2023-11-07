# Modèle linéaire d'espérance de vie (données World Health Organisation)
## Avant-propos

Ce projet nécessite d'avoir assimilé l'ensemble des notions des trois premiers modules du cours de science des données biologiques 2. Il correspond au dépôt GitHub <https://github.com/BioDataScience-Course/B03Ia_who>.

## Objectif

Ce projet est **court**, **individuel** et **cadré**. Il vise à compléter votre apprentissage en modélisation de données biologiques en vous initiant aux modèles linéaires. Dans ce projet, vous devrez :

-   Décrire correctement des données en vue de leur modélisation

-   Créer et analyser des modèles linéaires combinant variables réponses qualitatives et quantitatives

-   Simplifier un modèle linéaire et décider quel modèle retenir (AIC, ANOVA)

-   Faire l'analyse des résidus de modèles linéaires

## Consignes

Complétez les zones manquantes dans le fichier `who_notebook.qmd`. Compilez la version finale au format HTML. Vous avez une batterie de tests à votre disposition (onglet "Construire" -> bouton "Construire tout") pour vérifier l'état travail. Note : utilisez ces tests à la fin. Concentrez-vous d'abord sur vos analyses, puis faites un rendu final du document lorsque tout est complété, et seulement après, utilisez les tests. Il est contre-productif d'activer les tests à chaque nouvelle ligne de code ajoutée dans votre document !

## Informations sur les données

Les données employées proviennent de Kaggle ([**Life Expectancy (WHO) Fixed**](https://www.kaggle.com/datasets/lashagoch/life-expectancy-who-updated)). Consultez cette page pour avoir plus d'informations sur les données et leur provenance. Ces données sont dans `data/raw/Life-Expectancy-Data-Updated.csv`. Elles sont distribuées sous licence [CC0 domaine public](https://creativecommons.org/publicdomain/zero/1.0/). Une version modifiée de ce jeu de données est placé dans `data/who.rds`. Elle est créée à partir du script `R/import_who.R` qui est joint pour votre information (mais vous n'avez pas besoin de le réexécuter). Vous partirez du jeu de données `data/who.rds` pour réaliser votre analyse.
