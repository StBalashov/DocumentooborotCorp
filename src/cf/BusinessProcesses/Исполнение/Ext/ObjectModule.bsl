﻿
Процедура ЗадачаВыполненаУспешноПроверкаУсловия(ТочкаМаршрутаБизнесПроцесса, Результат)
	Результат = ПроверкаПройдена;
КонецПроцедуры

Процедура ПроверкаПриВыполнении(ТочкаМаршрутаБизнесПроцесса, Задача, Отказ)
	Комментарий = Задача.Комментарий;
КонецПроцедуры

Процедура ПроверкаПриСозданииЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, Отказ)
	ФормируемыеЗадачи[0].Запрос = Комментарий;
КонецПроцедуры




