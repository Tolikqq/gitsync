

Процедура СобратьПакет(Знач КаталогПроекта, Знач ПутьКМанифестуСборки)

	КомандаOpm = Новый Команда;
	// КомандаOpm.УстановитьРабочийКаталог(Каталог);
	КомандаOpm.УстановитьКоманду("opm");
	КомандаOpm.ДобавитьПараметр("build");
	КомандаOpm.ДобавитьПараметр("-m");
	КомандаOpm.ДобавитьПараметр(ПутьКМанифестуСборки);
	КомандаOpm.ДобавитьПараметр(КаталогПроекта);
	КомандаOpm.ПоказыватьВыводНемедленно(Истина);

	КодВозврата = КомандаOpm.Исполнить();

	Если КодВозврата <> 0  Тогда
		ВызватьИсключение КомандаOpm.ПолучитьВывод();
	КонецЕсли;

КонецПроцедуры

Процедура ПолезнаяРабота()

	ТекущийКаталогЗадачи = ТекущийСценарий().Каталог;

	КаталогПроекта = Новый Файл(ОбъединитьПути(ТекущийКаталогЗадачи, "..")).ПолноеИмя;
	
	ПутьКМанифестуСборки = ОбъединитьПути(КаталогПроекта, "build_packagedef");

	СобратьПакет(КаталогПроекта, ПутьКМанифестуСборки);

КонецПроцедуры

КаталогПроекта = ОбъединитьПути(ТекущийСценарий().Каталог, "..");
// Лог.УстановитьУровень(УровниЛОга.отладка);

ПолезнаяРабота();