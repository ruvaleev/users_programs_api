# frozen_string_literal: true

[
  ['Aviasales / Jetradar', 'Поиск дешевых авиабилетов'],
  ['Hotellook', 'Бронирование отелей со скидками до 60%. Забронируйте номер по выгодной цене!'],
  ['Discover Cars', 'Аренда автомобилей по всему миру'],
  ['Hostelworld', 'Хостелы по всему миру'],
  ['Trainline', 'Поиск, сравнение и покупка билетов на автобусы и поезда по Европе'],
  ['Kiwi.com', 'Дешёвые билеты на самолёты']
].each { |title, description| Program.create(title: title, description: description) }
