# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  ['Aviasales / Jetradar', 'Поиск дешевых авиабилетов'],
  ['Hotellook', 'Бронирование отелей со скидками до 60%. Забронируйте номер по выгодной цене!'],
  ['Discover Cars', 'Аренда автомобилей по всему миру'],
  ['Hostelworld', 'Хостелы по всему миру'],
  ['Trainline', 'Поиск, сравнение и покупка билетов на автобусы и поезда по Европе'],
  ['Kiwi.com', 'Дешёвые билеты на самолёты']
].each { |title, description| Program.create(title: title, description: description) }
