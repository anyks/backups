#!/usr/bin/env bash
#
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - for backup files${c_nc}"
# Выводим сообщение
print_log "Assemble archives"
{
	# Выполняем сжатие файлов каталога /usr/local/etc
	compressFile /usr/local etc ${img} usr_local_etc
} 2>&1 | tee ${log}/${module}_${date}.log