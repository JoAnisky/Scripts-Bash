#!bin/bash
read -r -p "Entrez un nom pour votre fichier .html (sans ecrire .html) : " htmlfilename
read -r -p "Entrez un nom pour votre fichier .css (sans ecrire .css) : " cssfilename
read -r -p "Entrez le titre de votre page html : " pagetitle
read -r -p "Où voulez-vous enregistrer le fichier ? " workingdirectory
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
cat << EOF > $workingdirectory/$cssfilename.css
body{
    margin:0;
    padding:0;
}
EOF