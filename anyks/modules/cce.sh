#!/bin/bash
#
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - for combining the collected archives of backups${c_nc}"
# Выводим сообщение
print_log "Assemble archives"
{
	# Выполняем сжатие файлов архивов
	compressFile ${img}/../ img /tmp ${module}
	# Удаляем старые файлы бекапов
	rm -rf ${img}/*
	# Переносим файл бекапов обратно
	mv /tmp/${module}_${date}.tar.gz ${img}
} 2>&1 | tee ${log}/${module}_${date}.log