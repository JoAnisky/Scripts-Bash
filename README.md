# Scripts-Bash
### HTML_generator :

C'est un script qui permet à l'utilisateur de générer des pages .html, .css et .js de base.

##Pistes d'amélioration :

[  ] Création du dossier du projet (si il n'existe pas déjà) 
[  ] Création d'un sous dossier CSS ou se placera le fichier. Css
[  ] Création d'un sous dossier js ou se placera le fichier. Js
[  ] Création d'un sous dossier image 
[  ] Affichage des fichiers créés au fur et à mesure 
[  ] Affichage du chemin choisi et validation sinon retour à la définition du chemin

```bash
#!bin/bash

    # On commence par récuperer le nom du fichier .html que l'on stocke dans une variable $htmlfilename 
read -r -p "Entrez un nom pour votre fichier .html (sans ecrire .html) : " htmlfilename
    # Idem pour le nom du fichier .css => variable $cssfilename
read -r -p "Entrez un nom pour votre fichier .css (sans ecrire .css) : " cssfilename
    # On récupère le titre de la page avec la variable $pagetitle qui sera inséré entre les balises <title></title>
read -r -p "Entrez le titre de votre page html : " pagetitle
    # Et enfin on demande le chemin ou l'utilisateur souhaite enregistrer son fichier. Par défaut on se situe la ou est placé le script 
    # (POINTS D'AMELIORATION A FAIRE SUR CE SUJET !!!)
read -r -p "Où voulez-vous enregistrer le fichier ? " workingdirectory
# La suite (L14) crée un fichier avec le chemin et le nom de fichier choisi (par défaut .html)
# et génère la structure de base du site (L15 à L28) en remplissant les balises title et le href du fichier css
cat << EOF > $workingdirectory/$htmlfilename.html
<!DOCTYPE html>
<html lang="fr">
    <head>
        <title>$pagetitle</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="stylesheet" href="$cssfilename.css" />
        <script src='index.js' async></script>
    </head>
<body>
    <h1></h1>
</body>
</html>
EOF
# On génère ici la feuille de style .css, en récuperant la variable $cssfilename pour le nom du fichier
cat << EOF > $workingdirectory/$cssfilename.css
body{
    margin:0;
    padding:0;
}
EOF
```
