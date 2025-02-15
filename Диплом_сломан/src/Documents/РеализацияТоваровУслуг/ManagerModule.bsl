
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	Если ПравоДоступа("Добавление", Метаданные.Документы.РеализацияТоваровУслуг) Тогда
		
        КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
        КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РеализацияТоваровУслуг.ПолноеИмя();
        КомандаСоздатьНаОсновании.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Метаданные.Документы.РеализацияТоваровУслуг);
        КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
		
	КонецЕсли;

	Возврат Неопределено;
	
КонецФункции

//{{ Слукина М.Н. добавление команды печати и акта об оказании услуг в документ

Процедура ПриОпределенииНастроекПечати(НастройкиОбъекта) Экспорт	
	НастройкиОбъекта.ПриДобавленииКомандПечати = Истина;
КонецПроцедуры

Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	// Акт об оказании услуг
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "Акт";
	КомандаПечати.Представление = НСтр("ru = 'Акт об оказании услуг'");
	КомандаПечати.Порядок = 5;
	
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	ПечатнаяФорма = УправлениеПечатью.СведенияОПечатнойФорме(КоллекцияПечатныхФорм, "Акт");
	Если ПечатнаяФорма <> Неопределено Тогда
	    ПечатнаяФорма.ТабличныйДокумент = ПечатьАкта(МассивОбъектов, ОбъектыПечати);
	    ПечатнаяФорма.СинонимМакета = НСтр("ru = 'Акт об оказании услуг'");
	    ПечатнаяФорма.ПолныйПутьКМакету = "Документ.РеализацияТоваровУслуг.ВКМ_ПФ_MXL_АктОбОказанныхУслугах";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПечатьАкта (МассивОбъектов, ОбъектыПечати)
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.КлючПараметровПечати = "ПараметрыПечати_Акт";
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.РеализацияТоваровУслуг.ВКМ_ПФ_MXL_АктОбОказанныхУслугах");
	
	ДанныеДокументов = ПолучитьДанныеДокументов(МассивОбъектов);
	
	ПервыйДокумент = Истина;
	
	Пока ДанныеДокументов.Следующий() Цикл
		
		Если Не ПервыйДокумент Тогда
			// Все документы нужно выводить на разных страницах.
			ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ПервыйДокумент = Ложь;
		
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
	
		ВывестиОбластьШапка(ДанныеДокументов, ТабличныйДокумент, Макет);
		
		ВывестиКонтрагентОрганизацияДоговор(ДанныеДокументов, ТабличныйДокумент, Макет);
		
		ВывестиТоварыУслуги(ДанныеДокументов, ТабличныйДокумент, Макет);
		
		ВывестиПодписи (ДанныеДокументов, ТабличныйДокумент, Макет);
	
		// В табличном документе необходимо задать имя области, в которую был 
		// выведен объект. Нужно для возможности печати комплектов документов.
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, 
		НомерСтрокиНачало, ОбъектыПечати, ДанныеДокументов.Ссылка);		
		
	КонецЦикла;	
	
	Возврат ТабличныйДокумент;
	
КонецФункции

Процедура ВывестиОбластьШапка(ДанныеДокументов, ТабличныйДокумент, Макет)
	ОбластьШапка = Макет.ПолучитьОбласть ("Шапка"); 
	ОбластьШапка.Параметры.ДатаДокумента = Формат (ДанныеДокументов.Дата, "ДФ=dd.MM.yyyy") + " г.";
	ОбластьШапка.Параметры.НомерДокумента = ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(ДанныеДокументов.Номер);
	ТабличныйДокумент.Вывести(ОбластьШапка);
КонецПроцедуры

Процедура ВывестиКонтрагентОрганизацияДоговор(ДанныеДокументов, ТабличныйДокумент, Макет)
	
	ОбластьКонтрагент = Макет.ПолучитьОбласть("Контрагент");
	ОбластьОрганизация = Макет.ПолучитьОбласть("Организация");
	ОбластьДоговор = Макет.ПолучитьОбласть("Договор");
	
	ДанныеПечати = Новый Структура;
	ДанныеПечати.Вставить("ПредставлениеКонтрагента", ДанныеДокументов.Контрагент);
	ДанныеПечати.Вставить("ПредставлениеОрганизации", ДанныеДокументов.Организация);
	ДанныеПечати.Вставить("Договор", ДанныеДокументов.Договор);
	
	ОбластьКонтрагент.Параметры.Заполнить(ДанныеПечати);
	ТабличныйДокумент.Вывести(ОбластьКонтрагент);
	
	ОбластьОрганизация.Параметры.Заполнить(ДанныеПечати);
	ТабличныйДокумент.Вывести(ОбластьОрганизация);
	
	ОбластьДоговор.Параметры.Заполнить(ДанныеПечати);
	ТабличныйДокумент.Вывести(ОбластьДоговор);
	
КонецПроцедуры

Процедура ВывестиТоварыУслуги(ДанныеДокументов, ТабличныйДокумент, Макет)
	
	ОбластьШапкаТЧ = Макет.ПолучитьОбласть("ШапкаТЧ");
	ОбластьСтрока = Макет.ПолучитьОбласть("СтрокаТЧ");
	ОбластьВсего = Макет.ПолучитьОбласть("Всего");
	ОбластьСуммаПрописью = Макет.ПолучитьОбласть("СуммаПрописью");
	
	ТабличныйДокумент.Вывести(ОбластьШапкаТЧ);
	
	ВыборкаТовары = ДанныеДокументов.Товары.Выбрать();
	Пока ВыборкаТовары.Следующий() Цикл
		ОбластьСтрока.Параметры.Заполнить(ВыборкаТовары);
		ТабличныйДокумент.Вывести(ОбластьСтрока);
	КонецЦикла;
	
	ВыборкаУслуги = ДанныеДокументов.Услуги.Выбрать();
	Пока ВыборкаУслуги.Следующий() Цикл
		ОбластьСтрока.Параметры.Заполнить(ВыборкаУслуги);
		ТабличныйДокумент.Вывести(ОбластьСтрока);
	КонецЦикла;
	
	ДанныеПечати = Новый Структура;
	ДанныеПечати.Вставить("Всего", ДанныеДокументов.СуммаДокумента);
	
	ОбластьВсего.Параметры.Заполнить(ДанныеПечати);
	ТабличныйДокумент.Вывести(ОбластьВсего);
	
	ДанныеСуммы = Новый Структура;
	ДанныеСуммы.Вставить ("СуммаПрописью", ЧислоПрописью(ДанныеДокументов.СуммаДокумента, "Л=ru_RU; ДП = Ложь", "рубль, рубля, рублей, м, копейка, копейки, копеек, ж, 2"));
	
	ОбластьСуммаПрописью.Параметры.Заполнить(ДанныеСуммы);
	ТабличныйДокумент.Вывести(ОбластьСуммаПрописью);
	
КонецПроцедуры

Процедура ВывестиПодписи(ДанныеДокументов, ТабличныйДокумент, Макет)
	
	ОбластьПодписи = Макет.ПолучитьОбласть("Подписи");
	ОбластьПодписи.Параметры.Контрагента = ДанныеДокументов.Контрагент;
	ОбластьПодписи.Параметры.Организации = ДанныеДокументов.Организация;

	ТабличныйДокумент.Вывести(ОбластьПодписи);
	
КонецПроцедуры

Функция ПолучитьДанныеДокументов(МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Ссылка,
	|	РеализацияТоваровУслуг.Номер,
	|	РеализацияТоваровУслуг.Дата,
	|	РеализацияТоваровУслуг.Организация,
	|	РеализацияТоваровУслуг.Контрагент,
	|	РеализацияТоваровУслуг.Договор,
	|	РеализацияТоваровУслуг.СуммаДокумента,
	|	РеализацияТоваровУслуг.Ответственный,
	|	РеализацияТоваровУслуг.Товары.(
	|		Ссылка,
	|		НомерСтроки,
	|		Номенклатура,
	|		Количество,
	|		Цена,
	|		Сумма),
	|	РеализацияТоваровУслуг.Услуги.(
	|		Ссылка,
	|		НомерСтроки,
	|		Номенклатура,
	|		Количество,
	|		Цена,
	|		Сумма)
	|ИЗ
	|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|ГДЕ
	|	РеализацияТоваровУслуг.Ссылка В (&МассивОбъектов)";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции

#КонецОбласти
//}}
#КонецЕсли