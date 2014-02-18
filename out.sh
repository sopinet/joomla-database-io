#!/usr/bin/env bash

#
# Fernando Hidalgo - Sopinet
# 23 - Octubre - 2013
# Script para Linux en Bash que empaqueta automáticamente una base de datos
# desde el Gestor de Contenidos Joomla en el fichero database.sql
#

while read linea
do
	if [[ "$linea" == *"public \$host"* ]]
	then
		IFS="'" read -a array <<< "$linea"
		host=${array[1]}
	fi

	if [[ "$linea" == *"public \$user"* ]]
	then
		IFS="'" read -a array <<< "$linea"
		user=${array[1]}
	fi

	if [[ "$linea" == *"public \$password"* ]]
	then
		IFS="'" read -a array <<< "$linea"
		password=${array[1]}
	fi

	if [[ "$linea" == *"public \$db ="* ]]
	then
		IFS="'" read -a array <<< "$linea"
		db=${array[1]}
	fi
done < configuration.php

echo "Host: $host";
echo "Usuario: $user";
#echo "Contraseña: $password";
echo "Base de datos: $db";

mysqldump -u $user -p$password $db > database.sql
