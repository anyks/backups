#!/bin/bash
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
# Получаем значение переменных
eval user=\${${module}_user}
eval host=\${${module}_host}
eval port=\${${module}_port}
eval password=\${${module}_password}
eval remdir=\${${module}_remdir}
eval curdir=\${${module}_curdir}
eval olddir=\${${module}_olddir}
eval file=\${${module}_file}
# Логинимся на ftp сервере
ftp -n ${host} ${port} <<END_SCRIPT
quote USER ${user}
quote PASS ${password}
binary
prompt
cd ${remdir}
mkdir ${remdir}${olddir}
mdelete ${remdir}${olddir}/*
rmdir ${remdir}${olddir}
rename ${remdir}${curdir} ${remdir}${olddir}
mkdir ${remdir}${curdir}
cd ${remdir}${curdir}
lcd ${img}
mput ${file}
ls
quit
END_SCRIPT