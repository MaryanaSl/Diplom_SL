Инструкция по начальной настройке

Все нижеперечисленные справочники, регистры и документы доступны в подсистеме «Добавленные объекты»

Шаг 1
Заполните следующие константы: 
- «Абонентская плата» - заполняется из справочника «Номенклатура» соответствующим по смыслу наименованием, при необходимости создайте нужную номенклатуру. 
- «Работы специалиста» - заполняется из справочника «Номенклатура» соответствующим по смыслу наименованием, при необходимости создайте нужную номенклатуру.

Шаг 2
В «Пользователях» создайте для каждого сотрудника пользователя. На вкладке права доступа назначьте каждому пользователю соответствующий должности профиль группы доступа. Наименования профиля группы доступа созданы интуитивно понятными. Например, для бухгалтеров профиль группы доступа – «ВКМ Бухгалтер», для кадровика – «ВКМ Кадровик-расчетчик». Все созданные профили групп доступа являются поставляемыми и не могут быть изменены пользователем самостоятельно. Подробнее с составом ролей профилей групп доступа вы можете ознакомиться по следующему пути: «Администрирование» - «Настройки пользователей и прав» - «Профили групп доступа» - - папка «ВКМ».

Шаг 3
Создание бота
Напишете в Телеграм https://t.me/BotFather команду "/start"
Напишите команду "/newbot"
Выберите имя вашего бота, которое будут видеть пользователи
Выберите идентификатор вашего бота (он должен заканчиваться на "bot")
Скопируйте токен, который пришлет BotFather и сохраните его в константу «Токен управления ТГБотом».

Шаг 4
Создание группы
Создайте группу в Телеграм
Добавьте в группу только что созданного бота
Назначьте боту права администратора
Получите идентификатор группы
Напишите любое сообщение в группу
С помощью браузера или Postman выполните запрос https://api.telegram.org/bot[ВашТокен]/getUpdates. В полученном JSON найдите идентификатор группы, в которой получено сообщение, и сохраните его в константу «Идентификатор группы для оповещения»

Шаг 5
Созданные группа и бот в Телеграмм нужны для отправки уведомлений специалистам о созданных документах «Обслуживание клиента». Уведомления создаются при создании нового документа, а также при изменении даты, времени и ФИО специалиста. Для заполнения документа «Обслуживание клиента» специалисту необходимо внести информацию о выполненных работах, количество потраченных часов на каждый вид работы, количество часов к оплате клиенту и прикрепить к документу скан/фото листа учета рабочего времени. 
При проведении документа проводится запись в регистр ВыполненныеКлиентуРаботы о суммах задолженности клиента, а также запись в регистр накопления ВыполненныеСотрудникомРаботы о суммах и часах к оплате сотруднику. 
Предупредите менеджера, что необходимо выбирать договор с типом абонентская плата и что дата документа должна быть между датой начала и датой окончания действия договора, иначе документ не проведется. Если на дату документа специалисту не установлен процент оплаты от работ (см. шаг 6), то документ не проводится. Если установлен нулевой процент, в этом случае документ проводится.

Шаг 6
Оповестите бухгалтера, что если в документе «Реализации товаров и услуг» выбран договор с видом «абонентская плата», то реализована возможность автозаполнения табличной части документа суммой ежемесячной абонентской платы (из условий договора) и суммой за выполненные в течения месяца работы по данным документов «Обслуживание клиентов». Из документа есть возможность напечатать акт об оказанных услугах.

Шаг 7
Заполните регистр сведений «Условия оплаты сотрудников», укажите процент от продаж у Специалистов и оклады у всех сотрудников.

Шаг 8
В справочник «Графики работы» заведите необходимый вид графика работы, например, пятидневка. Затем выберете обработку «Заполнение графика». В поле «Выбор периода» выберете период (год) для заполнения графика. В поле «Выходные дни» через запятую перечислите порядковый номер выходного дня недели. Например, для субботы и воскресенья необходимо в поле написать «6, 7». Нажмите кнопку «Заполнить». Далее в регистре «График работы» проверьте корректность заполнения графика. 

Шаг 9
Расчёт зарплаты выполняется документом НачислениеЗарплаты по всем видам расчёта, кроме премий. Премии начисляются отдельным документом НачислениеФиксированныхПремий. В документах НачислениеЗарплаты и НачислениеФиксированныхПремий автоматически рассчитано удержание НДФЛ (регистр Удержания). При проведении этих документ информация записывается в регистр ВзаиморасчетыССотрудниками.

Шаг 10
Выплата зарплаты заводится документом «Выплата зарплаты». При нажатии на кнопку «Заполнить» табличная часть заполняется автоматически задолженностью перед сотрудниками на дату документа. При проведении документа происходит запись в регистр ВзаиморасчетыССотрудниками. 

Шаг 11
Для кадровиков доступен документ График отпусков. В документе реализован визуальный контроль, что все сотрудники не пойдут в отпуск одновременно, а также подсветка строк сотрудников, чей отпуск превышает 28 кал. дней. 

Шаг 12
Для специалистов и кадровиков-расчетчиков реализован отчет по выработке специалистов, который показывает, сколько часов за выбранный период отработал выбранный специалист и какая сумма ему за этот период начислена в виде процента от выплат клиента.
Для бухгалтеров доступен отчет по анализу выставленных актов, включающий информацию о клиентах, договорах и суммах, которые должны быть выставлены клиентам на основе данных из документов Обслуживание. Также показывается фактическая сумма по номенклатуре из константы НоменклатураРаботыСпециалиста, которая была выставлена в текущем месяце.
Для кадровиков-расчетчиков доступен отчет «Расчеты с сотрудниками», в котором представлена информация о том, какие суммы начислены и выплачены каждому сотруднику за указанный период. Также в отчете указана задолженность на начало и на конец этого периода.
Также для кадровиков-расчетчиков доступен отчет «Расход запланированных отпусков» (за год), который показывает сколько дней отпуска у сотрудника в выбранный период по плану и сколько дней он фактически был в отпуске.

Шаг 13
Проинструктируйте кадровика о необходимости создать сотрудников в справочнике «Физические лица» и назначить каждому подразделение. 
Проинструктируйте бухгалтера о возможности автоматического формирования документов по реализации за месяц с помощью обработки «Массовое создание актов». Период в обработке должен быть выбран предыдущий месяц. 
Проинструктируйте менеджера о возможности создания договоров вида «Абонентское обслуживание». Для них реализовано заполнение дополнительных полей: «дата начала» и «дата окончания» договора, «стоимость часа работы», «Сумма абонентской платы». Эти поля должны быть заполнены для корректного формирования документов реализации.
Также проинформируйте пользователя, что, если не заполнены константы «Работы специалиста» и «Абонентская плата», документ заполнен не будет.

Шаг14
Тестирование
Для тестирования процесса обслуживания клиента и отработки работы специалиста необходимы файлы:
- «Общий_сценарий Менеджер.feature» – запускает экспортный сценарий под ролью Менеджер по созданию документа Обслуживание с заданными параметрами (Организация, Клиент, Договор, Специалист) из файла «я_проверяю_корректность_создания_нового_документа_Обслуживание.feature». Там запускается экспортный сценарий из файла «я_проверяю_и_создаю ФизЛицо.feature».
- «Общий_сценарий_Специалист.feature» - запускает экспортный сценарий под ролью Специалист по закрытию созданного ранее документа Обслуживание из файла «я_проверяю_корректность_закрытия_документа_Обслуживание.feature»
- «Общий_сценарий_Бухгалтер.feature» - запускает экспортный сценарий под ролью Бухгалтер по формированию актов (реализаций) через обработку «массовое создание актов» за январь 2025 г., из файла «я_проверяю_корректность_создания реализаций_массовое создание актов.feature». Также запускается экспортный сценарий по формированию отчета «Анализ выставленных актов» с заданным периодом и отбором по параметру Клиент, из файла «я_проверяю_корректность_создания реализаций_через отчет анализ выставленных актов.feature».
Данные файлы находятся в папке Тестирование

