#!/bin/bash
# 
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - to work with the database MySQL${c_nc}"
# Считываем параметры из конфигурационного файла
config_params="host port user password bin"
# Извлекаем данные из конфигурационного файла
source ${confsh}
# Выводим сообщение
print_log "Dump all databases MySQL"
{
	# Исправляем базу данных
	$(eval echo \${${module}_bin})/mysqlcheck --user=$(eval echo \${${module}_user}) --host=$(eval echo \${${module}_host}) --password=$(eval echo \${${module}_password}) --port=$(eval echo \${${module}_port}) --repair --all-databases --verbose
	# Получаем дамп базы данных
	$(eval echo \${${module}_bin})/mysqldump --user=$(eval echo \${${module}_user}) --host=$(eval echo \${${module}_host}) --password=$(eval echo \${${module}_password}) --port=$(eval echo \${${module}_port}) --all-databases --verbose | gzip -c > ${img}/${module}_${date}.gz
} 2>&1 | tee ${log}/${module}_${date}.log