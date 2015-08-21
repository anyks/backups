Backup System for UNIX (Linux, FreeBSD, MacOS X)
===========

Модульная система бекапов, простая в использовании и легко расширяемая.

Система предназначена для сбора дампов баз данных, копирования ценных файлов, упаковки в архивы и отправки на удаленный ftp сервер.

На данный момент реализованы следующие модули:
-------

``PostgreSQL - создает sql дамп всех баз данных``

``MySQL - создает sql дамп всех баз данных``

``MongoDB - создает json дампы всех баз данных``

``Redis - создает бинарный дамп всех баз данных``

``Files - копирует все указанные каталоги и файлы``

``FTP server - переносит на ftp сервер созданные бекапы, система хранит две версии бекапов (предыдущая и актуальная)``

Описание
-----

Система поддерживает логирование хода процесса в файлы и может производить сбор данных без отправки их на удаленный сервер

создание бекапов без отправки на сервер

`./backup.sh`

создание бекапов без отправки на сервер с записью хода процесса в файлы

`./backup.sh log`

создание бекапов и отправка на удаленный сервер ftp с записью хода процесса в файлы

`./backup.sh log ftp`

Настройка системы
-----

Все подключаемые модули находятся в файле

`anyks/modules/index`

в индексном файле указываются названия модулей, один модуль на строку (последняя строка обязательно должна быть пустой)

модули выполняются по порядку сверху-вниз, модули cce и ftp обязательны, они всегда должны находится последними в том же порядке

```
pg
my
mo
redis
files
cce
ftp

```

Конфигурационные файлы модулей находятся в каталоге "conf". Названия конфигурационных файлов совпадают с названиями модулей

`anyks/conf/redis.conf`

```
"host":		"192.168.0.1",
"port":		"6379",
"password":	"password",
"bin":		"/usr/local/bin",
"dump":		"/var/db/redis"
```

Пример модуля копирования файлов

`anyks/modules/files.sh`

------------

```
{

	# Выполняем сжатие файлов каталога /usr/local/etc
	compressFile /usr/local etc ${img} usr_local_etc

} 2>&1 | tee ${log}/${module}_${date}.log
```

```
compressFile	- производит сжатие файлов
/usr/local		- Каталог в котором находятся файлы или каталоги для архивирования
etc				- Каталог для архивирования
${img}			- Системный каталог куда помещаются архивы файлов (anyks/img)
usr_local_etc	- Название файла архива

в результате данной операции в каталоге anyks/img будет создан архив usr_local_etc_[текущая_дата].tar.gz содержащий каталог /usr/local/etc
```
