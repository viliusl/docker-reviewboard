#!/bin/bash

# fix database permissions
chown -R www-data:www-data /srv/reviews.local/data

# run supervisor
/usr/bin/supervisord -n