#!/bin/bash
# This file contains a script for installing 
# the necessary files for the second lab assignment (Neo4j) of  the Big Data class.
# Author: Gianluca Quercini
# Year : 2017 - 2018


echo -e "\n******\n\nFichier d'installation du BE 2 du cours Big Data.\nAuteur : Gianluca QUERCINI\nAnnée : 2017 - 2018\n\n******\n"

wdir='bigdata-be2'
if [ -d ~/$wdir ]; then 
  echo -e "Elimination des anciens fichiers d'installation"
  ~/$wdir/neo4j-community-2.3.7/bin/neo4j stop  > /dev/null 2>&1
  rm -rf ~/$wdir
fi  
mkdir ~/$wdir
echo -e "Installation de Neo4j..."
cat neo4j-community-2.3.7-unix.tar.gz.part-* |gunzip -c > ~/$wdir/neo4j-community-2.3.7-unix.tar.gz
tar xzf ~/$wdir/neo4j-community-2.3.7-unix.tar.gz -C ~/$wdir
echo -e "Importation des données dans Neo4j..."
unzip -qq  graph.db.zip  -d  ~/$wdir/neo4j-community-2.3.7/data
echo -e "Lancement du serveur Neo4j..."
sed -i -e "s/\(dbms.security.auth_enabled=\).*/\1false/" ~/$wdir/neo4j-community-2.3.7/conf/neo4j-server.properties
~/$wdir/neo4j-community-2.3.7/bin/neo4j start > /dev/null 2>&1
xdg-open http://localhost:7474  > /dev/null 2>&1 &
echo -e "L'interface Web est maintenant disponible dans votre navigateur"
xterm -e "~/$wdir/neo4j-community-2.3.7/bin/neo4j-shell" &
echo -e "La shell des commandes Neo4j est maintenant disponible"
echo  -e "\n*** L'installation est finie, bon travail! ***\n"
