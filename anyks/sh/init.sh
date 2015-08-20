#!/bin/sh
# 
#	author:	Forman
#	skype:	efrantick
#	phone:	+7(920)672-33-22
#

# Текущая дата
readonly date=`date "+%Y-%m-%d-%T"`
# Каталог с файлами бекапов
readonly img=${root}/anyks/img
# Каталог для файлов с логами
readonly log=${root}/anyks/log
# Файл скрипта чтения конфигурационных файлов
readonly confsh=${root}/anyks/sh/conf.sh
# Список цветов
readonly t_bold='\033[1m'			# Жирный текст
readonly t_undr='\033[4m'			# Наклонный текст
readonly c_red='\033[0;31m' 		# Красный
readonly c_green='\033[38;5;148m'	# Зеленый
readonly c_yellow='\033[38;5;220m'	# Желтый
readonly c_nc='\033[0m'				# Без цвета
# Получаем список модулей
modules=""
while read -r LINE; do
	# Запоминаем полученные модули
	modules="${modules} ${LINE}"
done < ${root}/anyks/modules/index
# Список модулей (Модули указываются в порядке выполнения, названия модулей с маленькой буквы. Названия модулей должны совпадать с именами файлов)
readonly modules=${modules}

# Функция сжатия файлов ($1 - каталог где хранится файл, $2 - файл для сжатия, $3 - каталог для сохранения файлов, $4 - название архива)
compressFile(){
	# Выполняем сжатие файлов
	cd $1 && tar czvf $3/$4_${date}.tar.gz $2
}

# Функция вывода логов на экран или в файлы
print_log(){
	# Переводим значение переменной в нижний регистр
	logfile=$(echo $logfile | tr '[A-Z]' '[a-z]')
	# Если нужно выводить информацию в файл
	if [ "$logfile" = "yes" ]; then
		# Выводим в файл входящий текст
		echo "[`date`]" - $(echo $1 | tr -d "${c_red}${c_green}${c_yellow}${t_undr}${t_bold}${c_nc}") >> ${log}/backup_${date}.log
	else
		# Выводим на экран входящий текст
		echo -e $1;
	fi
}

# Подгружаем все модули
for module in $modules
do
	# Если ftp сервер активирован или это не ftp сервер
	if [ "$module" = "ftp" ] && [ "$ftp" = "yes" ] || [ "$module" != "ftp" ]; then
		# Получаем адрес файла модуля
		file=${root}/anyks/modules/$module.sh
		# Проверяем на существование файла
		if [ -f ${file} ]; then
			# Выводим сообщение об инициализации модуля
			print_log "${t_undr}Run module initialization ${c_green}${module}${c_nc}"
			# Выполняем инициализацию
			source ${file}
			# Сообщаем результат операции
			print_log "${c_green}Module ${t_bold}${module}${c_nc} ${c_green}complete${c_nc}"
		else
			# Сообщаем что модуль не найден
			print_log "${c_red}Module ${module} was not found${c_nc}"
		fi
	fi
done

# Если нужно удалить остатки после загрузки на ftp сервер
if [ "$ftp" = "yes" ]; then
	# Выводим сообщение об удалении файлов
	print_log "Remove completed files from backups"
	# Удаляем старые файлы бекапов
	rm -rf ${img}/*
fi

# Выводим сообщение что все удачно выполнено
print_log "${c_green}Congratulations, your system backup is made successfully!${c_nc}"