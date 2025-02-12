﻿#language: ru

@tree
@ExportScenarios
@ТипШага: Нетология.СвоиШаги.ФизЛица
@Описание: Добавляет элемент справочника Физические лица
@ПримерИспользования: Я проверяю и при необходимости создаю элемент справочника ФизическиеЛица с параметрами "Работник"
Функционал: Проверка функциональности создания нового документа обслуживание клиента

Как Тестировщик-автоматизатор я хочу
Автоматизировать процесс проверки создания нового документа Обслуживание клиента 
чтобы сократить время на ручное тестирование   


Сценарий: Я проверяю и при необходимости создаю элемент справочника ФизическиеЛица с параметрами "Работник"
		*Проверка на наличие данного физ лица
			Тогда открылось окно 'Физические лица'
			Если таблица  "Список" не содержит строки: Тогда
            	| 'Наименование' |
            	| '[Работник]'   |
	         	Тогда я нажимаю на кнопку с именем 'ФормаСоздать'
            	Когда открылось окно 'Физическое лицо (создание)'
            	И в поле с именем 'Наименование' я ввожу текст '[Работник]'
            	И я перехожу к следующему реквизиту
            	И я нажимаю кнопку выбора у поля с именем "Подразделение"
            	Тогда открылось окно 'Подразделения'
				И в таблице "Список" я перехожу к строке:
					| 'Наименование' | 'Код'       |
					| 'Специалисты'  | '000000001' |
				И в таблице "Список" я выбираю текущую строку
				Тогда открылось окно 'Физическое лицо (создание) *'
            	И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
            	И я жду закрытия окна 'Физические лица (создание) *' в течение 20 секунд
            	Тогда открылось окно 'Физические лица'
				И в таблице "Список" я перехожу к строке
					| 'Наименование' |
					| '[Работник]'   |
				И в таблице "Список" я выбираю текущую строку
				Тогда открылось окно 'Обслуживание клиента (создание) *'
				*проверим условия оплаты для специалиста
				И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Условия оплаты сотрудников'
				Тогда открылось окно 'Условия оплаты сотрудников'
				Если таблица  "Список" не содержит строки: Тогда
            		| 'Сотрудник'  |
            		| '[Работник]' |
				Когда открылось окно 'Условия оплаты сотрудников'
				И я нажимаю на кнопку с именем 'ФормаСоздать'
				Тогда открылось окно 'Условия оплаты сотрудников (создание)'
				И в поле с именем 'Период' я ввожу текст '01.10.2024'
				И я нажимаю кнопку выбора у поля с именем "Сотрудник"
				Тогда открылось окно 'Физические лица'
						И в таблице "Список" я перехожу к строке:
            				| 'Наименование' |
            				| '[Работник]'   |
						И я нажимаю на кнопку с именем 'ФормаВыбрать'
				Тогда открылось окно 'Условия оплаты сотрудников (создание) *'
				И из выпадающего списка с именем "Подразделение" я выбираю точное значение 'Специалисты'
				И в поле с именем 'Оклад' я ввожу текст '20 000,00'
				И в поле с именем 'ПроцентОтРабот' я ввожу текст '50 '
				И я нажимаю на кнопку с именем 'ФормаЗаписатьИЗакрыть'
				И я жду закрытия окна 'Условия оплаты сотрудников (создание) *' в течение 20 секунд
				Когда открылось окно 'Условия оплаты сотрудников'
				И Я закрываю окно 'Условия оплаты сотрудников'
			И в таблице "Список" я перехожу к строке
            | 'Наименование' |
            | '[Работник]' |
            И я нажимаю на кнопку с именем "ФормаВыбрать"				
				

						