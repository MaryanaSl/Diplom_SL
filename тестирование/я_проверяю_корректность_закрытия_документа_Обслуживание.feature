﻿#language: ru

@tree
@exportscenarios
@ТипШага: Нетология.СвоиШаги.Закрытие документа Обслуживание
@Описание: Сценарий провеяет корректность корректность закрытия Обслуживаний от имени Специалиста
@ПримерИспользования: И я проверяю корректность закрытия документа Обслуживание для организации "НаименованиеОрганизации" и контрагента "НаименованиеКонтрагента" и договора "НаименованиеДоговора" и специалиста "Работник"



Функционал: проверка корректности закрытия документа "Обслуживание"

Как тестировщик я хочу
автоматизировать процесс проверки закрытия документа 
обслуживание на специалистов от имени Специалиста с заполнением всех реквизитов
чтобы сократить время на ручное тестирование  


Сценарий: я проверяю корректность закрытия документа Обслуживание для организации "НаименованиеОрганизации" и контрагента "НаименованиеКонтрагента" и договора "НаименованиеДоговора" и специалиста "Работник"
*Я открываю форму списка “Обслуживание клиентов”
	И В командном интерфейсе я выбираю 'Обслуживание клиентов' 'Обслуживание клиентов'
	Тогда открылось окно 'Обслуживание клиентов'
*Я в списке нахожу обслуживание с Клиентом ОАО Беда Договором Обслуживание сетей связи №1
	И в таблице "Список" я перехожу к строке:
		| 'Дата'                | 'Клиент'                    | 'Специалист'   | 'Номер'     | 'Договор'                | 'Сумма по документу' |
		| '**.**.202* **:**:**' | '[НаименованиеКонтрагента]' | '[Работник]' | '00000****' | '[НаименованиеДоговора]' | ''                   |

	И в таблице "Список" я выбираю текущую строку
*я Открываю нужный документ Обслуживание
	Тогда открылось окно 'Обслуживание клиента * от *'
*я заполняю табличную часть Выполненные работы наименование работ, количеством часов, указываю часы к оплате, сумма считается автоматически
	И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
	И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Исправил работу'
	И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '5,00'
	И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '5,00'
	И в таблице "ВыполненныеРаботы" я завершаю редактирование строки
	И в таблице "ВыполненныеРаботы" я нажимаю на кнопку с именем 'ВыполненныеРаботыДобавить'
	И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыОписаниеРабот' я ввожу текст 'Настроил систему'
	И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыФактическиПотраченоЧасов' я ввожу текст '10,00'
	И в таблице "ВыполненныеРаботы" в поле с именем 'ВыполненныеРаботыЧасыКОплатеКлиенту' я ввожу текст '10,00'
	И в таблице "ВыполненныеРаботы" я завершаю редактирование строки

И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
И я жду закрытия окна 'Обслуживание клиента * от * *' в течение 20 секунд



