#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

 #Область ПрограммныйИнтерфейс
  
  //если документ реализация, то добавим кнопку заполнить ТЧ для договоров вида Абон плата
  Процедура ДополнитьФорму (Форма) Экспорт
	  
	  ИмяФормы = Форма.ИмяФормы;
	  
	  Если ИмяФормы = "Документ.РеализацияТоваровУслуг.Форма.ФормаДокумента" Тогда
		ДобавитьКнопкуЗаполнить (Форма);
	  КонецЕсли;
	  
  КонецПроцедуры 

  
#КонецОбласти  

# Область СлужебныеПроцедурыИФункции
  
  Процедура ДобавитьКнопкуЗаполнить (Форма)
	  
	  Команда = Форма.Команды.Добавить ("Заполнить");
	  Команда.Заголовок = "Заполнить ТЧ для договоров вида Абонентская плата";
	  Команда.Действие = "КомандаЗаполнить"; 
	  
	  КнопкаФормы = Форма.Элементы.Добавить ("КнопкаЗаполнить", Тип ("КнопкаФормы"), Форма.Элементы.ГруппаШапкаЛево);
	  КнопкаФормы.ИмяКоманды = "Заполнить";
	  КнопкаФормы.Вид = ВидКнопкиФормы.КнопкаКоманднойПанели;   
	  КнопкаФормы.Отображение = ОтображениеКнопки.Текст;
	  
  КонецПроцедуры
  
  #КонецОбласти
  #КонецЕсли