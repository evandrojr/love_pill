#!/usr/bin/env ruby
# encoding: UTF-8
require 'sqlite3'
require 'gmail'

username=ENV['gmailuser']
password=ENV['gmailpass']

`rm love_pill.sqlite*`
`wget http://evandro.org/pilula/love_pill.sqlite3`










pills=['Elogiar mais',
      'Jantar fora',
      'Café na cama',
      'Perdoar mais',
      'Beijar mais',
      'Dar comida na boca ou fazer o prato enfeitado',      
      'Banho juntos',
      'Fazer massagem',
      'Amor carinhoso',
      'Declaração de amor olhando nos olhos',      
      'Dançar agarradinho', 
      'Cantar juntos',                 
      'Cinema abraçados']

prng = Random.new
last_email = nil
begin
  #db = SQLite3::Database.new "love_pill.test.sqlite3"
  db = SQLite3::Database.new "love_pill.sqlite3"
  puts db.get_first_value 'SELECT SQLITE_VERSION()'
  stm = db.prepare "SELECT email from user"
  rs = stm.execute
  Gmail.new(username, password) do |gmail|
    rs.each do |row|
      last_email = row[0]
      email = gmail.generate_message do
        from "evandrojr@gmail.com"
        to row[0]
        subject "Pílula do amor de Dengo e Modesta"
        body "Olá!
      
Aqui vai a sugestão de Dengo (Evandro) e Modesta (Paulinha) para dar uma aquecida na sua relação. Experimente fazer isto durante essa semana.

Sua pílula do amor é:

#{pills[prng.rand(0...pills.size)]}

Semana que vem tem mais!

Um abraço!
Evandro e Paulinha

Se quiser que seus amigos ou familiares também recebam a pílula do amor, acesse:
http://evandro.org/pilula
"
      end # email = gmail.generate_message do
      email.deliver!
    end # End rs.each do |row|
  end # Gmail.new(username, password) do |gmail| 
  rescue SQLite3::Exception => e
    puts "SQLite3 Exception occurred"
    puts e
  rescue Exception => e
    puts "Erro ao enviar email para #{last_email}"
    puts e
  ensure
    stm.close if stm
    db.close if db
end
