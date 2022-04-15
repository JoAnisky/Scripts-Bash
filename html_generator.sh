#!bin/bash
""
    # On commence par récuperer le nom du fichier .html que l'on stocke dans une variable $htmlfilename 
read -r -p "Entrez un nom pour votre fichier .html (sans ecrire .html) : " htmlfilename
    # Idem pour le nom du fichier .css => variable $cssfilename
read -r -p "Entrez un nom pour votre fichier .css (sans ecrire .css) : " cssfilename
    # On récupère le titre de la page avec la variable $pagetitle qui sera inséré entre les balises <title></title>
read -r -p "Entrez le titre de votre page html : " pagetitle
    # Et enfin on demande le chemin ou l'utilisateur souhaite enregistrer son fichier. Par défaut on se situe la ou est placé le script 
    # (POINTS D'AMELIORATION A FAIRE SUR CE SUJET !!!)
read -r -p "Nommez le dossier où vous voulez enregistrer le projet ? " workingdirectory


if [[ ! -d "$workingdirectory" ]]
then
        if [[ ! -L $workingdirectory ]]
        then
                read -r -p "Le dossier n'existe pas. Voulez-vous le créer [y/n]?" reponse
                case "$reponse" in
                    oui | Oui | OUI | o | O | yes | Yes | YES | y | Y ) mkdir $workingdirectory echo "[x]Dossier créé";;
                    non | Non | NON | n | N | no | NO | No | n | N ) echo "Retour au choix de dossier" i=0;;
                    *) echo "Error syntax !" i=0;;
                esac 
        fi
else
    echo "Le dossier existe déjà" 
fi

read -r -p "Les fichiers seront enregistrés dans $PWD/$workingdirectory. Voulez-vous continuer ? [Y/N] : " continuer

case "$continuer" in
        oui | Oui | OUI | o | O | yes | Yes | YES | y | Y ) echo "[x]Fichier HTML crée" echo "[x]Fichier Css crée" echo "[x]Fichier Js crée";;
        non | Non | NON | n | N | no | NO | No | n | N ) echo "Retour au choix de dossier" i=0;;
        *) echo "Error syntax !" i=0;;
esac 

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