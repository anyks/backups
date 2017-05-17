#!/usr/bin/env bash
#
#       author: Forman
#       skype:  efrantick
#       phone:  +7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - to work with the database Redis${c_nc}"
# Считываем параметры из конфигурационного файла
config_params="host port user rpass upass bin dump"
# Извлекаем данные из конфигурационного файла
source ${confsh}
# Выводим сообщение
print_log "Dump data Redis"
{
		# Приводим переменные к нормальному виду
		host=$(eval echo \${${module}_host})
		port=$(eval echo \${${module}_port})
		user=$(eval echo \${${module}_user})
		password=$(eval echo \${${module}_upass})
		rpassword=$(eval echo \${${module}_rpass})
		bin=$(eval echo \${${module}_bin})
		dump=$(eval echo \${${module}_dump})
		
		# Делаем дамп базы данных
		sshpass -p "${password}" ssh -o StrictHostKeyChecking=no ${user}@${host} "${bin}/redis-cli -h ${host} -p ${port} -a ${rpassword} save"
		# Создаем каталог с дампом Redis
		mkdir ${img}/${module}_${date}
		# Копируем дамп с сервера
		sshpass -p "${password}" scp -o StrictHostKeyChecking=no -r ${user}@${host}:${dump}/dump.rdb ${img}/${module}_${date}
		# Сжимаем дамп Redis
		compressFile ${img} ${module}_${date} ${img} ${module}
		# Удаляем старые данные базы
		rm -rf ${img}/${module}_${date}
		
} 2>&1 | tee ${log}/${module}_${date}.log