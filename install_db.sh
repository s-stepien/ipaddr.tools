#!/bin/bash

rm -rf db
mkdir -p db
cd db

wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz

tar xfz GeoLite2-City.tar.gz --strip-components 1 
tar xfz GeoLite2-Country.tar.gz --strip-components 1
