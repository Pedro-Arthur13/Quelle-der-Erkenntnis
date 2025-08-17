DROP TABLE IF EXISTS friendships;
DROP TABLE IF EXISTS book_categories;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS categories;

CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  bio TEXT,
  pfp_url TEXT DEFAULT 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Le_Penseur_by_Rodin_%28Kunsthalle_Bielefeld%29_2014-04-10.JPG/1200px-Le_Penseur_by_Rodin_%28Kunsthalle_Bielefeld%29_2014-04-10.JPG',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE friendships (
  requester_id INTEGER NOT NULL,
  addressee_id INTEGER NOT NULL,
  status TEXT NOT NULL, 
  PRIMARY KEY (requester_id, addressee_id),
  FOREIGN KEY (requester_id) REFERENCES users (id),
  FOREIGN KEY (addressee_id) REFERENCES users (id),
  CHECK (requester_id != addressee_id) 
);

CREATE TABLE authors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  birth_date TEXT,
  biography TEXT
);

CREATE TABLE books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  publication_year INTEGER,
  review TEXT,
  critic_score REAL,
  cover_image_url TEXT,
  author_id INTEGER NOT NULL, 
  FOREIGN KEY (author_id) REFERENCES authors (id)
);

CREATE TABLE reservations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  book_id INTEGER NOT NULL,
  reservation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status TEXT NOT NULL, 
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (book_id) REFERENCES books (id)
);


INSERT INTO authors (id, name, birth_date, biography) VALUES
  (1, 'J.R.R. Tolkien', '1892-01-03', 'John Ronald Reuel Tolkien foi um escritor, professor universitário e filólogo britânico, conhecido por suas obras de alta fantasia.'),
  (2, 'George Orwell', '1903-06-25', 'Eric Arthur Blair, mais conhecido como George Orwell, foi um escritor e jornalista inglês. Sua obra é marcada por uma inteligência perspicaz e bem-humorada, uma consciência profunda das injustiças sociais e uma oposição ao totalitarismo.'),
  (3, 'Emily Brontë', '1818-07-30', 'Poetisa e romancista britânica, tornou-se famosa por seu único romance, O Morro dos Ventos Uivantes, um clássico da literatura inglesa.'),
  (4, 'Bram Stoker', '1847-11-08', 'Escritor irlandês, mais conhecido por seu romance gótico de 1897, Drácula.'),
  (5, 'William Shakespeare', '1564-04-26', 'Poeta, dramaturgo e ator inglês, tido como o maior escritor do idioma inglês e o mais influente dramaturgo do mundo.'),
  (6, 'Platão', '428/427 a.C.', 'Filósofo e matemático do período clássico da Grécia Antiga, autor de diversos diálogos filosóficos e fundador da Academia em Atenas.'),
  (7, 'Albert Camus', '1913-11-07', 'Escritor, filósofo, romancista, dramaturgo, jornalista e ensaísta franco-argelino. Foi agraciado com o Prêmio Nobel de Literatura de 1957.'),
  (8, 'Santo Agostinho', '354-11-13', 'Bispo, teólogo e filósofo do Império Romano, cujos escritos influenciaram o desenvolvimento do cristianismo e da filosofia ocidental.'),
  (9, 'Santo Tomás de Aquino', '1225-01-28', 'Frade católico italiano da Ordem dos Pregadores, cujos trabalhos filosóficos e teológicos tiveram imensa influência.'),
  (10, 'Jane Austen', '1775-12-16', 'Romancista inglesa, cujas obras, com sua ironia, realismo e crítica social, a tornaram uma das escritoras mais lidas e amadas da literatura inglesa.'),
  (11, 'Franz Kafka', '1883-07-03', 'Escritor de língua alemã, de origem judaica, autor de romances e contos, considerado um dos principais escritores da literatura moderna.'),
  (12, 'Fiódor Dostoiévski', '1821-11-11', 'Escritor, filósofo e jornalista do Império Russo. É considerado um dos maiores romancistas e pensadores da história da literatura mundial.'),
  (13, 'Christopher Paolini', '1983-11-17', 'Escritor norte-americano, famoso pela série de livros de fantasia "Ciclo da Herança", que começou com Eragon.'),
  (14, 'C.S. Lewis', '1898-11-29', 'Escritor, professor e teólogo irlandês, conhecido por suas obras de ficção, especialmente As Crônicas de Nárnia.'),
  (15, 'Ursula K. Le Guin', '1929-10-21', 'Escritora americana, conhecida por seus trabalhos de ficção especulativa, incluindo obras de ficção científica e fantasia.'),
  (16, 'Eurípides', '480 a.C.', 'Um dos três grandes poetas trágicos da Grécia clássica, ao lado de Ésquilo e Sófocles.'),
  (17, 'Homero', 'século VIII a.C.', 'Poeta épico da Grécia Antiga, a quem são atribuídas as obras Ilíada e Odisseia.'),
  (18, 'Johann Wolfgang von Goethe', '1749-08-28', 'Escritor, estadista, cientista e filósofo alemão. Sua obra-prima, Fausto, é uma das peças mais importantes da literatura mundial.'),
  (19, 'Alexandre Dumas', '1802-07-24', 'Escritor francês, célebre por seus romances históricos de aventura, como O Conde de Monte Cristo e Os Três Mosqueteiros.'),
  (20, 'Osamu Dazai', '1909-06-19', 'Um dos mais importantes ficcionistas do Japão do século XX, conhecido por seu estilo autobiográfico e confessional.'),
  (21, 'Liev Tolstói', '1828-09-09', 'Escritor russo, amplamente considerado um dos maiores romancistas da história, autor de Guerra e Paz e Anna Karenina.'),
  (22, 'H.P. Lovecraft', '1890-08-20', 'Escritor americano que alcançou fama póstuma por seus trabalhos de ficção de terror, que deram origem ao gênero "Horror Cósmico".'),
  (23, 'Jean-Paul Sartre', '1905-06-21', 'Filósofo, escritor e crítico francês, conhecido como um dos principais expoentes do existencialismo.'),
  (24, 'Aristóteles', '384 a.C.', 'Filósofo grego, aluno de Platão e professor de Alexandre, o Grande. Seus escritos abrangem diversos assuntos, como física, metafísica, poesia, teatro, música, lógica, retórica, política, governo, ética e biologia.'),
  (25, 'Luís Vaz de Camões', '1524', 'Considerado uma das maiores figuras da literatura lusófona e um dos maiores poetas do Ocidente.'),
  (26, 'Sir Thomas Malory', '1415', 'Escritor inglês, autor ou compilador de "Le Morte d''Arthur", a mais célebre versão da lenda do Rei Arthur em língua inglesa.'),
  (27, 'Machado de Assis', '1839-06-21', 'Escritor brasileiro, amplamente considerado como o maior nome da literatura nacional.'),
  (28, 'Arthur Conan Doyle', '1859-05-22', 'Escritor e médico britânico, mundialmente famoso por suas histórias sobre o detetive Sherlock Holmes.'),
  (29, 'Mary Shelley', '1797-08-30', 'Escritora britânica, conhecida por seu romance gótico "Frankenstein; ou, O Moderno Prometeu".'),
  (30, 'Andrzej Sapkowski', '1948-06-21', 'Escritor polonês de fantasia, criador da aclamada série de livros The Witcher.'),
  (31, 'Victor Hugo', '1802-02-26', 'Romancista, poeta, dramaturgo, ensaísta, artista, estadista e ativista pelos direitos humanos francês de grande atuação política em seu país.'),
  (32, 'F. Scott Fitzgerald', '1896-09-24', 'Escritor norte-americano, autor de romances e contos que retratam a "Era do Jazz" nos Estados Unidos.'),
  (33, 'Aldous Huxley', '1894-07-26', 'Escritor e filósofo inglês, autor de romances, ensaios, contos e roteiros.'),
  (34, 'Ray Bradbury', '1920-08-22', 'Escritor norte-americano de ficção científica, fantasia, horror e mistério.'),
  (35, 'George R. R. Martin', '1948-09-20', 'Roteirista e escritor de ficção científica e fantasia norte-americano. É mais conhecido por escrever a série de livros de fantasia épica "As Crônicas de Gelo e Fogo".'),
  (36, 'J. D. Salinger', '1919-01-01', 'Escritor norte-americano, conhecido pelo seu romance O Apanhador no Campo de Centeio.'),
  (37, 'Gabriel García Márquez', '1927-03-06', 'Escritor, jornalista, editor, ativista e político colombiano. Considerado um dos mais importantes autores do século XX.'),
  (38, 'Virginia Woolf', '1882-01-25', 'Escritora, ensaísta e editora britânica, conhecida como uma das mais importantes figuras do modernismo.'),
  (39, 'Friedrich Nietzsche', '1844-10-15', 'Friedrich Wilhelm Nietzsche foi um filósofo, filólogo, crítico cultural, poeta e compositor prussiano do século XIX, nascido na atual Alemanha. Escreveu vários textos criticando a religião, a moral, a cultura contemporânea, a filosofia e a ciência, exibindo certa predileção por metáfora, ironia e aforismo.'),
  (40, 'François-Marie Arouet (Voltaire)', '1694-11-21', 'Voltaire foi um escritor versátil e prolífico, produzindo obras em quase todas as formas literárias, incluindo peças de teatro, poemas, romances, ensaios, histórias e exposições científicas. Ele escreveu mais de vinte mil cartas e dois mil livros e panfletos. Voltaire foi um dos primeiros autores a se tornar conhecido e comercialmente bem-sucedido internacionalmente. '),
  (41, 'Frank Herbert', '1920-10-8', 'Frank Patrick Herbert foi um escritor de ficção científica e jornalista americano de grande sucesso comercial e de crítica. É mais conhecido pela obra Duna, e os cinco livros subsequentes da série'),
  (42, 'Isaac Asimov', '1920-01-2', 'Isaac Asimov foi um escritor e bioquímico russo-americano, autor de obras de ficção científica e divulgação científica. Asimov é considerado um dos mestres da ficção científica e, junto com Robert A. Heinlein e Arthur C. Clarke, foi considerado um dos "três grandes" dessa área da literatura.'),
  (43, 'Thomas Hobbes', '1588-04-05', 'Thomas Hobbes foi um filósofo inglês, mais conhecido por seu livro de 1651 Leviatã, no qual ele expõe uma formulação influente da teoria do contrato social. Ele é considerado um dos fundadores da filosofia política moderna.'),
  (44, 'Marco Aurélio', '121-04-26', 'Marco Aurélio foi o imperador romano de 161 até sua morte. Era filho de Domícia Lucila e do pretor Marco Ânio Vero, sobrinho do imperador Adriano. Seu pai morreu quando tinha três anos e ele foi criado por sua mãe e avô. Adriano adotou Antonino Pio, tio de Marco Aurélio, como novo herdeiro em 138.'),
  (45, 'Herman Melville', '1819-08-01', 'Herman Melville foi um escritor, poeta e ensaísta americano, conhecido por seu romance Moby Dick, um dos livros mais populares da história. É também lembrado por seu conto Bartlebly, o escrivão, considerado um precursor da literatura do absurdo'),
  (46, 'Robert Louis Stevenson', '1850-11-13', 'Prosador e poeta, brilhou ao mesmo tempo no conto e no ensaio, com destaque para sua capacidade para estruturar tramas, como nos míticos O estranho caso do Dr. Jekyll e Mr. Hyde (também conhecido como O médico e o monstro) e A Ilha do Tesouro. Passou seus anos finais em Samoa, no Pacífico. Morreu em 1894.'),
  (47, 'Jonathan Swift', '1667-11-30', 'Jonathan Swift foi um escritor anglo-irlandês, panfletário político, poeta e clérigo que depois se tornou reitor da Catedral de São Patrício, em Dublin.'),
  (48, 'Immanuel Kant', '1724-04--22', 'Immanuel Kant ou Emanuel Kant, foi um filósofo alemão e um dos principais pensadores do Iluminismo. Seus abrangentes e sistemáticos trabalhos em epistemologia, metafísica, ética e estética tornaram-no uma das figuras mais influentes da filosofia ocidental moderna.'),
  (49, 'Umberto Eco', '1932-01-05', 'Umberto Eco foi um escritor, filósofo, semiólogo, linguista e bibliófilo italiano de fama internacional. Foi titular da cadeira de Semiótica e diretor da Escola Superior de ciências humanas na Universidade de Bolonha.'),
  (50, 'Niccolò di Bernardo dei Machiavelli', '1469-04-03', 'Niccolò di Bernardo dei Machiavelli foi um filósofo, historiador, poeta, diplomata e músico de origem florentina do Renascimento. É reconhecido como fundador do pensamento e da ciência política moderna, pelo fato de ter escrito sobre o Estado e o governo como realmente são, e não como deveriam ser'),
  (51, 'Stanisław Lem', '1921-09-12', 'Stanisław Herman Lem foi um proeminente escritor polaco de ficção científica, filosofia e sátira. Ele foi Cavaleiro da Ordem da Águia Branca. Seus livros foram traduzidos para mais de 57 idiomas e venderam mais de 45 milhões de cópias.');

-- J.R.R. Tolkien (ID: 1)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('O Hobbit', 1937, 'A jornada de Bilbo Bolseiro, um hobbit pacato que é arrastado para uma aventura épica para roubar o tesouro de um dragão.', 9.5, 'https://m.media-amazon.com/images/I/91M9xPIf10L.jpg', 1),
  ('A Sociedade do Anel', 1954, 'O início da jornada de Frodo para destruir o Um Anel, formando a Sociedade do Anel para ajudá-lo em sua perigosa missão.', 10.0, 'https://m.media-amazon.com/images/I/81MZ8OjmQrL._UF1000,1000_QL80_.jpg', 1),
  ('As Duas Torres', 1954, 'A Sociedade se divide, e os heróis enfrentam novos perigos, desde a traição de Saruman até os exércitos de Sauron.', 9.9, 'https://m.media-amazon.com/images/I/81lQ5N0QwJL._UF1000,1000_QL80_.jpg', 1),
  ('O Retorno do Rei', 1955, 'A conclusão da saga, com a batalha final pela Terra-média e o destino do Um Anel.', 10.0, 'https://m.media-amazon.com/images/I/71+4uDgt8JL._UF1000,1000_QL80_.jpg', 1),
  ('O Silmarillion', 1977, 'Uma coleção de mitos e lendas que formam o pano de fundo para O Hobbit e O Senhor dos Anéis.', 9.2, 'https://m.media-amazon.com/images/I/81MoknVer8L.jpg', 1),
  ('Contos Inacabados de Númenor e da Terra-média', 1980, 'Uma coleção de histórias que expandem o universo da Terra-média, editadas por Christopher Tolkien.', 8.8, 'https://m.media-amazon.com/images/I/61WFDmupQQL._UF1000,1000_QL80_.jpg', 1),
  ('Os Filhos de Húrin', 2007, 'Uma trágica história de um herói da Primeira Era da Terra-média, amaldiçoado pelo Lorde das Trevas Morgoth.', 9.1, 'https://m.media-amazon.com/images/I/81s9uYz2EGL.jpg', 1),
  ('Ferreiro do bosque maior', 1967, 'Conheça uma das adoráveis histórias de J.R.R. Tolkien para o público infantil! Em edição pocket, com capa dura, fitilho e com ilustrações de Pauline Baynes, este conto de fadas mágico é um ótimo presente para crianças e uma leitura divertida que promete estimular a imaginação e a criatividade de crianças e adultos. Bosque Maior é uma vila conhecida por suas delícias culinárias e pela tradicional Festividade das Boas Crianças. Celebrada a cada vinte e quatro anos, a festa tem como ponto alto o Grande Bolo, o qual é dividido em vinte e quatro pedaços para as vinte e quatro crianças convidadas. Naquele ano, o bolo carrega em uma de suas fatias uma estrela mágica, passaporte para Feéria, o Reino das Fadas. O premiado é o jovem Ferreirinha, que recebe a oportunidade de conhecer maravilhas e perigos ocultos jamais vistos por olhos mortais.', 8.5, 'https://m.media-amazon.com/images/I/A1cABUC-21L.jpg', 1);

-- George Orwell (ID: 2)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('1984', 1949, 'Uma distopia sombria sobre um futuro totalitário onde o Grande Irmão tudo vê e o pensamento é controlado.', 9.8, 'https://images-na.ssl-images-amazon.com/images/I/819js3EQwbL.jpg', 2),
  ('A Revolução dos Bichos', 1945, 'Uma alegoria satírica sobre a Revolução Russa e a ascensão do stalinismo, contada através de animais de uma fazenda.', 9.6, 'https://m.media-amazon.com/images/I/91BsZhxCRjL._UF1000,1000_QL80_.jpg', 2);

-- Clássicos da Literatura
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('O Morro dos Ventos Uivantes', 1847, 'Uma história de amor e vingança sombria e apaixonada nas charnecas da Inglaterra.', 9.4, 'https://m.media-amazon.com/images/I/81BCWxDDQcL._UF894,1000_QL80_.jpg', 3),
  ('Drácula', 1897, 'O romance epistolar que introduziu o Conde Drácula, o mais famoso vampiro da ficção.', 9.3, 'https://m.media-amazon.com/images/I/61MgodE1s0L._UF1000,1000_QL80_.jpg', 4),
  ('Orgulho e Preconceito', 1813, 'Pride and Prejudice (Orgulho e Preconceito) é um romance da escritora britânica Jane Austen. Publicado pela primeira vez em 1813, na verdade havia sido terminado em 1797, antes de ela completar 21 anos, em Steventon, Hampshire, onde Jane morava com os pais. Originalmente denominado First Impressions, nunca foi publicado sob aquele título; ao fazer a revisão dos escritos, Jane intitulou a obra e a publicou como Pride and Prejudice. Austen pode ter tido em mente o capítulo final do romance de Fanny Burney, Cecilia, chamado "Pride and Prejudice". A história mostra a maneira com que a personagem Elizabeth Bennet lida com os problemas relacionados à educação, cultura, moral e casamento na sociedade aristocrática do início do século XIX, na Inglaterra. Elizabeth é a segunda de 5 filhas de um proprietário rural na cidade fictícia de Meryton, em Hertfordshire, não muito longe de Londres.', 9.7, 'https://images.tcdn.com.br/img/img_prod/1271663/orgulho_e_preconceito_437_1_a8697ab0bf79d2a96a5ab182f9f91c5d.jpg', 10),
  ('Frankenstein', 1818, 'A história de Victor Frankenstein, um cientista que cria uma criatura grotesca em um experimento científico heterodoxo.', 9.5, 'https://a-static.mlcdn.com.br/1500x1500/livro-frankenstein/livrariamartinsfontespaulista/1058366/8ec84fd3bd970ff5ca34fda2a716f58d.png', 29),
  ('O Conde de Monte Cristo', 1844, 'Uma épica história de injustiça, sobrevivência e vingança meticulasamente planejada.', 9.8, 'https://m.media-amazon.com/images/I/81ZswN9PVPL._UF1000,1000_QL80_.jpg', 19),
  ('Os Miseráveis', 1862, 'A história da vida de Jean Valjean e a sua experiência de redenção, ambientada na França do século XIX.', 9.9, 'https://m.media-amazon.com/images/I/71L28YvPobL._UF1000,1000_QL80_.jpg', 31),
  ('O Grande Gatsby', 1925, 'Uma crítica à decadência, idealismo e excesso da elite americana nos anos 20.', 9.4, 'https://m.media-amazon.com/images/I/81Ph4QRq1gL._UF1000,1000_QL80_.jpg', 32),
  ('O Apanhador no Campo de Centeio', 1951, 'A história de Holden Caulfield, um adolescente que lida com a angústia e a alienação após ser expulso da escola.', 8.9, 'https://m.media-amazon.com/images/I/71b3GDZMzSL.jpg', 36),
  ('Cem Anos de Solidão', 1967, 'A saga da família Buendía na cidade fictícia de Macondo, uma obra-prima do realismo mágico.', 10.0, 'https://m.media-amazon.com/images/I/817esPahlrL.jpg', 37),
  ('Mrs Dalloway', 1925, 'Um dia na vida de Clarissa Dalloway, uma socialite na Inglaterra pós-Primeira Guerra, usando a técnica do fluxo de consciência.', 9.2, 'https://m.media-amazon.com/images/I/91rOgmnZpJS.jpg', 38),
  ('Ao Farol', 1927, 'Uma exploração complexa das relações familiares e da passagem do tempo.', 9.3, 'https://cdl-static.s3-sa-east-1.amazonaws.com/covers/gg/9788582851654/passeio-ao-farol.jpg', 38);


-- William Shakespeare (ID: 5)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Hamlet', 1603, 'A tragédia do príncipe da Dinamarca que busca vingança pela morte de seu pai.', 10.0, 'https://imusic.b-cdn.net/images/item/original/792/9781398807792.jpg?william-shakespeare-2022-hamlet-arcturus-shakespeare-editions-paperback-book&class=scaled&v=1644560436', 5),
  ('Romeu e Julieta', 1597, 'A icônica história de amor proibido entre dois jovens de famílias rivais em Verona.', 9.8, 'https://m.media-amazon.com/images/I/71uD94gGcBL._UF894,1000_QL80_.jpg', 5),
  ('Macbeth', 1606, 'Uma tragédia sobre um nobre escocês que, impulsionado pela profecia e pela ambição, assassina o rei para tomar o trono.', 9.7, 'https://cdn.kobo.com/book-images/e656fc3d-0126-4fb1-b947-c4c149c47076/353/569/90/False/macbeth-428.jpg', 5),
  ('Otelo', 1603, 'A história de um general mouro cujo amor por sua esposa é destruído pela inveja e manipulação de seu subalterno, Iago.', 9.6, 'https://m.media-amazon.com/images/I/81nCa2eBYML._UF894,1000_QL80_.jpg', 5),
  ('Sonho de uma Noite de Verão', 1595, 'Uma comédia que envolve quatro amantes atenienses e um grupo de atores amadores, que são manipulados por fadas na floresta.', 9.4, 'https://m.media-amazon.com/images/I/915rFCUXeiL.jpg', 5),
  ('Rei Lear', 1606, 'Um rei envelhecido decide dividir seu reino entre suas três filhas, levando a consequências trágicas.', 9.8, 'https://m.media-amazon.com/images/I/81GqXNZ2GwL.jpg', 5);

-- Fiódor Dostoiévski (ID: 12)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Crime e Castigo', 1866, 'A história de Raskólnikov, um estudante pobre que comete um assassinato e lida com a culpa e as consequências morais.', 10.0, 'https://m.media-amazon.com/images/I/916WkSH4cGL.jpg', 12),
  ('Os Irmãos Karamazov', 1880, 'Um romance filosófico que explora questões de fé, dúvida e moralidade através da história de três irmãos e seu pai.', 10.0, 'https://m.media-amazon.com/images/I/91hO1oi4LjL.jpg', 12),
  ('O Idiota', 1869, 'A história do Príncipe Míchkin, cuja bondade e ingenuidade o colocam em conflito com a sociedade russa.', 9.7, 'https://m.media-amazon.com/images/I/41cJHF1NgML._UF894,1000_QL80_.jpg', 12),
  ('Noites Brancas', 1848, 'Um conto sobre um sonhador solitário que encontra uma jovem misteriosa durante as "noites brancas" de São Petersburgo.', 9.2, 'https://m.media-amazon.com/images/I/7143D7foVmL.jpg', 12),
  ('Memórias do Subsolo', 1864, 'Uma obra seminal do existencialismo, narrada por um homem amargo e isolado que ataca as filosofias sociais de sua época.', 9.5, 'https://m.media-amazon.com/images/I/81B8n0OCzTL.jpg', 12);

-- Franz Kafka (ID: 11)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('A Metamorfose', 1915, 'Gregor Samsa acorda uma manhã e descobre que se transformou em um inseto monstruoso.', 9.8, 'https://m.media-amazon.com/images/I/8115Gj1cb6L._UF894,1000_QL80_.jpg', 11),
  ('O Processo', 1925, 'Um homem é preso e processado por uma autoridade remota e inacessível, com a natureza de seu crime nunca sendo revelada.', 9.6, 'https://m.media-amazon.com/images/I/71n7HqKTzFL._UF1000,1000_QL80_.jpg', 11),
  ('O Castelo', 1926, 'Um agrimensor chamado K. luta para ter acesso às autoridades misteriosas de um castelo que governa uma aldeia.', 9.4, 'https://m.media-amazon.com/images/I/81F6N1J0loL.jpg', 11),
  ('Carta ao Pai', 1919, 'Uma longa carta nunca enviada, na qual Kafka explora sua relação conturbada com seu pai autoritário.', 9.0, 'https://m.media-amazon.com/images/I/61MUzEngavL._UF1000,1000_QL80_.jpg', 11);

-- Liev Tolstói (ID: 21)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Guerra e Paz', 1869, 'Um épico que entrelaça a vida de famílias aristocráticas russas com a invasão napoleônica.', 10.0, 'https://m.media-amazon.com/images/I/91uLwQ4Ry8L._UF894,1000_QL80_.jpg', 21),
  ('Anna Karenina', 1878, 'A trágica história de uma aristocrata casada que tem um caso amoroso com o Conde Vronsky.', 9.9, 'https://m.media-amazon.com/images/I/81P5hjww-vL._UF894,1000_QL80_.jpg', 21),
  ('A Morte de Ivan Ilitch', 1886, 'Uma novela sobre a vida e a morte de um juiz de alta corte, explorando a natureza da vida e do sofrimento.', 9.6, 'https://m.media-amazon.com/images/I/61zgVBVoqqL.jpg', 21);

-- Machado de Assis (ID: 27)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Dom Casmurro', 1899, 'A história de Bentinho e Capitu, narrada pelo próprio Bentinho, que suspeita da traição de sua amada.', 10.0, 'https://m.media-amazon.com/images/I/61Z2bMhGicL.jpg', 27),
  ('Memórias Póstumas de Brás Cubas', 1881, 'Um "defunto autor" narra suas memórias, oferecendo uma visão irônica e pessimista da sociedade.', 10.0, 'https://m.media-amazon.com/images/I/91GAAzBixYL._UF894,1000_QL80_.jpg', 27),
  ('Quincas Borba', 1891, 'A história de Rubião, que herda a fortuna e o cachorro do filósofo Quincas Borba, e sua subsequente jornada à loucura.', 9.8, 'https://m.media-amazon.com/images/I/61Kt3d+mhuL.jpg', 27);

-- Filosofia
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('A República', -380, 'Um diálogo socrático de Platão sobre justiça, a ordem e o caráter da cidade-estado ideal.', 9.9, 'https://m.media-amazon.com/images/I/81KkahDyzgL._UF1000,1000_QL80_.jpg', 6),
  ('Apologia de Sócrates', -399, 'A defesa de Sócrates durante seu julgamento por impiedade e corrupção da juventude.', 9.7, 'https://m.media-amazon.com/images/I/71TQDnJO-ML._UF1000,1000_QL80_.jpg', 6),
  ('O Banquete', -385, 'Um diálogo filosófico sobre a natureza do amor, com discursos de vários personagens notáveis.', 9.6, 'https://m.media-amazon.com/images/I/81HQpUxYZDL._UF1000,1000_QL80_.jpg', 6),
  ('Ética a Nicômaco', -350, 'A obra de Aristóteles sobre ética, virtude e a busca pela "vida boa" ou eudaimonia.', 9.8, 'https://m.media-amazon.com/images/I/61XlfMWYClL._UF1000,1000_QL80_.jpg', 24),
  ('Confissões', 400, 'A autobiografia espiritual de Santo Agostinho, detalhando sua jornada pecaminosa e sua conversão ao cristianismo.', 9.5, 'https://m.media-amazon.com/images/I/91hlMYSrG7L._UF1000,1000_QL80_.jpg', 8),
  ('Suma Teológica', 1274, 'A obra mais famosa de Tomás de Aquino, um compêndio de todos os principais ensinamentos teológicos da Igreja Católica.', 9.4, 'https://m.media-amazon.com/images/I/8147aWVPVWL._UF894,1000_QL80_.jpg', 9);

-- Existencialismo (Camus & Sartre)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('O Estrangeiro', 1942, 'A história de Meursault, um homem emocionalmente indiferente que confronta o absurdo da existência.', 9.7, 'https://m.media-amazon.com/images/I/91Sb5HdDL3L.jpg', 7),
  ('A Peste', 1947, 'Uma alegoria sobre a resistência humana diante do sofrimento e do absurdo, ambientada durante uma epidemia em uma cidade argelina.', 9.6, 'https://m.media-amazon.com/images/I/71XcesdyqZL._UF1000,1000_QL80_.jpg', 7),
  ('O Mito de Sísifo', 1942, 'Um ensaio filosófico que introduz a filosofia do absurdo de Camus, usando o mito de Sísifo como metáfora.', 9.5, 'https://m.media-amazon.com/images/I/81ccIcOmAoL._UF1000,1000_QL80_.jpg', 7),
  ('A Náusea', 1938, 'O primeiro romance de Sartre, um marco do existencialismo, que explora a sensação de repulsa do protagonista com a existência.', 9.4, 'https://m.media-amazon.com/images/I/81Bx4QhcigL._UF1000,1000_QL80_.jpg', 23),
  ('O Ser e o Nada', 1943, 'Um tratado filosófico que detalha a ontologia existencialista de Sartre, explorando a consciência, a liberdade e a má-fé.', 9.2, 'https://m.media-amazon.com/images/I/61AWlxU5f1L._UF894,1000_QL80_.jpg', 23);

-- Fantasia
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Eragon', 2002, 'Um jovem fazendeiro encontra um ovo de dragão, iniciando uma jornada para se tornar um Cavaleiro de Dragão e lutar contra um rei maligno.', 8.5, 'https://m.media-amazon.com/images/I/91EJQU2B4cL.jpg', 13),
  ('O Leão, a Feiticeira e o Guarda-Roupa', 1950, 'Quatro irmãos descobrem o mundo mágico de Nárnia através de um guarda-roupa e se juntam a Aslam para derrotar a Feiticeira Branca.', 9.6, 'https://m.media-amazon.com/images/I/7158aW38zxL._UF1000,1000_QL80_.jpg', 14),
  ('Príncipe Caspian', 1951, 'Os irmãos Pevensie retornam a Nárnia para ajudar o jovem Príncipe Caspian a reconquistar seu trono.', 9.2, 'https://m.media-amazon.com/images/I/81vTb2fMonL.jpg', 14),
  ('A Viagem do Peregrino da Alvorada', 1952, 'Edmundo e Lúcia, junto com seu primo, viajam pelos mares de Nárnia a bordo do navio Peregrino da Alvorada.', 9.3, 'https://m.media-amazon.com/images/I/71rHFeIWJKL._UF1000,1000_QL80_.jpg', 14),
  ('O Feiticeiro de Terramar', 1968, 'A história de Ged, um jovem mago que deve corrigir um erro terrível de sua juventude.', 9.4, 'https://m.media-amazon.com/images/I/71-BMB+blgL.jpg', 15),
  ('Le Morte d''Arthur', 1485, 'A compilação clássica das lendas do Rei Arthur, Camelot, e os Cavaleiros da Távola Redonda.', 9.3, 'https://m.media-amazon.com/images/I/81shhONHRBL._UF1000,1000_QL80_.jpg', 26),
  ('A Guerra dos Tronos', 1996, 'O primeiro livro da série "As Crônicas de Gelo e Fogo", sobre a luta pelo poder entre as casas nobres de Westeros.', 9.7, 'https://m.media-amazon.com/images/I/91+1SUO3vUL.jpg', 35);

-- The Witcher (ID: 30)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('O Último Desejo', 1993, 'Uma coleção de contos que introduz Geralt de Rívia, um bruxo caçador de monstros em um mundo de fantasia sombria.', 9.3, 'https://m.media-amazon.com/images/I/71S8+LByWLL.jpg', 30),
  ('A Espada do Destino', 1992, 'Mais contos que aprofundam o personagem de Geralt e introduzem a jovem Ciri.', 9.4, 'https://m.media-amazon.com/images/I/81kRaP9Ou0L._UF1000,1000_QL80_.jpg', 30),
  ('O Sangue dos Elfos', 1994, 'O primeiro romance da saga, onde Geralt protege Ciri, cujo destino está ligado ao futuro do mundo.', 9.5, 'https://m.media-amazon.com/images/I/71TNe9e4WiL.jpg', 30),
  ('Tempo do Desprezo', 1995, 'A guerra se aproxima enquanto Geralt e Yennefer tentam proteger Ciri de várias facções que a caçam.', 9.5, 'https://m.media-amazon.com/images/I/91V77Yjl1vL._UF894,1000_QL80_.jpg', 30),
  ('Batismo de Fogo', 1996, 'Geralt forma uma nova e improvável companhia para resgatar Ciri.', 9.4, 'https://m.media-amazon.com/images/I/71YQeYwc2LL.jpg', 30),
  ('A Torre da Andorinha', 1997, 'Ciri, separada de todos, luta pela sobrevivência enquanto Geralt a procura incansavelmente.', 9.6, 'https://m.media-amazon.com/images/I/81xF+gPfnSL.jpg', 30),
  ('A Senhora do Lago', 1999, 'A conclusão épica da saga de Geralt e Ciri.', 9.7, 'https://a-static.mlcdn.com.br/1500x1500/livro-a-senhora-do-lago-the-witcher-a-saga-do-bruxo-geralt-de-rivia-capa-dura/magazineluiza/225158200/d4c4aa281a5adf5948be983d9692865b.jpg', 30);

-- Épicos e Clássicos Antigos
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Medeia', -431, 'Uma tragédia grega sobre uma mulher que busca uma vingança terrível contra seu marido infiel, Jasão.', 9.2, 'https://m.media-amazon.com/images/I/91zqKMSv1vL._UF1000,1000_QL80_.jpg', 16),
  ('Ilíada', -750, 'O poema épico que narra os eventos da Guerra de Troia, focando na ira do herói Aquiles.', 9.8, 'https://m.media-amazon.com/images/I/71YjXYdQaFL._UF1000,1000_QL80_.jpg', 17),
  ('Odisseia', -725, 'A jornada de dez anos de Odisseu (Ulisses) para retornar para casa em Ítaca após a Guerra de Troia.', 9.9, 'https://m.media-amazon.com/images/I/81mOya9H93L._UF894,1000_QL80_.jpg', 17),
  ('Fausto, Parte Um', 1808, 'A história de um erudito que faz um pacto com o demônio Mefistófeles em busca de conhecimento e prazeres ilimitados.', 9.7, 'https://m.media-amazon.com/images/I/717wY1q7YaL._UF894,1000_QL80_.jpg', 18),
  ('Os Lusíadas', 1572, 'O poema épico português que celebra as viagens e descobertas de Vasco da Gama e a história de Portugal.', 9.5, 'https://m.media-amazon.com/images/I/81X2-rTPT+L._UF894,1000_QL80_.jpg', 25);

-- Outros
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Declínio de um Homem (No Longer Human)', 1948, 'Um romance semi-autobiográfico que explora a alienação e a incapacidade de um homem de se conectar com a sociedade.', 9.3, 'https://m.media-amazon.com/images/I/713W6Pe-lwL._UF894,1000_QL80_.jpg', 20),
  ('O Chamado de Cthulhu', 1928, 'Um conto seminal do horror cósmico, sobre a descoberta de um culto e uma entidade antiga e poderosa.', 9.6, 'https://m.media-amazon.com/images/I/81kNklHz-nL._UF894,1000_QL80_.jpg', 22),
  ('Nas Montanhas da Loucura', 1936, 'Uma expedição à Antártida descobre ruínas de uma civilização antiga e os horrores que ela abrigava.', 9.5, 'https://m.media-amazon.com/images/I/716uwVltD4L._UF1000,1000_QL80_.jpg', 22),
  ('A Sombra sobre Innsmouth', 1936, 'Um estudante descobre os segredos sombrios de uma cidade portuária decadente e seus habitantes misteriosos.', 9.4, 'https://m.media-amazon.com/images/I/817lGyBm3FL._UF894,1000_QL80_.jpg', 22),
  ('Admirável Mundo Novo', 1932, 'Uma distopia sobre uma sociedade futurista geneticamente modificada e controlada por condicionamento psicológico.', 9.7, 'https://m.media-amazon.com/images/I/71Q6AA8w42L._UF894,1000_QL80_.jpg', 33),
  ('Fahrenheit 451', 1953, 'Em um futuro onde os livros são proibidos e queimados, um bombeiro começa a questionar seu papel.', 9.6, 'https://m.media-amazon.com/images/I/51tAD6LyZ-L._UF1000,1000_QL80_.jpg', 34);

-- Sherlock Holmes (ID: 28)
INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Um Estudo em Vermelho', 1887, 'A primeira aparição de Sherlock Holmes e Dr. Watson, investigando um misterioso assassinato em Londres.', 9.5, 'https://m.media-amazon.com/images/I/61GFsO7j0ZL._UF1000,1000_QL80_.jpg', 28),
  ('O Signo dos Quatro', 1890, 'Holmes e Watson investigam o caso de uma jovem que recebe uma pérola misteriosa todos os anos.', 9.4, 'https://m.media-amazon.com/images/I/61Inkv0s0AL._UF1000,1000_QL80_.jpg', 28),
  ('As Aventuras de Sherlock Holmes', 1892, 'Uma coleção de doze contos que solidificaram a fama do grande detetive.', 9.7, 'https://m.media-amazon.com/images/I/613LTnr4lgL._UF1000,1000_QL80_.jpg', 28),
  ('O Cão dos Baskervilles', 1902, 'Holmes investiga uma lenda sobre um cão demoníaco que assombra uma família em Dartmoor.', 9.8, 'https://m.media-amazon.com/images/I/61oliHz5jSL.jpg', 28);

INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
  ('Persuasão', 1817, 'Último romance completo de Jane Austen, sobre uma segunda chance no amor.', 9.3, 'https://m.media-amazon.com/images/I/71s8nlbBMvL._UF1000,1000_QL80_.jpg', 10),
  ('Emma', 1815, 'Uma jovem rica e inteligente que se diverte bancando a casamenteira, com consequências cômicas e românticas.', 9.4, 'https://m.media-amazon.com/images/I/71YMvGXuwKL._UF1000,1000_QL80_.jpg', 10),
  ('A Tempestade', 1611, 'Uma das últimas peças de Shakespeare, misturando magia, comédia e romance em uma ilha encantada.', 9.5, 'https://m.media-amazon.com/images/I/81fxLMrIMGL.jpg', 5),
  ('Júlio César', 1599, 'A tragédia da conspiração contra o ditador romano, explorando temas de honra, patriotismo e traição.', 9.6, 'https://m.media-amazon.com/images/I/81BydzCV53L._UF1000,1000_QL80_.jpg', 5),
  ('O Duplo', 1846, 'Uma novela de Dostoiévski sobre um funcionário público que enlouquece ao encontrar seu doppelgänger.', 8.9, 'https://m.media-amazon.com/images/I/91+LUtbviOL.jpg', 12),
  ('A Queda', 1956, 'Um romance filosófico de Camus na forma de um monólogo dramático de um "juiz-penitente".', 9.3, 'https://m.media-amazon.com/images/I/71hs-PplcWL._UF1000,1000_QL80_.jpg', 7),
  ('O Primeiro Homem', 1994, 'Romance autobiográfico inacabado de Camus, publicado postumamente, sobre sua infância na Argélia.', 9.1, 'https://m.media-amazon.com/images/I/91lO6J4xNGL._UF1000,1000_QL80_.jpg', 7),
  ('A Fúria dos Reis', 1999, 'A sequência de "A Guerra dos Tronos", continuando a épica saga de Westeros.', 9.8, 'https://m.media-amazon.com/images/I/91PglZzF9kL._UF1000,1000_QL80_.jpg', 35),
  ('A Tormenta de Espadas', 2000, 'O terceiro livro da série, com eventos chocantes e reviravoltas que mudam o jogo pelo Trono de Ferro.', 10.0, 'https://m.media-amazon.com/images/I/912SYaebhuL.jpg', 35),
  ('O Festim dos Corvos', 2005, 'O quarto livro, focando nos reinos do Sul após a guerra e nas intrigas políticas.', 9.2, 'https://m.media-amazon.com/images/I/915n69YKrCL.jpg', 35),
  ('A Dança dos Dragões', 2011, 'O quinto livro, retornando aos personagens do Norte e do outro lado do mar, como Daenerys e Jon Snow.', 9.6, 'https://m.media-amazon.com/images/I/91DisjRjFxL._UF1000,1000_QL80_.jpg', 35),
  ('Crítica da Razão Pura', 1781, 'Obra seminal de Immanuel Kant que revolucionou a filosofia ocidental.', 9.5, 'https://m.media-amazon.com/images/I/91x-Sp4f+jL._UF1000,1000_QL80_.jpg', 48),
  ('Assim Falou Zaratustra', 1883, 'A obra mais famosa de Friedrich Nietzsche, explorando conceitos como o Übermensch e o eterno retorno.', 9.7, 'https://m.media-amazon.com/images/I/613ZVoVVeXL.jpg', 39),
  ('Leviatã', 1651, 'A obra de Thomas Hobbes sobre a estrutura da sociedade e o governo legítimo, um dos fundamentos da filosofia política moderna.', 9.4, 'https://m.media-amazon.com/images/I/91DrceRCs8L.jpg', 43),
  ('O Príncipe', 1532, 'Tratado político de Nicolau Maquiavel, oferecendo conselhos sobre como um príncipe pode obter e manter o poder.', 9.6, 'https://m.media-amazon.com/images/I/81h4CdNxdgL.jpg', 50),
  ('Meditações', 180, 'Os pensamentos privados do imperador romano Marco Aurélio, um clássico da filosofia estoica.', 9.8, 'https://m.media-amazon.com/images/I/818piLnMRgL._UF1000,1000_QL80_.jpg', 44),
  ('Os Três Mosqueteiros', 1844, 'Aventura histórica de Alexandre Dumas sobre o jovem d''Artagnan e seus amigos Athos, Porthos e Aramis.', 9.5, 'https://m.media-amazon.com/images/I/817bVkQAWhL._UF1000,1000_QL80_.jpg', 19),
  ('Vinte Anos Depois', 1845, 'A sequência de Os Três Mosqueteiros, reencontrando os heróis no meio de uma guerra civil na França.', 9.2, 'https://m.media-amazon.com/images/I/81ZN75SqTsL.jpg', 19),
  ('O Homem da Máscara de Ferro', 1850, 'A conclusão da saga dos mosqueteiros, envolvendo um dos maiores mistérios da história da França.', 9.3, 'https://m.media-amazon.com/images/I/91O3y0HW5vL.jpg', 19),
  ('A Princesa de Babilônia', 1768, 'Conto filosófico de Voltaire sobre uma princesa que viaja pelo mundo em busca de seu amado.', 8.8, 'https://m.media-amazon.com/images/I/81ttffKkpZL._UF1000,1000_QL80_.jpg', 40),
  ('Cândido, ou o Otimismo', 1759, 'Sátira de Voltaire que ataca o otimismo filosófico, seguindo as desventuras de seu ingênuo protagonista.', 9.6, 'https://m.media-amazon.com/images/I/71L7Yi-k6PL._UF1000,1000_QL80_.jpg', 40);

INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES
('Moby Dick', 1851, 'A saga do Capitão Ahab e sua busca obsessiva pela baleia branca Moby Dick.', 9.5, 'https://m.media-amazon.com/images/I/710K+kF6XfL._UF894,1000_QL80_.jpg', 45),
('As Viagens de Gulliver', 1726, 'Uma sátira da natureza humana e da sociedade, através das viagens fantásticas de Lemuel Gulliver.', 9.1, 'https://m.media-amazon.com/images/I/916ApCZHQUS.jpg', 47),
('A Ilha do Tesouro', 1883, 'Uma clássica história de piratas, mapas do tesouro e aventura em alto mar.', 9.3, 'https://m.media-amazon.com/images/I/81N-C60M53L._UF1000,1000_QL80_.jpg', 46),
('O Amor nos Tempos do Cólera', 1985, 'A história de Florentino Ariza e Fermina Daza, um amor que dura mais de cinquenta anos.', 9.8, 'https://m.media-amazon.com/images/I/71GjyZVAYEL.jpg', 37),
('Crônica de uma Morte Anunciada', 1981, 'A reconstrução jornalística de um assassinato em uma pequena cidade, onde todos sabiam que ia acontecer.', 9.6, 'https://m.media-amazon.com/images/I/81HGWltuwfL.jpg', 37),
('O Nome da Rosa', 1980, 'Um monge franciscano investiga uma série de assassinatos misteriosos em um mosteiro italiano no século XIV.', 9.7, 'https://m.media-amazon.com/images/I/81uo8phJ+zL._UF1000,1000_QL80_.jpg', 49),
('Solaris', 1961, 'Cientistas em uma estação espacial estudam um planeta oceânico que parece ser uma única entidade viva e consciente.', 9.4, 'https://m.media-amazon.com/images/I/71YpunDnbwL._UF1000,1000_QL80_.jpg', 51),
('Duna', 1965, 'Uma épica saga de ficção científica sobre política, religião e a luta pelo controle de um planeta deserto e seu valioso recurso.', 10.0, 'https://m.media-amazon.com/images/I/81zN7udGRUL.jpg', 41),
('Eu, Robô', 1950, 'Uma coleção de contos de Isaac Asimov que explora a relação entre humanos, robôs e as Três Leis da Robótica.', 9.6, 'https://m.media-amazon.com/images/I/81eDqX4-H2L._UF894,1000_QL80_.jpg', 42);
