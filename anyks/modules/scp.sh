#!/usr/bin/env bash
#
#       author: Forman
#       skype:  efrantick
#       phone:  +7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - for backup remote files${c_nc}"
# Считываем параметры из конфигурационного файла
config_params="user password"
# Извлекаем данные из конфигурационного файла
source ${confsh}
# Выводим сообщение
print_log "Assemble archives"
{
	# Копирование файлов со сторонних серверов
	# Текущие переменные
	ldir="/usr/local"
	setc="etc"
	swww="www"
	retc="usr_local_etc"
	rwww="usr_local_www"
	# Приводим в нормальный вид переменные из конфига
	user=$(eval echo \${${module}_user})
	password=$(eval echo \${${module}_password})
	
	# Получаем конфигурационный файл доменов
	domains_list=${root}/anyks/conf/${module}_domains
	
	# Проверяем на существование файла
	if [ -f ${domains_list} ]; then

		# Переходим по всем доменам
		for domain in $(cat $domains_list)
		do
			# Если домен существует
			if [ "${domain}" != "" ]; then
				# Выполняем копирование конфигов
				sshpass -p "${password}" scp -o StrictHostKeyChecking=no -r ${user}@${domain}:/${setc} ${img}/${domain}_${setc}
				sshpass -p "${password}" scp -o StrictHostKeyChecking=no -r ${user}@${domain}:${ldir}/${setc} ${img}/${domain}_${retc}
				sshpass -p "${password}" scp -o StrictHostKeyChecking=no -r ${user}@${domain}:${ldir}/${swww} ${img}/${domain}_${rwww}
				compressFile ${img} ${domain}_${setc} ${img} ${domain}_${setc}
				compressFile ${img} ${domain}_${retc} ${img} ${domain}_${retc}
				compressFile ${img} ${domain}_${rwww} ${img} ${domain}_${rwww}
				rm -rf ${img}/${domain}_${setc}
				rm -rf ${img}/${domain}_${retc}
				rm -rf ${img}/${domain}_${rwww}
			fi
		done
		
	fi
} 2>&1 | tee ${log}/${module}_${date}.log
