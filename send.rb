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
      'Orar e agradecer a Deus juntos como casal',
      'Cinema abraçados vendo um drama romântico ou comédia romântica']

prng = Random.new
last_email = nil
begin
  # db = SQLite3::Database.new "love_pill.test.sqlite3"
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
        subject "Pílula do amor D&M - Série: O Desafio de Amar"
        body "Queridos casais,

A partir dessa semana convidamos vocês a embarcarem em uma jornada inesquecível de descoberta sobre o verdadeiro Amor.  Baseado no livro “O Desafio de Amar” de Stephen e Alex Kendrick, citado no filme “Prova de Fogo”, enviaremos juntamente com as “Pílulas do Amor”  um “Devocional Semanal”   para maridos e esposas que desejam ardentemente, assim como nós, entender e viver o amor incondicional em seu casamento.
Casais tripulantes do Amor, desafiem-se a aceitar o desafio de amar e veja o seu casamento ser transformado para sempre!!!!

1° SEMANA

O Amor é paciente

Sejam completamente humildes e dóceis, e sejam pacientes, suportando uns aos outros com amor. - Efésios 4:2

Contradizendo o que muitos pensam, essa jornada nos remete a entender o amor não apenas como um sentimento, mas como uma AÇÃO.  Amar é um verbo de ação, desafiar-se a amar requer decisão. Basear nosso comportamento a partir da decisão de amar não é fácil, é realmente um desafio, mas a melhor  recompensa será  ter o verdadeiro AMOR fluindo em nossas vidas , em nosso casamento e  em toda nossa família.

O amor é construído sobre dois pilares que melhor definem o que ele é. Esses pilares são a paciência e a bondade . Todas as outras características do amor são extensões desses dois atributos. E é aqui que começa o seu desafio, com a paciência.
Quando você decide ser paciente, você responde de maneira positiva à uma situação negativa. Você é tardio em irar-se. Prefere ter um “pavio longo” a se irritar facilmente. Ao invés de ser impaciente e exigente, o amor lhe ajuda a se acalmar e a transmitir misericórdia aos que estão ao seu redor. A paciência traz a calma interior em meio a tempestade exterior.
A paciência paralisa o andamento do problema. A paciência, mais do que morder a língua, mais do que bater a mão na boca, é respirar fundo. Ela purifica o ar. Ter paciência é escolher controlar suas emoções ao invés de permitir que elas lhe controlem. É demonstrar discrição ao invés de pagar mal com mal.
A paciência nos torna sábios. Ela não se apressa em julgar, mas ouve o que a outra pessoa está dizendo. Ela espera na entrada, enquanto a raiva deseja invadir com violência. “O homem paciente dá prova de grande entendimento, mas o precipitado revela insensatez” (Provérbios 14:29).
Assim como a falta de paciência fará de seu lar uma zona de guerra, a prática da paciência estimulará a paz e a tranquilidade. “O homem irritável provoca dissensão, mas quem é paciente acalma a discussão” (Provérbios 15:18).
A paciência lhe ajuda a dar ao seu cônjuge o direito de ser humano. A paciência entende que todos falham. Poucos de nós praticam a paciência de forma adequada e nenhum de nós a pratica naturalmente. Mas o homem e a mulher sábios verão a paciência como um ingrediente essencial no casamento. Este é um bom ponto de partida para demonstrar amor verdadeiro.

“Sejam todos prontos para ouvir, tardios para falar e tardios para irar-se”(Tiago 1:19).

Também não esqueçam da pílula do amor da semana, seu cônjuge está recebendo outra diferente. Tente descobrir qual é a dele(a).

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
