#!/bin/bash
# Restore most recent backup to the panther live env                    #
# Download backup from appserver and push to Valhalla                   #
# WARNING: Run this script within the same hour as the previous deploy. #
# Otherwise replace `date +%F-%I%p` with desired time stamp             #
# (e.g.   2015-10-12-4PM)                                               #
#                                                                       #
#       Note: Clear cache on $ENV after executing this script           #

# Define env and site UUID
export ENV=dev
export SITE=e730eb99-acfa-4822-b233-47faeb7e7b5b

# Pull backup down from app server
rsync -rlvz --size-only --ipv4 --progress -e 'ssh -p 2222' $ENV.$SITE@appserver.$ENV.$SITE.drush.in:files/docs-backups/`date +%F-%I%p`/ ../docs-backups/`date +%F-%I%p`/


# Restore backup to to $ENV.$SITE@appserver.$ENV.$SITE.drush.in:files/docs
rsync -rlvza --temp-dir=../../tmp/ --delete-after --ipv4 --progress -e 'ssh -p 2222' ../docs-backups/`date +%F-%I%p`/docs/* $ENV.$SITE@appserver.$ENV.$SITE.drush.in:files/docs
