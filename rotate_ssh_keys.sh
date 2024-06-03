#!/bin/bash

# Variables
NEW_KEY_PATH="$HOME/.ssh/id_rsa_new"
OLD_KEY_PATH="$HOME/.ssh/old"
BACKUP_MACHINE="TOUR@82.64.164.84:/backup"

# Générer une nouvelle clé SSH
ssh-keygen -t rsa -b 4096 -f $NEW_KEY_PATH -N ""

# Backup de l'ancienne clé
mkdir -p $OLD_KEY_PATH
mv $HOME/.ssh/id_rsa $OLD_KEY_PATH/id_rsa_$(date +"%Y%m%d%H%M")
mv $HOME/.ssh/id_rsa.pub $OLD_KEY_PATH/id_rsa.pub_$(date +"%Y%m%d%H%M")

# Déplacer la nouvelle clé
mv $NEW_KEY_PATH $HOME/.ssh/id_rsa
mv $NEW_KEY_PATH.pub $HOME/.ssh/id_rsa.pub

# Envoyer la nouvelle clé à la machine personnelle
scp $HOME/.ssh/id_rsa $BACKUP_MACHINE/id_rsa
scp $HOME/.ssh/id_rsa.pub $BACKUP_MACHINE/id_rsa.pub
