#!/bin/sh
# 
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Выводим сообщение о существовании модуля
print_log "${c_yellow}Module ${module} - to work from ftp server${c_nc}"
# Основные переменные конфигурационного файла (Результатом чтения файла будут переменные nameModule_nameParam)
config_params="host port user password remdir olddir curdir file"
# Загружаем данные из конфигурационного файла
source ${confsh}
# Выводим сообщение
print_log "Send files to ftp server backups"

# Логинимся на ftp сервере
ftp -n ${ftp_host} ${ftp_port} <<END_SCRIPT
quote USER ${ftp_user}
quote PASS ${ftp_password}
binary
prompt
cd ${ftp_remdir}
mkdir ${ftp_remdir}${ftp_olddir}
mdelete ${ftp_remdir}${ftp_olddir}/*
rmdir ${ftp_remdir}${ftp_olddir}
rename ${ftp_remdir}${ftp_curdir} ${ftp_remdir}${ftp_olddir}
mkdir ${ftp_remdir}${ftp_curdir}
cd ${ftp_remdir}${ftp_curdir}
lcd ${img}
mput ${ftp_file}
ls
quit
END_SCRIPT
#eval dd=\${${module}_${param}}
# echo $dd