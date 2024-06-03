#!/bin/bash

# Variables
DB_PATH="/home/ladane/www/flask/database.db"
BACKUP_PATH=" /home/ladane/www/flask/backup"
DATE=$(date +"%Y%m%d%H%M")
BACKUP_FILE="database_backup_$DATE.db"
REMOTE_USER="TOUR"
REMOTE_HOST="82.64.164.84"
REMOTE_PATH="/backup/"

# Copier la base de données
cp $DB_PATH $BACKUP_PATH/$BACKUP_FILE

# Envoyer le fichier de sauvegarde à la machine personnelle
scp -i ~/.ssh/id_rsa_backup $BACKUP_PATH/$BACKUP_FILE $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH
