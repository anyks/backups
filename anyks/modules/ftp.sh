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
# Логинимся на ftp сервере
ftp -n $(eval echo \${${module}_host}) $(eval echo \${${module}_port}) <<END_SCRIPT
quote USER $(eval echo \${${module}_user})
quote PASS $(eval echo \${${module}_password})
binary
prompt
cd $(eval echo \${${module}_remdir})
mkdir $(eval echo \${${module}_remdir})$(eval echo \${${module}_olddir})
mdelete $(eval echo \${${module}_remdir})$(eval echo \${${module}_olddir})/*
rmdir $(eval echo \${${module}_remdir})$(eval echo \${${module}_olddir})
rename $(eval echo \${${module}_remdir})$(eval echo \${${module}_curdir}) $(eval echo \${${module}_remdir})$(eval echo \${${module}_olddir})
mkdir $(eval echo \${${module}_remdir})$(eval echo \${${module}_curdir})
cd $(eval echo \${${module}_remdir})$(eval echo \${${module}_curdir})
lcd ${img}
mput $(eval echo \${${module}_file})
ls
quit
END_SCRIPT