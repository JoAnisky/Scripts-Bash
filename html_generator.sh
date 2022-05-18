#!/bin/bash
clear

    # On commence par récuperer le nom du fichier .html que l'on stocke dans une variable $htmlfilename 
read -r -p "Entrez un nom pour votre fichier .html (sans ecrire .html) : " htmlfilename
    # Idem pour le nom du fichier .css => variable $cssfilename
read -r -p "Entrez un nom pour votre fichier .css (sans ecrire .css) : " cssfilename
    # On récupère le titre de la page avec la variable $pagetitle qui sera inséré entre les balises <title></title>
read -r -p "Entrez le titre de votre page html : " pagetitle
    # Et enfin on demande le chemin ou l'utilisateur souhaite enregistrer son fichier. Par défaut on se situe la ou est placé le script 
    # (POINTS D'AMELIORATION A FAIRE SUR CE SUJET !!!)


#ajout d'un while pour demander un dossier de projet. Temps que l'utilisateur n'est pas en accord, on lui redemande.
#création de la var "y" pour définir si l'utilisateur veut utilser le dossier où il est, ou non. 
p=1
y=1
while [ $p = 1 ]
do

i=1
while [ $i = 1 ]
do


read -r -p "Voulez vous utiliser le dossier où vous êtes pour enregistrer le projet ? $PWD : " reponse
    case "$reponse" in
        oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
        #Je voulais donner à ma variable workingdirectory la valeur ==> $(basename $pwd) à la base pour
        #ne pas modifier la suite du code. Mais dans ces condition, le programme comprend pas car il cherche
        #un dossier qui ce nomme comme le dossier actuel, mais dans le dossier actuel !
        # Ex: admin/projet1 ==> il cherchera le chemin admin/projet1/projet1 ... Et il prendra pas le projet1 existant
        #C'est très triste alors du coup, j'ai fais un bon gros if à la fin avec "y", et je change les chemin manuellement
        y=0
        break ;;
        non | Non | NON | n | N | no | NO | No | n | N )
        read -r -p "Nommez le dossier où vous voulez enregistrer le projet. " workingdirectory ;;
        *) echo "Error syntax !" ;;
    esac 

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
                    *) echo "Error syntax !" ;;
                esac 
        fi
else
    read -r -p "Le dossier existe déjà. Voulez-vous l'utiliser ? [y/n] : " use 
    case "$use" in
                    oui | Oui | OUI | o | O | yes | Yes | YES | y | Y ) i=0 ;;
                    non | Non | NON | n | N | no | NO | No | n | N ) echo "Retour au choix de dossier" ;;
                    *) echo "Error syntax !" ;;
    esac 
fi
done

#ajout d'une autre boucle while, pour la confirmation ultime avec un if qui vérifie la var "y" pour donner le bon chemin
#en fonction de si il choisi un nouveau dossier ou le dossier actuel. 

if [ $y = 1 ]
then
    read -r -p "On utilisera le chemin suivant pour la création des fichiers : $PWD/$workingdirectory. Voulez-vous continuer ? [Y/N] : " continuer

    case "$continuer" in
            oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
            p=0
            mkdir $workingdirectory/images ;;
            non | Non | NON | n | N | no | NO | No | n | N ) 
            echo "Retour au début.";;
            *) 
            echo "Error syntax !" ;;
    esac 
else 
    read -r -p "On utilisera le chemin suivant pour la création des fichiers : $PWD. Voulez-vous continuer ? [Y/N] : " continuer

    case "$continuer" in
            oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
            p=0
            mkdir images ;;
            non | Non | NON | n | N | no | NO | No | n | N ) 
            echo "Retour au début.";;
            *) 
            echo "Error syntax !" ;;
    esac 
fi
done

if [ $y = 1 ]
then

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
            echo "Error syntax !" ;;
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
            echo "Error syntax !" ;;
    esac 
    done

    while true 
    do

    read -r -p "Voulez vous créer un sous-dossier FONTS ? [Y/N] : " fonts 

    case "$fonts" in
            oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
            mkdir $workingdirectory/fonts
            echo "[x] Dossier fonts créé"
            break;;
            non | Non | NON | n | N | no | NO | No | n | N ) 
            break;;
            *) 
            echo "Error syntax !" ;;
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
            <script src='js/$jsfilename.js' defer></script>
        </head>
    <body>
        <h1></h1>
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

cat << EOF > $workingdirectory/js/$jsfilename.js
EOF

    echo "[x] Fichier HTML crée avec succès."
    echo "[x] Dossier CSS crée avec succès."
    echo "[x] Fichier CSS crée avec succès."
    echo "[x] Dossier images crée avec succès."

else 

    while true
    do
    read -r -p "Voulez vous créer un sous-dossier JavaScript ? : " js

    case "$js" in
            oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
            mkdir js
            echo "[x] Dossier JS créé"
            read -r -p "Entrez un nom pour votre fichier .js (sans écrire le .js) : " jsfilename
            break ;;
            non | Non | NON | n | N | no | NO | No | n | N )
            break ;;
            *) 
            echo "Error syntax !" ;;
    esac 
    done

    while true
    do

    read -r -p "Voulez vous créer un sous-dossier php ? : " php

    case "$php" in
            oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
            mkdir php
            echo "[x] Dossier php créé"
            break;;
            non | Non | NON | n | N | no | NO | No | n | N )
            break ;;
            *) 
            echo "Error syntax !" ;;
    esac 
    done

    while true 
    do

    read -r -p "Voulez vous créer un sous-dossier FONTS ? [Y/N] : " fonts 

    case "$fonts" in
            oui | Oui | OUI | o | O | yes | Yes | YES | y | Y )
            mkdir fonts
            echo "[x] Dossier fonts créé"
            break;;
            non | Non | NON | n | N | no | NO | No | n | N ) 
            break;;
            *) 
            echo "Error syntax !" ;;
    esac 
    done

    mkdir css

    # La suite (L14) crée un fichier avec le chemin et le nom de fichier choisi (par défaut .html)
    # et génère la structure de base du site (L15 à L28) en remplissant les balises title et le href du fichier css
    cat << EOF > $htmlfilename.html
    <!DOCTYPE html>
    <html lang="fr">
        <head>
            <title>$pagetitle</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <link rel="stylesheet" href="css/$cssfilename.css" />
            <script src='js/$jsfilename.js' defer></script>
        </head>
    <body>
        <h1></h1>
    </body>
    </html>
EOF
    # On génère ici la feuille de style .css, en récuperant la variable $cssfilename pour le nom du fichier
    cat << EOF > css/$cssfilename.css
    body{
        margin:0;
        padding:0;
        box-sizing:border-box;
    }
EOF

cat << EOF > js/$jsfilename.js
EOF

    echo "[x] Fichier HTML crée avec succès."
    echo "[x] Dossier CSS crée avec succès."
    echo "[x] Fichier CSS crée avec succès."
    echo "[x] Dossier images crée avec succès."
fi
