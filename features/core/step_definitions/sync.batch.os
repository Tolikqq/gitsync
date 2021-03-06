﻿#Использовать tempfiles
// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯСоздаюНовыйОбъектПакетнаясинхронизация");
	ВсеШаги.Добавить("ЯСоздаюТестовойФайлAuthorsВКаталогеИзПеременной");
	ВсеШаги.Добавить("ЯЗаписываюВФайлVersionВКаталогеИзПеременной");
	ВсеШаги.Добавить("ЯДобавляюФайлВКаталогПроектаССодержанием");
	ВсеШаги.Добавить("ЯЗаменяюЗначениемИзПеременнойВФайле");
	ВсеШаги.Добавить("ЯУстанавливаюФайлНастройкиВПакетнаясинхронизация");
	ВсеШаги.Добавить("ЯУстанавливаюАвторизациюСПаролемВПакетнаясинхронизация");
	ВсеШаги.Добавить("ЯУстанавливаюВерсиюПлатформыВПакетнаясинхронизация");
	ВсеШаги.Добавить("ЯВыполняюВыполняютПакетнуюСинхронизацию");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт

КонецПроцедуры


//Я создаю новый объект ПакетнаяСинхронизация
Процедура ЯСоздаюНовыйОбъектПакетнаясинхронизация() Экспорт

	ПакетнаяСинхронизация = Новый ПакетнаяСинхронизация;
	
	БДД.СохранитьВКонтекст("ПакетнаяСинхронизация", ПакетнаяСинхронизация);

КонецПроцедуры

//Я добавляю файл "example.yaml" в каталог проекта с содержанием
//"""
//"""
Процедура ЯДобавляюФайлВКаталогПроектаССодержанием(Знач ИмяФайла, Знач ТекстФайла) Экспорт
	КаталогПроекта = БДД.ПолучитьИзКонтекста("КаталогПроекта");
	ФайлНастроек = Новый ЗаписьТекста;
	ФайлНастроек.Открыть(ОбъединитьПути(КаталогПроекта, ИмяФайла), "utf-8");
	ФайлНастроек.ЗаписатьСтроку(ТекстФайла);
	ФайлНастроек.Закрыть();
КонецПроцедуры

//Я заменяю "<КаталогХранилища1С_1>" значением из переменной "КаталогХранилища1С_1" в файле "example.yaml"
Процедура ЯЗаменяюЗначениемИзПеременнойВФайле(Знач ЗначениеПоиска, Знач ИмяПеременной, Знач ИмяФайла) Экспорт

	КаталогПроекта = БДД.ПолучитьИзКонтекста("КаталогПроекта");

	ПутьКФайлу = ОбъединитьПути(КаталогПроекта, ИмяФайла);

	ФайлНастроек = Новый ЧтениеТекста(ПутьКФайлу);
	ТекстФайла = ФайлНастроек.Прочитать();
	ФайлНастроек.Закрыть();

	ЗначениеЗамены = БДД.ПолучитьИзКонтекста(ИмяПеременной);

	ТекстФайла = СтрЗаменить(ТекстФайла, ЗначениеПоиска, ЗначениеЗамены);

	ФайлНастроек = Новый ЗаписьТекста;
	ФайлНастроек.Открыть(ПутьКФайлу, "utf-8");
	ФайлНастроек.ЗаписатьСтроку(ТекстФайла);
	ФайлНастроек.Закрыть();


КонецПроцедуры

//Я устанавливаю авторизацию "Администратор" с паролем "" в ПакетнаяСинхронизация
Процедура ЯУстанавливаюАвторизациюСПаролемВПакетнаясинхронизация(Знач Пользователь, Знач Пароль) Экспорт
	
	ПакетнаяСинхронизация = БДД.ПолучитьИзКонтекста("ПакетнаяСинхронизация");
	ПакетнаяСинхронизация.АвторизацияВХранилищеКонфигурации(Пользователь, Пароль);

КонецПроцедуры

//Я устанавливаю версию платформы "8.3" в ПакетнаяСинхронизация
Процедура ЯУстанавливаюВерсиюПлатформыВПакетнаясинхронизация(Знач ВерсияПлатформы) Экспорт

	ПакетнаяСинхронизация = БДД.ПолучитьИзКонтекста("ПакетнаяСинхронизация");
	ПакетнаяСинхронизация.ВерсияПлатформы(ВерсияПлатформы);

КонецПроцедуры

//Я выполняю выполняют пакетную синхронизацию
Процедура ЯВыполняюВыполняютПакетнуюСинхронизацию() Экспорт

	ПакетнаяСинхронизация = БДД.ПолучитьИзКонтекста("ПакетнаяСинхронизация");
	ПакетнаяСинхронизация.ВыполнитьСинхронизацию();

КонецПроцедуры

//Я устанавливаю файл настройки "example.yaml" в ПакетнаяСинхронизация
Процедура ЯУстанавливаюФайлНастройкиВПакетнаясинхронизация(Знач ИмяФайла) Экспорт
	
	КаталогПроекта = БДД.ПолучитьИзКонтекста("КаталогПроекта");

	ПутьКФайлу = ОбъединитьПути(КаталогПроекта, ИмяФайла);

	ПакетнаяСинхронизация = БДД.ПолучитьИзКонтекста("ПакетнаяСинхронизация");
	
	ПакетнаяСинхронизация.УстановитьНастройки(ПутьКФайлу);

КонецПроцедуры

//Я создаю тестовой файл AUTHORS в каталоге из переменной "ПутьКаталогаИсходников_1"
Процедура ЯСоздаюТестовойФайлAuthorsВКаталогеИзПеременной(Знач ИмяПеременной) Экспорт
	ПутьКаталогаИсходников = БДД.ПолучитьИзКонтекста(ИмяПеременной);
	ФайлАвторов = Новый ЗаписьТекста;
	ФайлАвторов.Открыть(ОбъединитьПути(ПутьКаталогаИсходников, "AUTHORS"), "utf-8");
	ФайлАвторов.ЗаписатьСтроку("Администратор=Администратор <admin@localhost>");
	ФайлАвторов.ЗаписатьСтроку("Отладка=Отладка <debug@localhost>");
	ФайлАвторов.Закрыть();
КонецПроцедуры

//Я записываю "0" в файл VERSION в каталоге из переменной "ПутьКаталогаИсходников_1"
Процедура ЯЗаписываюВФайлVersionВКаталогеИзПеременной(Знач НомерВерсии, Знач ИмяПеременной) Экспорт
	
	ПутьКаталогаИсходников = БДД.ПолучитьИзКонтекста(ИмяПеременной);
	
	ПутьКФайлуВерсий = ОбъединитьПути(ПутьКаталогаИсходников,"VERSION");
	Попытка
		Запись = Новый ЗаписьТекста(ПутьКФайлуВерсий, "utf-8");
		Запись.ЗаписатьСтроку("<?xml version=""1.0"" encoding=""UTF-8""?>");
		Запись.ЗаписатьСтроку("<VERSION>" + НомерВерсии + "</VERSION>");
		Запись.Закрыть();
	Исключение
		Если Запись <> Неопределено Тогда
			ОсвободитьОбъект(Запись);
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;
КонецПроцедуры
