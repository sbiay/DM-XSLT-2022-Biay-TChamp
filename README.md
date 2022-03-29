Corpus lyrique de Thibaut de Champagne
====

![BNF, fr. 844, f4r](https://gallica.bnf.fr/iiif/ark:/12148/btv1b84192440/f27/0,150,3426,1800/1200/0/default.jpg)

Ce dépôt propose une visualisation HTML générée par XSLT pour le corpus lyrique de Thibaut de Champagne, d'après le Manuscrit du Roi, ms. fr. 844 de la Bibliothèque nationale de France, dont le texte a été établi par Viola Mariotti 💜 dans le cadre de l'ANR Maritem.

La navigation dans le corpus procède à partir du fichier [./html/fr844-accueil.html](./html/fr844-accueil.html).

Ce dépôt contient :
- Un dossier `html/` contenant l'ensemble des pages du parcours de navigation dans le corpus ;
- Plusieurs dossiers pour les fichiers de l'édition du corpus en XML-TEI :
    - `dtd/`
    - `odd/`
    - `tei/`
- Un dossier `xsl/` contenant toutes les feuilles de styles employées pour la génération des pages HTML :
    - `fr844-prep.xsl` transforme le fichier TEI original `fr844_encodage_Thibaut.xml` en un nouveau fichier TEI, `fr844_encodage_Thibaut-prep.xml` possédant de nouveaux attributs (pour les besoins de la manipulation des données) et dépourvu d'indentation (pour limiter les problèmes d'espaces dans les sorties HTML) ; toutes les autres feuilles XSL prennent en entrée le fichier `…-prep.xml`
    - `fr844-accueil.xsl` génère la page d'accueil et les tables des matières des chansonniers ;
    - `fr844-chanson.xsl` génère les pages présentant l'édition des pièces lyriques ;
    - `fr844-codico.xsl` génère la page de présentation du manuscrit, essentiellement issue du `teiHeader` de l'édition TEI ;
    - `fr844-index.xsl` génère dynamiquement l'index des noms de lieux et de personnes à partir des entrées renseignées dans l'élément `back` de l'édition TEI ;
    - `fr844-princip-edition.xsl` génère la page de présentation des principes éditoriaux du projet ;
- Un dossier `static/` contenant les fichiers .CSS et javascript nécessaires à la visualisation et à l'animation des pages HTML.
