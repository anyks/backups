#!/bin/bash
# 
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - to work with the database Redis${c_nc}"
# Считываем параметры из конфигурационного файла
config_params="host port password bin dump"
# Извлекаем данные из конфигурационного файла
source ${confsh}
# Выводим сообщение
print_log "Dump data Redis"
# Получаем значение переменных
eval dump=\${${module}_dump}
eval bin=\${${module}_bin}
eval host=\${${module}_host}
eval port=\${${module}_port}
eval password=\${${module}_password}
{
	# Удаляем старые базы данных
	rm -rf ${dump}/*.rdb
	# Получаем дамп базы данных
	${bin}/redis-cli -h ${host} -p ${port} -a ${password} save
	# Создаем каталог с дампом Redis
	mkdir ${img}/${module}_${date}
	# Перемещаем дамп базы данных Redis
	mv ${dump}/dump.rdb ${img}/${module}_${date}
	# Сжимаем дамп Redis
	compressFile ${img} ${module}_${date} ${img} ${module}
	# Удаляем старые данные базы
	rm -rf ${img}/${module}_${date}
} 2>&1 | tee ${log}/${module}_${date}.log