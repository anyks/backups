#!/bin/bash
# 
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Получаем корневую дирректорию
readonly root=$(cd "$(dirname "$0")" && pwd)
# Значение переменных по умолчанию
ftp="no"
logfile="no"
# Приводим к нижнему регистру первый параметр
use_ftp=$(echo $1 | tr '[A-Z]' '[a-z]')
# Приводим к нижнему регистру второй параметр
use_log=$(echo $2 | tr '[A-Z]' '[a-z]')

# Определяем активирован ли ftp сервер
case $use_ftp in
	log)
		# Активируем log файл
		logfile="yes"
	;;
	ftp)
		# Активируем ftp сервер
		ftp="yes"
	;;
	*)
		# Деактивируем ftp сервер
		ftp="no"
	;;
esac

# Определяем активировано ли запись событий в log файл
case $use_log in
	ftp)
		# Активируем ftp сервер
		ftp="yes"
	;;
	log)
		# Активируем log файл
		logfile="yes"
	;;
	*)
		# Деактивируем log файл
		logfile="no"
	;;
esac

# Выполняем инициализацию системы бекапа
source ${root}/anyks/sh/init.sh

# Выходим
exit 0