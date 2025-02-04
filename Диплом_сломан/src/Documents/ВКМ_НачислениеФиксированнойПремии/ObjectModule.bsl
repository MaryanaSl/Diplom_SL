#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	СформироватьДвижения();

	СформироватьУдержания();

	ВКМ_РасчетныйМодуль.РассчитатьНДФЛ (Ссылка);
	
	ВКМ_РасчетныйМодуль.СформироватьДвиженияВзаиморасчетыССотрудниками(Ссылка);

КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СформироватьДвижения()
	
	Для каждого Строка из СписокСотрудников Цикл  
		
		//переносим данные по доп.начислениям из ТЧ в регистр
		Движение = Движения.ВКМ_ДополнительныеНачисления.Добавить();
		Движение.ПериодРегистрации = Дата;
		Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_ДополнительныеНачисления.ПремияСуммой;
		Движение.Сотрудник = Строка.Сотрудник;
		Движение.Подразделение = Строка.Подразделение; 
		Движение.Результат = Строка.СуммаПремия;
		
	КонецЦикла; 
	Движения.ВКМ_ДополнительныеНачисления.Записать();
	
КонецПроцедуры  

Процедура СформироватьУдержания()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ВКМ_НачислениеФиксированнойПремииСписокСотрудников.Подразделение,
	|	ВКМ_НачислениеФиксированнойПремииСписокСотрудников.Сотрудник,
	|	ЕСТЬNULL(СУММА(ВКМ_НачислениеФиксированнойПремииСписокСотрудников.СуммаПремия), 0) КАК СуммаПремия
	|ИЗ
	|	Документ.ВКМ_НачислениеФиксированнойПремии.СписокСотрудников КАК ВКМ_НачислениеФиксированнойПремииСписокСотрудников
	|ГДЕ
	|	ВКМ_НачислениеФиксированнойПремииСписокСотрудников.Ссылка = &Ссылка
	|СГРУППИРОВАТЬ ПО
	|	ВКМ_НачислениеФиксированнойПремииСписокСотрудников.Подразделение,
	|	ВКМ_НачислениеФиксированнойПремииСписокСотрудников.Сотрудник";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
			Движение = Движения.ВКМ_Удержания.Добавить();
			Движение.ПериодРегистрации = Дата;
			Движение.БазовыйПериодНачало = НачалоМесяца(Дата);
			Движение.БазовыйПериодКонец = КонецМесяца(Дата);
			Движение.ВидРасчета = ПланыВидовРасчета.ВКМ_Удержания.НДФЛ;
			Движение.Подразделение = ВыборкаДетальныеЗаписи.Подразделение;
			Движение.Сотрудник = ВыборкаДетальныеЗаписи.Сотрудник;

	КонецЦикла;

	Движения.ВКМ_Удержания.Записать();
	
КонецПроцедуры 
#КонецОбласти
 

#КонецЕсли


