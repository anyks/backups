#!/usr/bin/env bash
#
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - to work with the database PostgreSQL${c_nc}"
# Считываем параметры из конфигурационного файла
config_params="host port db user password bin"
# Извлекаем данные из конфигурационного файла
source ${confsh}
# Выводим сообщение
print_log "Dump all databases PostgreSQL"
{
	# Запоминаем пароль к базе
	PGPASSWORD=$(eval echo \${${module}_password})
	# Экспортируем пароль
	export PGPASSWORD
	# Получаем дамп базы данных
	$(eval echo \${${module}_bin})/pg_dumpall --clean --superuser=$(eval echo \${${module}_user}) --host=$(eval echo \${${module}_host}) --port=$(eval echo \${${module}_port}) --database=$(eval echo \${${module}_db}) --verbose | gzip -c > ${img}/${module}_${date}.gz
} 2>&1 | tee ${log}/${module}_${date}.log