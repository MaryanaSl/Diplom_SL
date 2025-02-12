#Область СлужебныеПроцедурыИФункции

Процедура РассчитатьНДФЛ(Регистратор) Экспорт
    
    НаборЗаписей = РегистрыРасчета.ВКМ_Удержания.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);
	НаборЗаписей.Прочитать();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
			"ВЫБРАТЬ
			|	ЕСТЬNULL(ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.РезультатБаза, 0) КАК РезультатБаза,
			|	ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.НомерСтроки
			|ПОМЕСТИТЬ ВТ_База
			|ИЗ
			|	РегистрРасчета.ВКМ_Удержания.БазаВКМ_ОсновныеНачисления(&Измерения, &Измерения, &Разрез, Регистратор = &Ссылка
			|	И ВидРасчета = &НДФЛ) КАК ВКМ_УдержанияБазаВКМ_ОсновныеНачисления
			|ГДЕ
			|	ВКМ_УдержанияБазаВКМ_ОсновныеНачисления.РегистраторРазрез = &Ссылка
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|ВЫБРАТЬ
			|	ЕСТЬNULL(ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.РезультатБаза, 0) КАК РезультатБаза,
			|	ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.НомерСтроки
			|ИЗ
			|	РегистрРасчета.ВКМ_Удержания.БазаВКМ_ДополнительныеНачисления(&Измерения, &Измерения, &Разрез, Регистратор = &Ссылка
			|	И ВидРасчета = &НДФЛ) КАК ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления
			|ГДЕ
			|	ВКМ_УдержанияБазаВКМ_ДополнительныеНачисления.РегистраторРазрез = &Ссылка
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	СУММА(ВТ_База.РезультатБаза) КАК РезультатБаза,
			|	ВТ_База.НомерСтроки
			|ИЗ
			|	ВТ_База КАК ВТ_База
			|СГРУППИРОВАТЬ ПО
			|	ВТ_База.НомерСтроки";
	

	Запрос.УстановитьПараметр("Ссылка", Регистратор);
	Запрос.УстановитьПараметр("НДФЛ", ПланыВидовРасчета.ВКМ_Удержания.НДФЛ);
	
	Разрез = Новый Массив;
	Разрез.Добавить("Регистратор");	
	
	Запрос.УстановитьПараметр("Разрез", Разрез);

	
	Измерения = Новый Массив;
	Измерения.Добавить("Подразделение");	
	Измерения.Добавить("Сотрудник");

	Запрос.УстановитьПараметр("Измерения", Измерения);

	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Для Каждого Строка из НаборЗаписей Цикл
		Если ВыборкаДетальныеЗаписи.НайтиСледующий(Строка.НомерСтроки, "НомерСтроки") Тогда
			Строка.Размер = ВыборкаДетальныеЗаписи.РезультатБаза;
			Строка.Результат = Строка.Размер *13 / 100;
		КонецЕсли;
		
	КонецЦикла;
	
	НаборЗаписей.Записать(, Истина);
	
КонецПроцедуры

Процедура СформироватьДвиженияВзаиморасчетыССотрудниками (Ссылка) Экспорт
	
	НаборЗаписей = РегистрыНакопления.ВКМ_ВзаиморасчетыССотрудниками.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Ссылка);
	НаборЗаписей.Записать();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|
		|	ВКМ_Удержания.Подразделение,
		|	ВКМ_Удержания.Сотрудник,
		|	СУММА(ВКМ_Удержания.Размер) КАК Начисления,
		|	СУММА(ВКМ_Удержания.Результат) КАК Удержания
		|ИЗ
		|	РегистрРасчета.ВКМ_Удержания КАК ВКМ_Удержания
		|ГДЕ
		|	ВКМ_Удержания.Регистратор = &Ссылка
		|СГРУППИРОВАТЬ ПО
		|	ВКМ_Удержания.Подразделение,
		|	ВКМ_Удержания.Сотрудник";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Движение = НаборЗаписей.Добавить();
		Движение.Период = Ссылка.Дата;
		Движение.Сумма = ВыборкаДетальныеЗаписи.Начисления - ВыборкаДетальныеЗаписи.Удержания;
		ЗаполнитьЗначенияСвойств(Движение, ВыборкаДетальныеЗаписи);
	КонецЦикла;
	
	НаборЗаписей.Записать();
	
КонецПроцедуры
#КонецОбласти  