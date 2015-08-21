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
# Получаем значение переменных
eval bin=\${${module}_bin}
eval user=\${${module}_user}
eval host=\${${module}_host}
eval port=\${${module}_port}
eval password=\${${module}_password}
{
	# Получаем дамп базы данных
	${bin}/mysqldump -u${user} -h${host} -p${password} --port=${port} --all-databases | gzip -c > ${img}/${module}_${date}.gz
} 2>&1 | tee ${log}/${module}_${date}.log