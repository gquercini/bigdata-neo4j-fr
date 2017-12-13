#!/bin/bash
# This file contains a script for installing 
# the necessary files for the second lab assignment (Neo4j) of  the Big Data class.
# Author: Gianluca Quercini
# Year : 2017 - 2018

wdir='bigdata-be2'
cd ~
if [ -d $wdir ]; then 
  echo -e "Elimination des anciens fichiers d'installation"
  ./$wdir/neo4j-community-2.3.7/bin/neo4j stop  > /dev/null 2>&1
  rm -rf ./$wdir
fi  
mkdir $wdir
cd $wdir
echo -e "Téléchargement du jeu de données...."
curl https://files.slack.com/files-pri/T8AS5C97H-F8CQJNVBN/download/graph.db.zip?pub_secret=f8155bf35e --output graph.db.zip --silent
echo "Téléchargement de Neo4j..." 
curl https://files.slack.com/files-pri/T8AS5C97H-F8CTWG77F/download/neo4j-community-2.3.7-unix.tar.gz?pub_secret=fba55c2e20 --output neo4j-community-2.3.7-unix.tar.gz --silent
echo -e "Installation de Neo4j..."
tar xzf neo4j-community-2.3.7-unix.tar.gz
echo -e "Importation des données dans Neo4j..."
unzip -qq  graph.db.zip  -d  ./neo4j-community-2.3.7/data
echo -e "Lancement du serveur Neo4j..."
sed -i -e "s/\(dbms.security.auth_enabled=\).*/\1false/" ./neo4j-community-2.3.7/conf/neo4j-server.properties
./neo4j-community-2.3.7/bin/neo4j start > /dev/null 2>&1
xdg-open http://localhost:7474  > /dev/null 2>&1 &
echo -e "L'interface Web est maintenant disponible dans votre navigateur"
xterm -e "./neo4j-community-2.3.7/bin/neo4j-shell" &
echo -e "La shell des commandes Neo4j est maintenant disponible"
echo  -e "L'installation est finie, bon travail!"
