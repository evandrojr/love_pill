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
  db = SQLite3::Database.new "love_pill.test.sqlite3"
#  db = SQLite3::Database.new "love_pill.sqlite3"
  puts db.get_first_value 'SELECT SQLITE_VERSION()'
  stm = db.prepare "SELECT email from user"
  rs = stm.execute
  Gmail.new(username, password) do |gmail|
    rs.each do |row|
      last_email = row[0]
      email = gmail.generate_message do
        from "evandrojr@gmail.com"
        to row[0]
        subject "Pílula do amor D&M - Tema da semana: Como manter a paixão no casamento"
        body "Olá!

Aqui vai a sugestão de Dengo (Evandro) e Modesta (Paulinha) para dar uma aquecida na sua relação. Experimente fazer isto durante esta semana.

Sua pílula do amor é:

--------------------------------------------------------------------------------

#{pills[prng.rand(0...pills.size)]}

--------------------------------------------------------------------------------

10 segredos para manter a paixão no casamento

Fonte: https://familia.com.br/7591/casamento/10-segredos-para-manter-a-paixao-no-casamento

Sempre que ouvimos uma nova história de traição entre marido e mulher, alguém diz: \"Se traiu é porque não existia amor.\"

Será?

Se você plantar uma semente e largar, ela vai morrer. Da mesma forma, casamento e amor precisam de cuidados para crescer, florescer e criar raízes profundas. E isso inclui a paixão. Não aquela paixão do início, que não via defeitos nem conhecia o outro profundamente e tudo era lindo e perfeito. Mas a chama do casamento, aquela que lhe faz ter um friozinho na barriga quando o cônjuge chega perto, aquela que lhe faz olhar para o outro e admirá-lo, querer ficar junto, tocar, sentir, ouvir.

Como manter isso após anos de convivência, problemas financeiros que virão, saúde dos familiares, filhos e desilusões? Aqui estão 10 segredos para saber e colocar em prática.

1. Cumplicidade

Antes de casar, ou mesmo depois, façam um acordo: Nada do que acontecer irá desunir você e seu amor. Mesmo que houver brigas, já decidam antes que ficarão juntos sempre. Quando um casal é cúmplice um do outro, isso pode ser notado até na maneira como se olham.

2. Respeito

Não somente respeito no sentido de fidelidade, mas respeito à opinião da pessoa, aos diferentes gostos, à história de vida que aquela pessoa tem, mesmo às experiências que trouxe para a vida a dois.

3. Romantismo

Quando um homem quer conquistar uma mulher, ele se perfuma, abre a porta do carro, segura sua mão ao andar. Quando uma mulher quer conquistar um homem, ela se cuida, fala baixo, olha com amor e sorri. Manter pequenos rituais de gentileza faz uma grande diferença ao longo dos anos.

4. Diálogo

Conforme a vida acontece, os afazeres tendem a distanciar corações. Normalmente nosso amor é nosso amigo, mas ninguém consegue adivinhar o que o outro está pensando. Mantenha o costume de conversar com seu cônjuge pelo menos alguns minutos por dia, independente do cansaço e agenda.

5. Espaço conjunto

Manter o espaço de vocês intocável faz toda a diferença. Pode haver épocas que as crianças e o cachorro venham dormir no meio de vocês, mas sempre que puder, mantenha o quarto como o refúgio do casal. Um local protegido por quatro paredes onde vocês podem ser vocês mesmos e resgatar o amor a qualquer hora. E usem-no para este propósito sempre!

6. Buscar o progresso

Isso significa cultivar uma atividade que você goste de fazer, seja algo que quer aprender, estudar, fazer, construir. Isso funciona como uma terapia na vida de cada um. Aprender a rir de si mesmo também ajuda na hora de exercer paciência e tolerância, sem achismos e julgamentos, no relacionamento com toda a família.

7. Celebrações

Comemorem as datas importantes. Eu e meu marido somos casados há quase 25 anos, e todo mês saímos para jantar na data de aniversário de casamento. Nem sempre foi possível sair, muitas vezes foi conversando sob as estrelas enrolados em cobertores enquanto as crianças assistiam um desenho na TV após o jantar. Outras vezes foi comendo pipoca e assistindo um filme juntos depois que as crianças dormiram. Muitas vezes, aquela data foi a única durante todo o mês que tivemos tempo e disposição de ficarmos a sós e lembrarmos dos laços que nos unem. Mas nunca deixamos de lembrar da data que finalmente conseguimos ficar juntos e decidimos ser o porto seguro um do outro. Não tenho palavras para descrever como isso ajudou nosso casamento até hoje.

8. Jogar fora do dicionário a palavra \"divórcio\"

No mundo afora se algo não vai bem no casamento, logo se fala em divórcio. Não jogue fora, conserte. Pense bem antes de cometer algo que irá machucar o outro. Tome boas decisões. A segurança que isso passará ao outro o ajudará a dedicar-se a cada dia para melhorar ainda mais o relacionamento.

9. Rituais e tempo com a família

Tradições de todos os tipos, diárias ou anuais, mantenha todas com os filhos e individualmente com cada um e com o outro. Não precisam fazer sempre as mesmas coisas, podem variar. O importante é fazê-las. Inclua o riso, o abraço, a oração, a lealdade, o carinho e humildade.

10. Demonstre amor todos os dias

Sim, todos os dias. Pode ser um beijo na hora de sair ou chegar, um bilhete, um SMS, uma rosa, um jantar, deitar no peito dele alguns minutos antes de dormir, uma sobremesa. Pode ser também perdoar, dar uma segunda chance, ter paciência, ouvir, olhar nos olhos. São pequenas doses de adubo na plantinha chamada \"amor\" que são extremamente necessárias para fazer as raízes se aprofundarem. Para melhor entendimento, leia o artigo 5 maneiras infalíveis de demonstrar amor.

Vocês podem fazer tudo isso. Todavia, não há segredo em uma coisa: Os dois, marido e mulher, precisam se empenhar para que a semente se transforme numa árvore forte e firme, que dê bons frutos, sombra e proteção das interpéries da vida.
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
