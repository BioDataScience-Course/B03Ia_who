# Vérifications de who_notebook.qmd
who <- parse_rmd("../../who_notebook.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("who_notebook.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("who_notebook.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats", "Description des données",
    "Modèle de l'espérance de vie en l'an 2000",
    "Analyse des résidus du modèle pour l'an 2000",
    "Modèle de l'espérance de vie en l'an 2015",
    "Analyse des résidus du modèle pour l'an 2015",
    "Discussion et conclusion")
    %in% (rmd_node_sections(who) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "import", "contingence", "corr", "corrcomment",
    "plot1", "plot2", "plot3", "plotcomment", "filter", "plot1b", "plot2b",
    "plot3b", "plotbcomment", "model2000_1", "model2000_1comment",
    "model2000_2", "model2000_2comment", "compa1", "compa1comment",
    "model2000_3", "model2000_3comment", "compa2", "compa2comment", "resid1",
    "resid1comment", "model2015_1", "model2015_1comment", "model2015_2",
    "model2015_2comment", "compa3", "compa3comment", "resid2", "resid2comment",
    "discu1comment", "discu2comment", "discu3comment", "discu4comment",
    "discu5comment")
    %in% rmd_node_label(who)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(who))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(who[[1]]$author != "___")
  expect_true(!grepl("__", who[[1]]$author))
  expect_true(grepl("^[^_]....+", who[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", who[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", who[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunks 'import' : importation des données", {
  expect_true(is_identical_to_ref("import", "names"))
  # Les colonnes dans le tableau `who` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'import'.

  expect_true(is_identical_to_ref("import", "classes"))
  # La nature des variables (classe) dans le tableau `who` est incorrecte
  # Vérifiez le chunk d'importation des données `import`.

  expect_true(is_identical_to_ref("import", "nrow"))
  # Le nombre de lignes dans le tableau `who` est incorrect
  # Vérifiez l'importation des données dans le chunk d'importation `import` et
  # réexécutez-le pour corriger le problème.
})

test_that("Chunks 'contingence', 'corr' & 'corrcomment' : description des données", {
  expect_true(is_identical_to_ref("contingence"))
  # Le tableau de contingence produit par le chunk 'contingence' n'est pas celui
  # attendu
  # Lisez bien la consigne et corrigez l'erreur. Si le test précédent
  # d'importation est incorrect, celui-ci l'est aussi automatiquement. Sinon,
  # vérifiez le code du chunk et corrigez-le.

  expect_true(is_identical_to_ref("corr"))
  # Le graphique des corrélations produit par le chunk 'corr' n'est pas celui
  # attendu
  # Lisez bien la consigne et corrigez l'erreur. Sélectionnez les cinq variables
  # quantitatives dans l'ordre d'apparition dans le tableau.

  expect_true(is_identical_to_ref("corrcomment"))
  # L'interprétation de la description des données est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le graphique et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'plot1', 'plot2', 'plot3' & 'plotcomment' : graphiques 2000 à 2015", {
  expect_true(is_identical_to_ref("plot1"))
  # Le graphique produit par le chunk 'plot1' n'est pas celui attendu
  # Lisez bien la consigne et corrigez l'erreur. Il vous faut un graphique en
  # nuage de points avec deux variables quantitatives, une variation de couleur
  # par année et des facettes pour la variable 'Status'.

  expect_true(is_identical_to_ref("plot2"))
  # Le graphique produit par le chunk 'plot2' n'est pas celui attendu
  # Lisez bien la consigne et corrigez l'erreur. Il vous faut un graphique en
  # nuage de points avec deux variables quantitatives, une variation de couleur
  # par année et des facettes pour la variable 'Status'.

  expect_true(is_identical_to_ref("plot3"))
  # Le graphique produit par le chunk 'plot3' n'est pas celui attendu
  # Lisez bien la consigne et corrigez l'erreur. Il vous faut un graphique en
  # nuage de points avec deux variables quantitatives, une variation de couleur
  # par année et des facettes pour la variable 'Status'.

  expect_true(is_identical_to_ref("plotcomment"))
  # L'interprétation des graphiques 2000 à 2015 est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent les graphiques d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunk 'filter' : filtrage des données pour 2000 et 2015 uniquement", {
  expect_true(is_identical_to_ref("filter"))
  # Le tableau `who2' dans le chunk 'filter' n'est pas celui attendu
  # Lisez bien la consigne et corrigez l'erreur. Vous devez sélectionner
  # uniquement les données relatives aux années 2000 et 2015.
})

test_that("Chunks 'plot1b', 'plot2b', 'plot3b' & 'plotbcomment' : graphiques 2000 et 2015", {
  expect_true(is_identical_to_ref("plot1b"))
  # Le graphique produit par le chunk 'plot1b' n'est pas celui attendu
  # Lisez bien la consigne et corrigez l'erreur. Il vous faut un graphique en
  # nuage de points avec deux variables quantitatives, une variation de couleur
  # par 'Status' et des facettes par année.

  expect_true(is_identical_to_ref("plot2b"))
  # Le graphique produit par le chunk 'plot2b' n'est pas celui attendu
  # Lisez bien la consigne et corrigez l'erreur. Il vous faut un graphique en
  # nuage de points avec deux variables quantitatives, une variation de couleur
  # par 'Status' et des facettes par année.

  expect_true(is_identical_to_ref("plot3b"))
  # Le graphique produit par le chunk 'plot3b' n'est pas celui attendu
  # Lisez bien la consigne et corrigez l'erreur. Il vous faut un graphique en
  # nuage de points avec deux variables quantitatives, une variation de couleur
  # par 'Status' et des facettes par année.

  expect_true(is_identical_to_ref("plotbcomment"))
  # L'interprétation des graphiques 2000 et 2015 est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent les graphiques d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'model2000_1', 'model2000_1comment', premier modèle linéaire pour 2000", {
  expect_true(is_identical_to_ref("model2000_1"))
  # Le premier modèle linéaire pour 2000 (chunk 'model2000_1') n'est pas le bon
  # Vérifiez en particulier la formule que vous avez écrite pour décrire la
  # relation entre les variables dans votre modèle. Relisez les consignes
  # attentivement, si nécessaire.

  expect_true(is_identical_to_ref("model2000_1comment"))
  # L'interprétation du premier modèle linéaire pour 2000 est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le modèle d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'model2000_2', 'model2000_2comment', second modèle linéaire pour 2000", {
  expect_true(is_identical_to_ref("model2000_2"))
  # Le second modèle linéaire pour 2000 (chunk 'model2000_2') n'est pas le bon
  # Vérifiez en particulier la formule que vous avez écrite pour décrire la
  # relation entre les variables dans votre modèle. Relisez les consignes
  # attentivement, si nécessaire.

  expect_true(is_identical_to_ref("model2000_2comment"))
  # L'interprétation du second modèle linéaire pour 2000 est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le modèle d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'compa1', 'compa1comment', comparaison des deux premiers modèles pour 2000", {
  expect_true(is_identical_to_ref("compa1"))
  # La comparaison des deux premiers modèles pour 2000 (chunk 'compa1') n'est
  # pas correcte
  # Vérifiez votre code et indiquez les modèles dans l'ordre comme arguments.

  expect_true(is_identical_to_ref("compa1comment"))
  # L'interprétation de la comparaison des deux premiers modèles pour 2000 est
  # (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent la comparaison d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'model2000_3', 'model2000_3comment', troisième modèle linéaire pour 2000", {
  expect_true(is_identical_to_ref("model2000_3"))
  # Le troisième modèle linéaire pour 2000 (chunk 'model2000_3') n'est pas le bon
  # Vérifiez en particulier la formule que vous avez écrite pour décrire la
  # relation entre les variables dans votre modèle. Relisez les consignes
  # attentivement, si nécessaire.

  expect_true(is_identical_to_ref("model2000_3comment"))
  # L'interprétation du troisième modèle linéaire pour 2000 est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le modèle d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'compa2', 'compa2comment', comparaison des modèles é et 3 pour 2000", {
  expect_true(is_identical_to_ref("compa2"))
  # La comparaison des modèles 2 et 3 pour 2000 (chunk 'compa1') n'est
  # pas correcte
  # Vérifiez votre code et indiquez les modèles dans l'ordre comme arguments.

  expect_true(is_identical_to_ref("compa2comment"))
  # L'interprétation de la comparaison des modèles 2 et 3 pour 2000 est
  # (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent la comparaison d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Le code pour l'équation paramétrée du modèle 2000 est-il correct ?", {
  expect_true(rmd_select(who, by_section(
    "Modèle de l'espérance de vie en l'an 2000")) |>
      as_document() |> is_display_param_equation("who00_lm2"))
  # Le code pour générer l'équation paramétrée du modèle pour 2000 est incorrect
  # Vous avez appris à faire cela dans un learnr du module 2. Revoyez cette
  # matière et vérifiez comment l'équation se présente dans le document final
  # généré avec le bouton ('Rendu').
})

test_that("Chunks 'resid1' & 'resid1comment' : graphiques d'analyse des résidus pour le modèle 2000", {
  expect_true(is_identical_to_ref("resid1"))
  # Les graphiques d'analyse des résidus du modèle 2000 ne sont pas réalisé ou
  # sont incorrects
  # Relisez les consignes et vérifiez votre code concernant ce graphique.

  expect_true(is_identical_to_ref("resid1comment"))
  # L'interprétation des graphiques d'analyse des résidus du modèle 2000 est
  # (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent les graphiques d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'model2015_1', 'model2015_1comment', premier modèle linéaire pour 2015", {
  expect_true(is_identical_to_ref("model2015_1"))
  # Le premier modèle linéaire pour 2015 (chunk 'model2015_1') n'est pas le bon
  # Vérifiez en particulier la formule que vous avez écrite pour décrire la
  # relation entre les variables dans votre modèle. Relisez les consignes
  # attentivement, si nécessaire.

  expect_true(is_identical_to_ref("model2015_1comment"))
  # L'interprétation du premier modèle linéaire pour 2015 est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le modèle d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'model2015_2', 'model2015_2comment', second modèle linéaire pour 2015", {
  expect_true(is_identical_to_ref("model2015_2"))
  # Le second modèle linéaire pour 2015 (chunk 'model2015_2') n'est pas le bon
  # Vérifiez en particulier la formule que vous avez écrite pour décrire la
  # relation entre les variables dans votre modèle. Relisez les consignes
  # attentivement, si nécessaire.

  expect_true(is_identical_to_ref("model2015_2comment"))
  # L'interprétation du second modèle linéaire pour 2015 est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le modèle d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'compa3', 'compa3comment', comparaison des deux modèles pour 2015", {
  expect_true(is_identical_to_ref("compa3"))
  # La comparaison des deux modèles pour 2015 (chunk 'compa3') n'est pas
  # correcte
  # Vérifiez votre code et indiquez les modèles dans l'ordre comme arguments.

  expect_true(is_identical_to_ref("compa3comment"))
  # L'interprétation de la comparaison des deux modèles pour 2015 est
  # (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent la comparaison d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Le code pour l'équation paramétrée du modèle 2015 est-il correct ?", {
  expect_true(rmd_select(who, by_section(
    "Modèle de l'espérance de vie en l'an 2015")) |>
      as_document() |> is_display_param_equation("who15_lm2"))
  # Le code pour générer l'équation paramétrée du modèle pour 2015 est incorrect
  # Vous avez appris à faire cela dans un learnr du module 2. Revoyez cette
  # matière et vérifiez comment l'équation se présente dans le document final
  # généré avec le bouton ('Rendu').
})

test_that("Chunks 'resid2' & 'resid2comment' : graphiques d'analyse des résidus pour le modèle 2015", {
  expect_true(is_identical_to_ref("resid2"))
  # Les graphiques d'analyse des résidus du modèle 2015 ne sont pas réalisé ou
  # sont incorrects
  # Relisez les consignes et vérifiez votre code concernant ce graphique.

  expect_true(is_identical_to_ref("resid2comment"))
  # L'interprétation des graphiques d'analyse des résidus du modèle 2015 est
  # (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent les graphiques d'un 'x' entre
  # les crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'discu1-5comment' : discussion et conclusion", {
  expect_true(is_identical_to_ref("discu1comment"))
  # L'élément de discussion #1 n'est pas sélectionné ou n'est pas celui attendu
  # Vous devez cochez la phrase correcte d'un 'x' entre les crochets [] -> [x].
  # Ensuite, vous devez recompiler la version HTML du bloc-notes (bouton
  # 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("discu2comment"))
  # L'élément de discussion #2 n'est pas sélectionné ou n'est pas celui attendu
  # Vous devez cochez la phrase correcte d'un 'x' entre les crochets [] -> [x].
  # Ensuite, vous devez recompiler la version HTML du bloc-notes (bouton
  # 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("discu3comment"))
  # L'élément de discussion #3 n'est pas sélectionné ou n'est pas celui attendu
  # Vous devez cochez la phrase correcte d'un 'x' entre les crochets [] -> [x].
  # Ensuite, vous devez recompiler la version HTML du bloc-notes (bouton
  # 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("discu4comment"))
  # L'élément de discussion #4 n'est pas sélectionné ou n'est pas celui attendu
  # Vous devez cochez la phrase correcte d'un 'x' entre les crochets [] -> [x].
  # Ensuite, vous devez recompiler la version HTML du bloc-notes (bouton
  # 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("discu5comment"))
  # L'élément de discussion #5 n'est pas sélectionné ou n'est pas celui attendu
  # Vous devez cochez la phrase correcte d'un 'x' entre les crochets [] -> [x].
  # Ensuite, vous devez recompiler la version HTML du bloc-notes (bouton
  # 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})
