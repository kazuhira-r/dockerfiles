#!/bin/bash

# CN => my.nexus.repo.example.com
# password => password
#keytool -keystore etc/ssl/keystore.jks -alias nexus -genkey -keyalg RSA -sigalg SHA256withRSA
keytool -keystore keystore.jks -alias nexus -genkey -keyalg RSA -sigalg SHA256withRSA
