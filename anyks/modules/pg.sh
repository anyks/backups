#!/bin/bash
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
# Получаем значение переменных
eval bin=\${${module}_bin}
eval db=\${${module}_db}
eval user=\${${module}_user}
eval host=\${${module}_host}
eval port=\${${module}_port}
eval password=\${${module}_password}
{
	# Запоминаем пароль к базе
	PGPASSWORD=${password}
	# Экспортируем пароль
	export PGPASSWORD
	# Получаем дамп базы данных
	${bin}/pg_dumpall --clean --superuser=${user} --host=${host} --port=${port} --database=${db} --verbose | gzip -c > ${img}/${module}_${date}.gz
} 2>&1 | tee ${log}/${module}_${date}.log