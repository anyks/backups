#!/bin/sh
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

{
	# Удаляем старые базы данных
	rm -rf ${redis_dump}/*.rdb
	# Получаем дамп базы данных
	${redis_bin}/redis-cli -h ${redis_host} -p ${redis_port} -a ${redis_password} save
	# Создаем каталог с дампом Redis
	mkdir ${img}/${module}_${date}
	# Перемещаем дамп базы данных Redis
	mv ${redis_dump}/dump.rdb ${img}/${module}_${date}
	# Сжимаем дамп Redis
	compressFile ${img} ${module}_${date} ${img} ${module}
	# Удаляем старые данные базы
	rm -rf ${img}/${module}_${date}
} 2>&1 | tee ${log}/${module}_${date}.log