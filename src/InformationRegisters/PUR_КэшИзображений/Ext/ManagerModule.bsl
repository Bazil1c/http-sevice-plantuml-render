﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

Процедура Записать(Текст, ДвоичныеДанные) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ХэшСумма = ХешСумма(Текст);
	МенеджерЗаписи.Картинка = Новый ХранилищеЗначения(ДвоичныеДанные);
	МенеджерЗаписи.Записать();

КонецПроцедуры

Функция Прочитать(Текст) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ХэшСумма = ХешСумма(Текст);
	
	НаборЗаписей = СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ХэшСумма.Установить(ХэшСумма);
	НаборЗаписей.Прочитать();
	
	ДвоичныеДанные = Неопределено;
	Если НаборЗаписей.Количество() > 0 Тогда
		ДвоичныеДанные = НаборЗаписей[0].Картинка.Получить();
	КонецЕсли;
	
	Возврат ДвоичныеДанные;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Реализует инкрементальный расчет хеш-суммы по произвольным данным.
//
// Параметры:
//  Текст  - Строка - Произвольный текст.
//
// Возвращаемое значение:
//   Строка   - Строковое представление хэш-суммы.
//
Функция ХешСумма(Текст) Экспорт
	
	ХешированиеДанных = Новый ХешированиеДанных(ХешФункция.MD5);
		
	Если ЗначениеЗаполнено(Текст) Тогда
		СтрокаXML = ОбщегоНазначения.ЗначениеВСтрокуXML(Текст);
		ХешированиеДанных.Добавить(СтрокаXML);
	Иначе
		
		ВызватьИсключение "Некорректный тип данных";
		
	КонецЕсли; 
	
	Возврат СтрЗаменить(ХешированиеДанных.ХешСумма, " ", ""); 
	
КонецФункции

#КонецОбласти

#КонецЕсли