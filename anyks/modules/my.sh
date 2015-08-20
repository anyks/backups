#!/bin/sh
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
	# Получаем дамп базы данных
	${my_bin}/mysqldump -u${my_user} -h${my_host} -p${my_password} --port=${my_port} --all-databases | gzip -c > ${img}/mysql_${date}.gz
} 2>&1 | tee ${log}/${module}_${date}.log