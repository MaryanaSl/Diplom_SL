﻿#language: ru

@tree
@exportscenarios
@ТипШага: Нетология.СвоиШаги.Работа со документом Обслуживание
@Описание: Сценарий провеяет корректность создания нового документа Обслуживание и проверяет его наличие в форме списка
@ПримерИспользования: И я проверяю корректность создания нового документа Обслуживание для организации "НаименованиеОрганизации" и контрагента "НаименованиеКонтрагента" и договора "НаименованиеДоговора" и специалиста "Работник"



Функционал: проверка корректности создания документа "Обслуживание"

Как тестировщик я хочу
автоматизировать процесс проверки создания нового документа 
обслуживание на специалистов от имени Менеджера с заполнением всех реквизитов
чтобы сократить время на ручное тестирование  


Сценарий: я проверяю корректность создания нового документа Обслуживание для организации "НаименованиеОрганизации" и контрагента "НаименованиеКонтрагента" и договора "НаименованиеДоговора" и специалиста "Работник"
*Я открываю форму списка “Обслуживание клиентов”
	И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживание клиентов'
	Тогда открылось окно 'Обслуживание клиентов'
*Я нажимаю кнопку “Создать”
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно 'Обслуживание клиента (создание)'

*В поле “Организация” выбираю организацию, для которой создается документ
	И я нажимаю кнопку выбора у поля с именем "Организация"
	Тогда открылось окно 'Организации'
*Проверяю есть ли в списке организаций ОАО "Айти". Если нет, то создаем организацию
	Если таблица  "Список" не содержит строки: Тогда
		| 'Наименование'           		|
		| '[НаименованиеОрганизации]' 	|
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Организация (создание)'
		И в поле с именем 'Наименование' я ввожу текст '[НаименованиеОрганизации]'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна 'Организация (создание)' в течение 20 секунд
		Тогда открылось окно 'Организации'
	И в таблице "Список" я перехожу к строке
		| 'Наименование'          	 	|
		| '[НаименованиеОрганизации]'	|
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Обслуживание клиента (создание) *'

*В поле “Контрагент” выбираю контрагента
	И я нажимаю кнопку выбора у поля с именем "Клиент"
	Тогда открылось окно 'Контрагенты'
	И в таблице "Список" я перехожу к строке:
		| 'Наименование'           		|
		| 'Абонентское обслуживание' 	|
	И в таблице "Список" я выбираю текущую строку
*Проверяю есть ли в списке контрагентов ОАО "Беда". Если нет, то создаем контрагента
	Если таблица  "Список" не содержит строки: Тогда
		| 'Наименование'				|
		| '[НаименованиеКонтрагента]' 	|
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Контрагент (создание)'
		И в поле с именем 'Наименование' я ввожу текст '[НаименованиеКонтрагента]'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна 'Контрагент (создание) *' в течение 20 секунд
		Тогда открылось окно 'Контрагенты'
	И в таблице "Список" я перехожу к строке
		| 'Наименование'				|
		| '[НаименованиеКонтрагента]'  	|
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Обслуживание клиента (создание) *'

*В поле “Договор” выбираю договор
	И я нажимаю кнопку выбора у поля с именем "Договор"
	Тогда открылось окно 'Договоры контрагентов'
*Проверяю есть ли в списке договоров Обслуживание сетей связи №1. Если нет, то создаем договор	
	Если таблица  "Список" не содержит строки: Тогда
		| 'Наименование'			|
		| '[НаименованиеДоговора]' 	|
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно 'Договор контрагента (создание)'
		И в поле с именем 'Наименование' я ввожу текст '[НаименованиеДоговора]'
		И в поле с именем 'ВКМ_ДатаНачала' я ввожу текст '01.01.2025'
		И в поле с именем 'ВКМ_ДатаОкончания' я ввожу текст '31.01.2025'
		И в поле с именем 'ВКМ_СуммаАбонентскойПлаты' я ввожу текст '15 000'
		И в поле с именем 'ВКМ_СтоимостьЧасаРаботы' я ввожу текст '2 000'
		И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
		И я жду закрытия окна 'Договор контрагента (создание) *' в течение 20 секунд
		Тогда открылось окно 'Договоры контрагентов'
	И в таблице "Список" я перехожу к строке
		| 'Наименование'     		|
		| '[НаименованиеДоговора]' 	|
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Обслуживание клиента (создание) *'
	
*В поле специалист заполняю специалиста
	И я нажимаю кнопку выбора у поля с именем "Специалист"
	* Проверка на наличие специалиста
			И Я проверяю и при необходимости создаю элемент справочника ФизическиеЛица с параметрами <Работник>
			
*Заполняю текстовые поля описание проблемы, комментарий, даты проведения работ	
	И в поле с именем 'ОписаниеПроблемы' я ввожу текст 'тест'
	И в поле с именем 'Комментарий' я ввожу текст 'тест'
	И я нажимаю кнопку выбора у поля с именем "ДатаПроведенияРабот"
	И в поле с именем 'ДатаПроведенияРабот' я ввожу текст '20.01.2025'
	И в поле с именем 'ВремяНачалаРаботПлан' я ввожу текст ' 8:00:00'
	И в поле с именем 'ВремяОкончанияРаботПлан' я ввожу текст '15:00:00'

*Проверяю правильность заполнения всех реквизитов документа И нажимаю кнопку “Провести и закрыть” для проведения и сохранения документа
	И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	И я жду закрытия окна 'Обслуживание клиента (создание) *' в течение 20 секунд
*Затем открываю список документов "Обслуживание" И вижу созданный мною новый документ
	И таблица "Список" содержит строки по шаблону:

		| 'Дата'                | 'Клиент'                    | 'Специалист' | 'Номер'     | 'Договор'                | 'Сумма по документу' |
		| '**.**.202* **:**:**' | '[НаименованиеКонтрагента]' | '[Работник]' | '00000****' | '[НаименованиеДоговора]' | ''                   |
	
		
		
	
