#!/bin/bash
# 
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - to work with the database MongoDB${c_nc}"
# Считываем параметры из конфигурационного файла
config_params="host port user password bin"
# Извлекаем данные из конфигурационного файла
source ${confsh}
# Выводим сообщение
print_log "Dump all databases MongoDB"
# Получаем значение переменных
eval bin=\${${module}_bin}
eval host=\${${module}_host}
eval port=\${${module}_port}
{
	# Создаем каталог с дампом MongoDB
	mkdir ${img}/${module}_${date}
	# Получаем дамп базы данных
	${bin}/mongodump --host ${host} --port ${port} --out ${img}/${module}_${date}
	# Сжимаем дамп MongoDB
	compressFile ${img} ${module}_${date} ${img} ${module}
	# Удаляем старые данные базы
	rm -rf ${img}/${module}_${date}
} 2>&1 | tee ${log}/${module}_${date}.log