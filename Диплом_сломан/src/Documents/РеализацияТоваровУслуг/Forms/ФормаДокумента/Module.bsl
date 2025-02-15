
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// {{ Слукина М.Н.: В базе параметры выбора Договора определены как Покупатель. 
	//для отбора договоров типа Абонентское обслуживание определены новые параметры выбора договор 
	ВидыДоговоров = Новый Массив();
	ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание);
	ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровКонтрагентов.Покупатель);
	
	Выбор = Новый Массив ();
	Выбор.Добавить (Новый ПараметрВыбора ("Отбор.ВидДоговора", Новый ФиксированныйМассив(ВидыДоговоров)));
	Элементы.Договор.ПараметрыВыбора = Новый ФиксированныйМассив (Выбор);
	//}}

	// {{ Слукина М.Н.: При создании на сервере проверим вид договора и 
	//скроем ненужные поля в ТЧ и закулату товары, если договор вид абоненсткое обслуживание 

	ВидДоговора = ПолучитьВидДоговора(Объект.Договор);
	ОтображениеЭлементовФормыВЗависимостиОтВидаДоговора(ЭтотОбъект, ВидДоговора);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры
	
#КонецОбласти

// {{ Слукина М.Н.: Если в документе Реализации товаров и услуг выбран договор
// с видом абонентская плата, то необходимо реализовать возможность автозаполнения 
//такого документа суммой ежемесячной абонентской платы и суммой за выполненные 
//в течения месяца работы по данным документов Обслуживание клиентов. 

#Область ОбработчикиСобытийЭлементовШапкиФормы
	
// {{ Слукина М.Н.:  при изменении договора очищать табличную часть. 
//если вид договора Абонентское обслуживание, то скрыть страницу Товары, Цена в ТЧ и поле Основание
&НаКлиенте
Процедура ДоговорПриИзменении(Элемент)
	
	ВидДоговора = ПолучитьВидДоговора(Объект.Договор);
	
	ОтображениеЭлементовФормыВЗависимостиОтВидаДоговора(ЭтотОбъект, ВидДоговора);
	
	Объект.Товары.Очистить();
	Объект.Услуги.Очистить();
КонецПроцедуры

//}}
	
	//{{ Слукина М.Н. обработчик программно добавленной в общем модуле 
	//ВКМ_РаботаСФормами команды/кнопки Заполнить
&НаКлиенте
Процедура КомандаЗаполнить(Команда) 

	ВидДоговора = ПолучитьВидДоговора(Объект.Договор);
	Если ВидДоговора <> ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание") Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю("Вид договора не является абонентским обслуживанием");
	Иначе
		ЗаполнитьАбонентскаяПлата();
	КонецЕсли;

КонецПроцедуры
    // }}
	
	//{{ Слукина М.Н. Команда Заполнить должна проверять вид договора. Если это договор абонентского обслуживания, 
	//то вызывать процедуру ВыполнитьАвтозаполнение из модуля объекта документа

&НаСервере
Процедура ЗаполнитьАбонентскаяПлата()
		
	ДокументОбъект = РеквизитФормыВЗначение("Объект");	
	ДокументОбъект.ВыполнитьАвтозаполнение();
	ЗначениеВРеквизитФормы(ДокументОбъект, "Объект");
	РассчитатьСуммуДокумента(Объект);

КонецПроцедуры
    // }}
#КонецОбласти
// }}


#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента(Объект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	
	РассчитатьСуммуДокумента(Объект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
// {{ Слукина М.Н.: в зависимости от вида договора 
//происходит скрытие/отображение элементов на форме в зависимости от вида договора

&НаСервере
Функция ПолучитьВидДоговора(Договор) 
		
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ДоговорыКонтрагентов.ВидДоговора
		|ИЗ
		|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
		|ГДЕ
		|	ДоговорыКонтрагентов.Ссылка = &Договор";
	
	Запрос.УстановитьПараметр("Договор", Договор);
	
	ВыборкаДетальныеЗаписи = Запрос.Выполнить().Выбрать();
	Если ВыборкаДетальныеЗаписи.Следующий() Тогда
		ВидДоговора = ВыборкаДетальныеЗаписи.ВидДоговора;
	КонецЕсли;
	
	Возврат ВидДоговора;

КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ОтображениеЭлементовФормыВЗависимостиОтВидаДоговора(ЭтотОбъект, ВидДоговора)
	Если ВидДоговора = ПредопределенноеЗначение("Перечисление.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание") Тогда
		СкрытьЭлементыФормы(ЭтотОбъект);
	Иначе
		ОтобразитьЭлементыФормы(ЭтотОбъект);
	КонецЕсли;
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура СкрытьЭлементыФормы(ЭтотОбъект)
	
	Элементы = ЭтотОбъект.Элементы;
	Элементы.ГруппаТовары.Видимость = Ложь;
	Элементы.УслугиЦена.Видимость = Ложь;
	Элементы.Основание.Видимость = Ложь;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОтобразитьЭлементыФормы(ЭтотОбъект)
	
	Элементы = ЭтотОбъект.Элементы;
	Элементы.ГруппаТовары.Видимость = Истина;
	Элементы.УслугиЦена.Видимость = Истина;
	Элементы.Основание.Видимость = Истина;
	
КонецПроцедуры


&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество;
	
	РассчитатьСуммуДокумента(Объект);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура РассчитатьСуммуДокумента(Объект)
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры
//}}

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти

