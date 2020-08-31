#Использовать AutoUpdateIB
#Использовать ReadParams
#Использовать logos
#Использовать v8runner

Конфигуратор = Новый УправлениеКонфигуратором();

файлПараметров = ОбъединитьПути(ТекущийКаталог(),"updparams.txt");
ошибкиЧтения = "";


прочитанныеПараметры = ЧтениеПараметров.Прочитать(АргументыКоманднойСтроки[0], ошибкиЧтения );
Если ПустаяСтрока(ошибкиЧтения[файлПараметров]) Тогда
	Сообщить("ТипПараметров: "+типзнч(прочитанныеПараметры)+ ", Количество "+прочитанныеПараметры.Количество() );
Иначе
	ВызватьИсключение "Ошибки чтения параметров: "+ошибкиЧтения[файлПараметров];
КонецЕсли;
Если прочитанныеПараметры.Количество()=0 Тогда 
	ВызватьИсключение "Параметров прочитано 0";
КонецЕсли;

ИмяБазы 										= прочитанныеПараметры["ИмяБазы"]+"_";

КаталогСобновлением 							= прочитанныеПараметры[ИмяБазы+"КаталогОбновления"];
КаталогБазы 									= прочитанныеПараметры[ИмяБазы+"КаталогИБ"];
ЛогинПользователяИБ 							= прочитанныеПараметры[ИмяБазы+"ИмяПользователяИБ"];
ПарольПользователяИБ 							= прочитанныеПараметры[ИмяБазы+"ПарольПользователяИБ"];
ИспользоватьПолныйДистрибутивДляОбновления		= прочитанныеПараметры[ИмяБазы+"ИспользоватьПолныйДистрибутив"];
ИмяКонфигурации									= прочитанныеПараметры[ИмяБазы+"ИмяКонфигурации"];
ВерсияРелиза									= прочитанныеПараметры[ИмяБазы+"ВерсияРелиза"];
Платформа										= прочитанныеПараметры[ИмяБазы+"Платформа"];
ОбновитьДо										= прочитанныеПараметры[ИмяБазы+"ОбновитьДо"];


сообщить(ИмяБазы +", Обновить = "+прочитанныеПараметры["ОбновитьКонфу"]
+", КаталогБазы = "+КаталогБазы
+", ИмяКонфигурации = "+ИмяКонфигурации);


ЕстьОшибки = ложь;
Сообщить("Старт: "+ТекущаяДата());
Если прочитанныеПараметры["ОбновитьКонфу"] Тогда //Автоматически
	Обновление = новый Обновлятор();
	Обновление.УстановитьПараметрыАутентификации("Sattarov", "Gkj[jnybrjd");
	ПараметрыОбновленияКонфигурации = Обновление.ПолучитьПараметрыОбновленияКонфигурации(ИмяКонфигурации,ВерсияРелиза,Платформа); 		
	ПараметрыОбновленияКонфигурации.Вставить("СЗ_ОбновитьДо", ОбновитьДо);
	ПараметрыПодключения = Обновление.ПолучитьПараметрыПодключения(,КаталогБазы,,,,
							ЛогинПользователяИБ,ПарольПользователяИБ);
	Обновление.УстановитьКаталоги(прочитанныеПараметры["КаталогОбновлений"]);
	Обновление.ОбновитьИнформационнуюБазу(ПараметрыОбновленияКонфигурации,ПараметрыПодключения,Истина,Ложь);
	//Если не ЕстьОшибки И прочитанныеПараметры["РазрешитьВходВБазу"] Тогда
	//	Обновление.РазрешитьПодключение(ПараметрыПодключения);
	//КонецЕсли;
КонецЕсли;
Если прочитанныеПараметры["РазрешитьВходВБазу"] Тогда
	Обновление = новый Обновлятор();
	Обновление.УстановитьПараметрыАутентификации("Sattarov", "Gkj[jnybrjd");
	ПараметрыОбновленияКонфигурации = Обновление.ПолучитьПараметрыОбновленияКонфигурации(ИмяКонфигурации,ВерсияРелиза); 		
	ПараметрыПодключения = Обновление.ПолучитьПараметрыПодключения(,КаталогБазы,,,,
							ЛогинПользователяИБ,ПарольПользователяИБ);
	Обновление.РазрешитьПодключение(ПараметрыПодключения);
КонецЕсли;

КаталогБазы = """"+КаталогБазы+"""";
Конфигуратор.УстановитьКонтекст("/F"+КаталогБазы,ЛогинПользователяИБ, ПарольПользователяИБ);
Конфигуратор.ИспользоватьВерсиюПлатформы(прочитанныеПараметры["ИспользоватьВерсиюПлатформы"]);


Если прочитанныеПараметры["ОбновитьКонфигурацию"] Тогда
	Попытка
		Конфигуратор.УстановитьИмяФайлаСообщенийПлатформы(ОбъединитьПути(ТекущийКаталог(),"upd.log"));
		Конфигуратор.ОбновитьКонфигурацию(КаталогСобновлением,ИспользоватьПолныйДистрибутивДляОбновления);
		Сообщить("Конфигурация обновлена");
	Исключение
		// вывод log-файла с сообщениями от платформы.
		Сообщить(Конфигуратор.ВыводКоманды());
		ЕстьОшибки = Истина;
	КонецПопытки;
КонецЕсли;
Если не ЕстьОшибки И прочитанныеПараметры["ОбновитьКонфигурациюБД"] Тогда
	Попытка
		Конфигуратор.УстановитьИмяФайлаСообщенийПлатформы(ОбъединитьПути(ТекущийКаталог(),"upddb.log"));
		Конфигуратор.ОбновитьКонфигурациюБазыДанных();
		Сообщить("Конфигурация БД обновлена");
	Исключение
		// вывод log-файла с сообщениями от платформы.
		Сообщить(Конфигуратор.ВыводКоманды());
	КонецПопытки;
КонецЕсли;
Если прочитанныеПараметры["ОчиститьКЭШ"] Тогда
	Конфигуратор.УстановитьИмяФайлаСообщенийПлатформы(ОбъединитьПути(ТекущийКаталог(),"run.log"));
	Конфигуратор.ЗапуститьВРежимеПредприятия("ClearCache");
КонецЕсли;
Если прочитанныеПараметры["ЗагрузитьДТ"] Тогда
	ФайлАрхива = прочитанныеПараметры["ФайлАрхива"];
	Попытка
		Конфигуратор.ЗагрузитьИнформационнуюБазу(ФайлАрхива);
	Исключение
		// вывод log-файла с сообщениями от платформы.
		Сообщить(ФайлАрхива);
	КонецПопытки;
КонецЕсли;
Если прочитанныеПараметры["ОткрытьКонфигуратор"] Тогда
	ПараметрыСвязиСБазой = Конфигуратор.ПолучитьПараметрыЗапуска();
	ПараметрыСвязиСБазой[0] = "DESIGNER";

	Конфигуратор.ВыполнитьКоманду(ПараметрыСвязиСБазой);
КонецЕсли;

Если не ЕстьОшибки И прочитанныеПараметры["ЗапуститьИБ"] Тогда
	Конфигуратор.ЗапуститьВРежимеПредприятия();
КонецЕсли;
Сообщить("Финиш: "+ТекущаяДата());