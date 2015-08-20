#!/bin/sh
# 
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - to work with the database PostgreSQL${c_nc}"
# Считываем параметры из конфигурационного файла
config_params="host port user password bin"
# Извлекаем данные из конфигурационного файла
source ${confsh}
# Выводим сообщение
print_log "Dump all databases PostgreSQL"

{
	# Запоминаем пароль к базе
	PGPASSWORD=${pg_password}
	# Экспортируем пароль
	export PGPASSWORD
	# Получаем дамп базы данных
	${pg_bin}/pg_dumpall --clean --superuser=${pg_user} --host=${pg_host} --port=${pg_port} | gzip -c > ${img}/pgsql_${date}.gz
} 2>&1 | tee ${log}/${module}_${date}.log