#!/usr/bin/env bash
#
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Конфигурационный файл
config=${root}/anyks/conf/$module.conf

# Проверяем на существование файла
if [ -f ${config} ]; then
	# Подгружаем данные из конфига
	for param in $config_params
	do
		# Извлекаем данные из конфиг файла
		new_param=`awk -F"[,:]" '{for(i=1;i<=NF;i++){if($i~/'${param}'\042/){print $(i+1)}}}' "${config}"`
		new_param=`echo ${new_param} | tr -d \"`
		# Создаем переменную нужного нам вида
		eval ${module}_${param}=${new_param}
	done
fi