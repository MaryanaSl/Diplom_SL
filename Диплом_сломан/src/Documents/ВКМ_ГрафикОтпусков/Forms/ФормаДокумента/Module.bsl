#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ПроверитьДлительностьОтпуска ();

КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОтпускаСотрудников
&НаКлиенте
Процедура ОтпускаСотрудниковПриИзменении(Элемент)
	ОтпускаСотрудниковПриИзмененииНаСервере();
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура АнализГрафика(Команда)
	
	АдресВремХранилища = ПоместитьВоВременноеХранТабЧастьГрафика ();
	
	ПередаваемыеПараметры = Новый Структура ("АдресВремХранилища", АдресВремХранилища);
	
	ОткрытьФорму("Документ.ВКМ_ГрафикОтпусков.Форма.АнализГрафика", ПередаваемыеПараметры, ЭтотОбъект,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОтпускаСотрудниковПриИзмененииНаСервере()
	ПроверитьДлительностьОтпуска ();
КонецПроцедуры

&НаСервере
Процедура ПроверитьДлительностьОтпуска()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.Сотрудник,
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.ДатаНачала,
	|	ВКМ_ГрафикОтпусковОтпускаСотрудников.ДатаОкончания
	|ПОМЕСТИТЬ ВТ_ГрафикТЧДок
	|ИЗ
	|	&ГрафикОтпусков КАК ВКМ_ГрафикОтпусковОтпускаСотрудников
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_ГрафикТЧДок.Сотрудник,
	|	РАЗНОСТЬДАТ(ВТ_ГрафикТЧДок.ДатаНачала, ДОБАВИТЬКДАТЕ(ВТ_ГрафикТЧДок.ДатаОкончания, День, 1), День) КАК ДнейОтпуска
	|ПОМЕСТИТЬ ВТ_КоличествоДнейОтпуска
	|ИЗ
	|	ВТ_ГрафикТЧДок КАК ВТ_ГрафикТЧДок
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_КоличествоДнейОтпуска.Сотрудник,
	|	СУММА(ВТ_КоличествоДнейОтпуска.ДнейОтпуска) КАК ДнейОтпуска
	|ПОМЕСТИТЬ ВТ_итог
	|ИЗ
	|	ВТ_КоличествоДнейОтпуска КАК ВТ_КоличествоДнейОтпуска
	|СГРУППИРОВАТЬ ПО
	|	ВТ_КоличествоДнейОтпуска.Сотрудник
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_итог.Сотрудник КАК Сотрудник
	|ИЗ
	|	ВТ_итог КАК ВТ_итог
	|ГДЕ
	|	ВТ_итог.ДнейОтпуска > 28";
	
	Запрос.УстановитьПараметр("ГрафикОтпусков", Объект.ОтпускаСотрудников.Выгрузить());
	
	Результат = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Сотрудник");
	
	Сотрудники = Новый СписокЗначений;
	Сотрудники.ЗагрузитьЗначения(Результат);
	
	УсловноеОформление.Элементы.Очистить();
	ЭлементОформления = УсловноеОформление.Элементы.Добавить();
	
	ЭлементОтбора = ЭлементОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Объект.ОтпускаСотрудников.Сотрудник");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
	ЭлементОтбора.ПравоеЗначение = Сотрудники;
	ЭлементОтбора.Использование = Истина;
	
	ЭлементОформления.Оформление.УстановитьЗначениеПараметра("ЦветФона", WEBЦвета.АкварельноСиний);
	
	ПолеОформления = ЭлементОформления.Поля.Элементы.Добавить();
	ПолеОформления.Поле = Новый ПолеКомпоновкиДанных("ОтпускаСотрудников");
	ПолеОформления.Использование = Истина;
	
	
КонецПроцедуры


&НаСервере
Функция ПоместитьВоВременноеХранТабЧастьГрафика ()
	
	Возврат ПоместитьВоВременноеХранилище(Объект.ОтпускаСотрудников.Выгрузить(), УникальныйИдентификатор);
	
КонецФункции
#КонецОбласти





