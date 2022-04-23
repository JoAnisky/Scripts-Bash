#!/bin/bash
clear

    # On récupère le nom du fichier .html que l'on stocke dans une variable $htmlfilename 
read -r -p "Entrez un nom pour votre fichier .html (sans ecrire .html) : " htmlfilename
    # Idem pour le nom du fichier .css => variable $cssfilename
read -r -p "Entrez un nom pour votre fichier .css (sans ecrire .css) : " cssfilename
    # On récupère le titre de la page avec la variable $pagetitle qui sera inséré entre les balises <title></title>
read -r -p "Entrez le titre de votre page html : " pagetitle
    # Et enfin on demande le chemin ou l'utilisateur souhaite enregistrer son fichier. Par défaut on se situe la ou est placé le script 

#ajout d'un while pour demander un dossier de projet. Tant que l'utilisateur n'est pas en accord, on lui redemande.
p=1
while [ $p = 1 ]
do

i=1
while [ $i = 1 ]
do
read -r -p "Nommez le dossier où vous voulez enregistrer le projet. $PWD/ " workingdirectory
if [[ ! -d "$workingdirectory" ]]
then
        if [[ ! -L $workingdirectory ]]
        then
                read -r -p "Le dossier n'existe pas. Voulez-vous le créer dans $PWD [y/n]? : " reponse
                case "$reponse" in
                    oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
                    mkdir $workingdirectory
                    echo "[x] Dossier créé"
                    i=0 ;;
                    non | Non | NON | n | N | no | NO | No | n | N ) echo "Retour au choix de dossier" ;;
                    *) echo "Erreur de synthaxe !" ;;
                esac 
        fi
else
    read -r -p "Le dossier existe déjà. Voulez-vous l'utiliser ? : " use 
    case "$use" in
                    oui | Oui | OUI | o | O | yes | Yes | YES | y | Y ) i=0 ;;
                    non | Non | NON | n | N | no | NO | No | n | N ) echo "Retour au choix de dossier" ;;
                    *) echo "Erreur de synthaxe !" ;;
    esac 
fi
done

#ajout d'une autre boucle while, pour la confirmation ultime

read -r -p "On utilisera le chemin suivant pour la création des fichiers : $PWD/$workingdirectory. Voulez-vous continuer ? : " continuer

case "$continuer" in
        oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
        p=0
        mkdir $workingdirectory/images ;;
        non | Non | NON | n | N | no | NO | No | n | N ) 
        echo "Retour au début.";;
        *) 
        echo "Erreur de synthaxe !" ;;
esac 

done

while true
do

read -r -p "Voulez vous créer un sous-dossier JavaScript ? : " js

case "$js" in
        oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
        mkdir $workingdirectory/js
        echo "[x] Dossier JS créé"
        read -r -p "Entrez un nom pour votre fichier .js (sans écrire le .js) : " jsfilename
        break ;;
        non | Non | NON | n | N | no | NO | No | n | N )
        break ;;
        *) 
        echo "Erreur de synthaxe !" ;;
esac 
done

while true
do

read -r -p "Voulez vous créer un sous-dossier php ? : " php

case "$php" in
        oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
        mkdir $workingdirectory/php
        echo "[x] Dossier php créé"
        break;;
        non | Non | NON | n | N | no | NO | No | n | N )
        break ;;
        *) 
        echo "Erreur de synthaxe !" ;;
esac 
done

while true 
do

read -r -p "Voulez vous créer un sous-dossier FONTS ? : " fonts 

case "$fonts" in
        oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
        mkdir $workingdirectory/fonts
        echo "[x] Dossier fonts créé"
        break;;
        non | Non | NON | n | N | no | NO | No | n | N ) 
        break;;
        *) 
        echo "Erreur de synthaxe !" ;;
esac 
done

mkdir $workingdirectory/css

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
        <link rel="stylesheet" href="css/$cssfilename.css" />
    </head>
<body>
    <h1></h1>
    <script src='js/$jsfilename.js' defer></script>
</body>
</html>
EOF
# On génère ici la feuille de style .css, en récuperant la variable $cssfilename pour le nom du fichier
cat << EOF > $workingdirectory/css/$cssfilename.css
body{
    margin:0;
    padding:0;
    box-sizing:border-box;
}
EOF

echo "[x] Fichier $htmlfilename.html crée avec succès."
echo "[x] Dossier CSS crée avec succès."
echo "[x] Fichier $cssfilename.css crée avec succès."
echo "[x] Dossier images crée avec succès."