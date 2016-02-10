#!/usr/bin/env ruby
# encoding: UTF-8
require 'sqlite3'
require 'gmail'

username=ENV['gmailuser']
password=ENV['gmailpass']

`rm love_pill.sqlite*`
`wget http://evandro.org/pilula/love_pill.sqlite3`










pills=['Elogiar com sinceridade e carinho',
      'Jantar fora fazendo um clima romântico',
      'Café na cama caprichado',
      'Perdoar mais e não ficar relembrando os erros do outro',
      'Beijar como nos primórdios do namoro, se depois embalar melhor ainda!',
      'Lavar pratos, varrer, lavar banheiros (ou outro serviço doméstico) junto com seu amor. Se colocar uma música para graxerarem juntos melhor ainda!',
      'Fazer regime juntos, mas também não deve afundar o pé na jaca quando estiver sozinho, kkk',
      'Praticar esportes juntos de preferencia ao ar livre, mas de todo tipo está valendo!',
      'Dar comida na boca ou fazer o prato enfeitado',
      'Banho juntos lavando a cabeça do amor, o pezinho do amor, o umbiguinho do amor, etc...',
      'Fazer massagem nas costas, nos pés e onde mais o outro gostar',
      'Amor carinhoso com bastantes preliminares',
      'Declaração de amor verdadeira e olhando nos olhos',
      'Dançar agarradinho de preferencia músicas românticas',
      'Cantar juntos de preferencia músicas românticas',
      'Cinema abraçados vendo um drama romântico ou comédia romântica']

prng = Random.new
last_email = nil
begin
#  db = SQLite3::Database.new "love_pill.test.sqlite3"
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
        subject "Pílula do amor de Dengo e Modesta - Casamento lugar de milagre"
        body "Olá!

Aqui vai a sugestão de Dengo (Evandro) e Modesta (Paulinha) para dar uma aquecida na sua relação. Experimente fazer isto durante esta semana.

Sua pílula do amor é:

--------------------------------------------------------------------------------

#{pills[prng.rand(0...pills.size)]}

--------------------------------------------------------------------------------

Semana que vem tem mais!

Seu parceiro ainda não está recebendo as pílulas por email? Sinto muito, você está deixando de receber vários benefícios para você e para sua relação.

Se quiser que seu parceiro, amigos ou familiares também recebam a pílula do amor, acesse:
http://evandro.org/pilula
para adicioná-lo(s).
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
