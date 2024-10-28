/* Prova finale modulo SQL 
corso DAPT0524IT
codice scritto da Enzo Amato
*/

-- Cancello eventuali DB già esistenti con lo stesso nome, risultati di refusi o altro

DROP DATABASE IF EXISTS ToysGroup;

-- Creo il DB del progetto
CREATE DATABASE IF NOT EXISTS ToysGroup;

-- Utilizzo il BD creato per lavorare

USE ToysGroup;

-- Crea la tabella PRODUCT con i datatype e qualche contraints, ma senza chiavi

CREATE TABLE IF NOT EXISTS Product (
Product_ID INT NOT NULL
, Product_Name VARCHAR(40) NOT NULL
, Product_Description VARCHAR(255) DEFAULT 'nessuna descrizione'
, Product_Price DECIMAL(10, 2) NOT NULL
, Category_ID INT 
);

-- commento per prove in corso di scrittura 
-- DROP TABLE Product; 
-- SELECT *
-- FROM Product;

-- Crea la tabella CATEGORY con i datatype e qualche contraints, ma senza chiavi

CREATE TABLE IF NOT EXISTS Category (
Category_ID INT NOT NULL 
, Category_Name VARCHAR(30) NOT NULL
, Category_Description VARCHAR(255) DEFAULT 'nessuna descrizione'
);

-- commento per prove in corso di scrittura 
-- DROP TABLE Category; 
-- SELECT *
-- FROM Category;

/* Crea la tabella STATE con i datatype e qualche contraints, ma senza chiavi
Inserisco NOT NULL come constraint di Distribution_Company
perchè assumo che la ToysGroup ha un distributore in ogni paese di questa tabella, visto che in caso contrario, non avrebbe senso una lista di stati */

CREATE TABLE IF NOT EXISTS State (
State_ID INT NOT NULL 
, State_Name VARCHAR(30) NOT NULL
, Distribution_Company VARCHAR(30) NOT NULL 
, Region_ID INT NOT NULL 
);

-- commento per prove in corso di scrittura 
-- DROP TABLE State; 
-- SELECT *
-- FROM State;

-- Crea la tabella Region con i datatype e qualche contraints, ma senza chiavi

CREATE TABLE IF NOT EXISTS Region (
Region_ID INT NOT NULL 
, Region_Name VARCHAR(40) NOT NULL
, Region_Description VARCHAR(255) 
);

-- commento per prove in corso di scrittura 
-- DROP TABLE Region; 
-- SELECT *
-- FROM Region;

-- Crea la tabella SALES con i datatype e qualche contraints, ma senza chiavi

CREATE TABLE IF NOT EXISTS Sales (
Sales_ID INT NOT NULL 
, Product_ID INT NOT NULL 
, State_ID INT NOT NULL 
, Sales_Date DATE NOT NULL 
, Quantity INT NOT NULL
);

-- commento per prove in corso di scrittura 
-- DROP TABLE Sales; 
-- SELECT *
-- FROM Sales;

/* Adesso creo in maniera separata le PK e le FK, per i seguenti motivi:
1. avere un nome che le identifica in SQL
2. avere la possibilità di creare eventualmente chiavi primarie composite (non è questo il caso ovviamente)
3. best practice visto che di solito prima si creano le tabelle e dopo si aggiungono le key
*/

-- Prima aggiungo le 5 PK per le 5 tabelle

ALTER TABLE Product
ADD CONSTRAINT PK_Product PRIMARY KEY (Product_ID);

ALTER TABLE Category
ADD CONSTRAINT PK_Category PRIMARY KEY (Category_ID);

ALTER TABLE State
ADD CONSTRAINT PK_State PRIMARY KEY (State_ID);

ALTER TABLE Region
ADD CONSTRAINT PK_Region PRIMARY KEY (Region_ID);

ALTER TABLE Sales
ADD CONSTRAINT PK_Sales PRIMARY KEY (Sales_ID);

-- Adesso aggiungo 4 FK nelle 3 tabelle figlie

ALTER TABLE Product
ADD CONSTRAINT FK_Product_Category
FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID);

ALTER TABLE State
ADD CONSTRAINT FK_State_Region 
FOREIGN KEY (Region_ID) REFERENCES Region(Region_ID);

ALTER TABLE Sales
ADD CONSTRAINT FK_Sales_Product
FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
ADD CONSTRAINT FK_Sales_State
FOREIGN KEY (State_ID) REFERENCES State(State_ID);

-- Inizio a popolare le tabelle madri, Category

DESCRIBE Category; -- promemoria per preparare l'INSERT

INSERT INTO Category 
VALUES ( 1, 'Action Figures', 'Riproduzioni di supereroi e personaggi film'),
( 2, 'Bambole e Accessori', 'Bambole e accessori vari'),
( 3, 'Costruzioni', 'Blocchi e set di costruzione'),
( 4, 'Costumi', 'Costumi e accessori per travestimenti'),
( 5, 'Giocattoli Interattivi', 'Robot e giochi elettronici interattivi'),
( 6, 'Giocattoli Musicali', 'Mini strumenti musicali'),
( 7, 'Giochi all’Aperto', 'Giochi sportivi e d’acqua'),
( 8, 'Giochi Creativi', 'Kit di disegno e modellazione'),
( 9, 'Giochi di Ruolo', 'Manuali ed accessori per  giochi di ruolo'),
( 10, 'Giochi di Società', 'Giochi di carte e da tavolo'),
( 11, 'Giochi Prima Infanzia', 'Giochi per bambini sotto i 3 anni'),
( 12, 'Kit Scienza', 'Kit di esperimenti scientifici'),
( 13, 'Logica e Rompicapi', 'Giochi di logica e sfide mentali'),
( 14, 'Puzzle', 'Puzzle classici, tematici, 3D e giganti'),
( 15, 'Veicoli Giocattolo', 'Macchine, treni, aerei giocattolo');

-- commento per prove in corso di scrittura 
/*SELECT *
FROM Category;

DELETE FROM Category 
WHERE Category_ID =2 ;*/

-- Popolo altra tabella madre Region

DESCRIBE Region;  -- promemoria per preparare l'INSERT

INSERT INTO Region
VALUES ( 1, 'Resto del mondo', ' Regioni rimanenti fuori dalle aree principali'),
( 2, 'Europa Occidentale e Meridionale', ' Paesi lungo l’Atlantico, Mediterraneo e Pirenei'),
( 3, 'Europa Orientale e Settentrionale', ' Territori verso l’Europa dell’Est e l’Artico'),
( 4, 'America del Nord e Centrale', ' Zone tropicali tra Oceano Atlantico e Pacifico e l’Artico'),
( 5, 'Sud America', ' Paesi dal Rio delle Amazzoni alle Ande'),
( 6, 'Medio Oriente e Nord Africa', ' Aree arabe e deserti tra Mar Rosso e Sahara'),
( 7, 'Asia orientale', ' Regioni tra Oceano Pacifico e catene montuose dell’Asia'),
( 8, 'Sud Est asiatico', ' Paesi tropicali e arcipelaghi sud-orientali asiatici'),
( 9, 'Asia meridionale', ' Terre tra l’Himalaya e l’Oceano Indiano');

-- commento per prove in corso di scrittura 
/*SELECT *
FROM Region;

DELETE FROM Region 
WHERE Region_ID =2 ;*/

-- Popolo Product 

DESCRIBE Product; -- promemoria per preparare l'INSERT

INSERT INTO Product
VALUES ( 1, ' Aereo Avventura SkyForce ', ' Aereo componibile con elica rotante e pilota ', 27.99, 3),
( 2, ' Dudu il Chiacchierone ', ' Cane interattivo che abbaia e ripete le parole ', 29.9, 5),
( 3, ' Capitano Gladius ', ' Eroe spaziale con jetpack e scudo riflettente ', 38, 1),
( 4, ' Castello Fantasia Costruibile ', NULL, 49, 3),
( 5, ' Cavaliere delle Tenebre ', ' Costume medievale con armatura nera e spada scintillante ', 34.8, 4),
( 6, ' Cavallo Magico Arcobaleno ', ' Cavallo giocattolo con criniera colorata e pettinabile ', 17.99, 2),
( 7, ' Cavallo Volante delle Nebbie ', ' Cavallo con ali trasparenti e criniera arcobaleno ', 30.99, 2),
( 8, ' Avventuriero della Giungla ', ' Costume con cappello, binocolo e zaino esplorativo ', 26.99, 4),
( 9, ' Costume da Robot Luminante ', ' Abito futuristico con effetti LED e visiera robotica ', 42.5, 4),
( 10, ' Costume Regina delle Fate ', ' Abito incantato con ali trasparenti e dettagli luminosi ', 33.7, 4),
( 11, ' Costume Unicorno delle Stelle ', ' Costume con corno luminoso e coda arcobaleno ', 18.9, 4),
( 12, ' Costume Zorro il Vendicatore ', ' Costume completo di mantello, maschera e spada ', 39.9, 4),
( 13, ' Creazioni di Argilla Magica ', ' Set di argilla colorata che si modella facilmente ', 17.99, 8),
( 14, ' Cyber Scorpion Mecha ', ' Scorpione robotico con pinze e coda articolata ', 42.9, 1),
( 15, ' Delfino Parlante Splashy ', ' Delfino che canta, parla e spruzza acqua ', 37.5, 5),
( 16, ' Detective del Mistero Junior ', ' Kit investigativo per risolvere misteri con indizi nascosti ', 27.5, 9),
( 17, ' Detective del Mistero Pro ', ' Set investigativo avanzato con strumenti e lenti ', 45, 9),
( 18, ' Drago di Fuoco Zargoth ', ' Drago articolato che sputa "fuoco" con effetti luminosi ', 35.5, 1),
( 19, ' Fata dei Fiori Incantati ', ' Fata con ali scintillanti e bacchetta magica ', 21.75, 2),
( 20, ' Fata delle Stelle Cadenti ', ' Bambola fatata con ali luminose e bastone magico ', 25, 2),
( 21, ' Fattoria Parlante Deluxe ', ' Una fattoria con suoni realistici e animali che parlano ', 100, 5),
( 22, ' Frisbee Fluorescente ', ' Frisbee che si illumina al buio per giochi serali ', 12.75, 7),
( 23, ' Guerriero Drago di Metallo ', ' Personaggio guerriero con armatura da drago e spada ', 47.99, 1),
( 24, ' Gufo della Notte GuGu ', ' Gufo che risponde ai comandi e canta ninne nanne ', 32.75, 5),
( 25, ' Il Castello dei Cavalieri ', ' Set medievale con cavalieri, torri e creature fantastiche ', 38.99, 9),
( 26, ' Kit Collage Arcobaleno ', ' Kit con carte, glitter e adesivi per collage creativi ', 15.99, 8),
( 27, ' Kit di Pittura Magica ', ' Kit di pittura con colori che cambiano al tocco della luce ', 18.99, 8),
( 28, ' Kit di Scultura Arcobaleno ', ' Kit per creare piccole sculture colorate ', 19.99, 8),
( 29, ' Kit Super Chef da Cucina ', ' Set con piatti e ingredienti finti per piccoli chef ', 22.99, 9),
( 30, ' Magiche Bambole dei Ghiacci ', ' Bambole con abiti invernali e accessori brillanti ', 29.9, 2),
( 31, ' Mega Treno dei Colori ', ' Treno componibile dai colori vivaci con rotaie modulari ', 37.5, 3),
( 32, ' Navicella Spaziale Stellare ', ' Veicolo spaziale con moduli di assemblaggio intercambiabili ', 45.99, 3),
( 33, ' Ninja Shadow Deluxe ', ' Ninja con armi intercambiabili e movimenti realistici ', 29.99, 1),
( 34, ' Panda Magico Parlante ', ' Panda interattivo che racconta storie e canta ', 35.99, 5),
( 35, ' Pirata Nave della Tempesta ', ' Nave dei pirati con vele e tesoro nascosto ', 39.99, 9),
( 36, ' Pirata dei Sette Mari Set ', NULL, 25.99, 9),
( 37, ' Pittura Sabbiosa Colorata ', ' Kit con sabbie colorate per creare quadri artistici ', 14.5, 8),
( 38, ' Principessa delle Onde ', ' Bambola sirena con pinna colorata e perline luccicanti ', 22.8, 2),
( 39, ' Regno delle Fate Incantate ', ' Set di fate, castello e personaggi magici ', 28.5, 9),
( 40, ' Regno Incantato ', ' Gioco da tavolo con personaggi fiabeschi e sfide magiche ', 26.99, 10),
( 41, ' RoboGufo Parlatore ', ' Gufo interattivo che ripete le parole e canta canzoni ', 29.99, 5),
( 42, ' RoboWarrior 3000 ', ' Un potente robot da combattimento con luci e suoni ', 49.9, 1),
( 43, ' Sabbia Scintillante DIY ', NULL, 16.99, 8),
( 44, ' Set Baseball Soft ', ' Set baseball con palla morbida e mazza sicura ', 22.9, 7),
( 45, ' Set Bowling da Giardino ', ' Un set da bowling per sfide all’aperto con birilli colorati ', 27.5, 7),
( 46, ' Set di Astronauti Spaziali ', ' Set di astronauti e navicelle per esplorazioni spaziali ', 31, 9),
( 47, ' Set Mini Golf Safari ', ' Un set di mini golf per avventure all’aperto ', 35.9, 7),
( 48, ' Set Tennis da Giardino ', ' Set di mini racchette e rete per giocare all’aperto ', 19.99, 7),
( 49, ' Stazione di Polizia Deluxe ', ' Set per costruire una stazione completa con veicoli e poliziotti ', 39.9, 3),
( 50, ' Super Penne 3D ', NULL, 29.99, 8),
( 51, ' Super Robot Guerriero X ', ' Robot con armature intercambiabili e armi luminose ', 55, 1),
( 52, ' Supereroe Fulmine Mascherato ', ' Costume completo di maschera e mantello per missioni eroiche ', 24.99, 4),
( 53, ' Tigrotto Danzante ', NULL, 31.5, 5),
( 54, ' Tigrotto Safari  ', ' Tigrotto parlante che racconta storie e suona la giungla ', 34.9, 5),
( 55, ' Torre dei Cavalieri ', ' Costruisci una torre medievale con accessori per battaglie ', 41.99, 3),
( 56, ' Torre dei Draghi ', ' Set di costruzioni per creare una torre abitata da draghi ', 32, 3),
( 57, ' Torre di Tiro all’Anello ', ' Gioco da giardino con anelli e torre bersaglio ', 16.5, 7),
( 58, ' Tromba Jazz Junior ', ' Tromba per piccoli musicisti con effetti sonori ', 24.99, 6),
( 59, 'Aereo Avventura SkyForce', ' Aereo componibile con elica rotante e pilota.', 19.99, 3),
( 60, 'Batteria Piccolo Rocker', ' Set di batteria giocattolo per musicisti', 29.99, 6),
( 61, 'Bicicletta 2024', 'Bicicletta', 120, NULL),
( 62, 'Bicicletta 2025', 'Bicicletta fantastica', 125, NULL),
( 63, 'Dudu il Chiacchierone', ' Cane interattivo che abbaia e ripete le parole.', 49.9, 5),
( 64, 'Capitano Gladius', ' Eroe spaziale con jetpack e scudo riflettente.', 16.99, 1),
( 65, 'Cavaliere delle Tenebre', ' Costume medievale con armatura nera e spada scintillante.', 35.5, 4),
( 66, 'Cavallo Volante delle Nebbie', ' Cavallo con ali trasparenti e criniera arcobaleno.', 47.99, 2),
( 67, 'Costume Avventuriero della Giungla', ' Costume con cappello, binocolo e zaino esplorativo.', 31.5, 4),
( 68, 'Costume da Robot Luminante', ' Abito futuristico con effetti LED e visiera robotica.', 49.9, 4),
( 69, 'Costume Unicorno delle Stelle', ' Costume con corno luminoso e coda arcobaleno.', 27.5, 4),
( 70, 'Costume Zorro il Vendicatore', ' Costume completo di mantello, maschera e spada.', 32.75, 4),
( 71, 'Creazioni di Argilla Magica', ' Set di argilla colorata che si modella facilmente.', 38.7, 8),
( 72, 'Cubo Sonaglio della Foresta', ' Cubo con sonagli e animali della foresta.', 30.99, 11),
( 73, 'Cyber Scorpion Mecha', ' Scorpione robotico con pinze e coda articolata.', 29.99, 1),
( 74, 'Delfino Parlante Splashy', ' Delfino che canta, parla e spruzza acqua.', 29.99, 5),
( 75, 'Detective del Mistero Pro', ' Set investigativo avanzato con strumenti e lenti.', 32.75, 9),
( 76, 'Elicottero Soccorso Aereo', ' Elicottero con elica e gancio di salvataggio.', 34.8, 15),
( 77, 'Esperimenti Chimica Junior', ' Kit chimico sicuro con esperimenti facili e divertenti.', 37.5, 12),
( 78, 'Fata dei Fiori Incantati', ' Fata con ali scintillanti e bacchetta magica.', 17.99, 2),
( 79, 'Fata delle Stelle Cadenti', ' Bambola fatata con ali luminose e bastone magico.', 34.9, 2),
( 80, 'Frisbee Fluorescente', ' Frisbee che si illumina al buio per giochi serali.', 29.99, 7),
( 81, 'Gioco delle Fiabe', ' Gioco di carte che riporta alle fiabe classiche.', 31.5, 10),
( 82, 'Guerriero Drago', ' Personaggio guerriero con armatura da drago e spada.', 120, 1),
( 83, 'Guerriero Spaziale K-5', ' Eroe intergalattico con casco e pistola laser.', 29.99, 1),
( 84, 'Gufo della Notte GuGu', ' Gufo che risponde ai comandi e canta ninne nanne.', 35.5, 5),
( 85, 'Il Mondo degli Animali', ' Gioco educativo sui vari habitat e animali del mondo.', 28.5, 10),
( 86, 'Il Mondo Marino', ' Avventura sottomarina con carte e missioni acquatiche.', 30, 10),
( 87, 'Kit Collage Arcobaleno', ' Kit con carte, glitter e adesivi per collage creativi.', 42.9, 8),
( 88, 'Kit di Scultura Arcobaleno', ' Kit per creare piccole sculture colorate.', 37.5, 8),
( 89, 'Kit Ecosistema del Bosco', ' Kit per scoprire flora e fauna dei boschi.', 45.99, 12),
( 90, 'Kit Super Chef da Cucina', ' Set con piatti e ingredienti finti per piccoli chef.', 47.99, 9),
( 91, 'Libro Sonoro di Animali', ' Libro che emette suoni di animali al tocco.', 21.75, 11),
( 92, 'Magiche Bambole dei Ghiacci', ' Bambole con abiti invernali e accessori brillanti.', 14.5, 2),
( 93, 'Maracas del Tropico', ' Maracas colorate con suoni ispirati alla natura.', 26.99, 6),
( 94, 'Mini Microscopio Colorato', ' Microscopio giocattolo con vetrini colorati.', 49, 12),
( 95, 'Miniskate', 'Un piccolo skateboard', 20, NULL),
( 96, 'Nave dei Pompieri', ' Nave giocattolo con pompa per spegnere gli incendi.', 39.9, 15),
( 97, 'Panda Magico Parlante', ' Panda interattivo che racconta storie e canta.', 34.8, 5),
( 98, 'Pennelli acquatici', ' Pennelli che cambiano colore a contatto con l’acqua ', 9.99, 8),
( 99, 'Pennelli Magici', ' Pennelli che cambiano colore a contatto con l’acqua.', 47.99, 8),
( 100, 'Pirata Nave della Tempesta', ' Nave dei pirati con vele e tesoro nascosto.', 39.9, 9),
( 101, 'Pittura Sabbiosa Colorata', ' Kit con sabbie colorate per creare quadri artistici.', 55, 8),
( 102, 'Ponte del Drago', ' Set per costruire un ponte sorvegliato da draghi.', 29.9, 3),
( 103, 'Principessa delle Onde', ' Bambola sirena con pinna colorata e perline luccicanti.', 15.99, 2),
( 104, 'Puzzle della Città Notturna', ' Puzzle di una città illuminata con dettagli realistici.', 28.9, 14),
( 105, 'Puzzle della Foresta Magica', ' Puzzle con animali e alberi incantati della foresta.', 39.9, 14),
( 106, 'Puzzle della Giungla Tropicale', ' Puzzle di animali tropicali in una giungla vivace.', 41.99, 14),
( 107, 'Puzzle Tangram Arcobaleno', NULL, 27.99, 13),
( 108, 'Regno delle Fate Incantate', ' Set di fate, castello e personaggi magici.', 29.9, 9),
( 109, 'Saxofono della Giungla', ' Sax giocattolo che emette suoni ispirati alla natura.', 55, 6),
( 110, 'Scenario ballo debuttanti', 'Fondale per balli', 99, NULL),
( 111, 'Scenario escape room', 'Fondale per fughe', 80, NULL),
( 112, 'Set Baseball Soft', NULL, 34.9, 7),
( 113, 'Set di Astronauti Spaziali', ' Set di astronauti e navicelle per esplorazioni spaziali.', 24.99, 9),
( 114, 'Set Mini Golf Safari', ' Un set di mini golf per avventure all’aperto.', 29.99, 7),
( 115, 'Set Tennis da Giardino', ' Set di mini racchette e rete per giocare all’aperto.', 42, 7),
( 116, 'Sfida dei Colori', ' Gioco di abbinamento colori con sfide a tempo.', 29.9, 10),
( 117, 'Skateboard 3000', 'Uno skateboard futuristico', 49, NULL),
( 118, 'Stazione di Polizia Deluxe', ' Set per costruire una stazione completa con veicoli e poliziotti.', 38.99, 3),
( 119, 'Sudoku degli Animali', ' Sudoku a tema animale per giovani solutori.', 32, 13),
( 120, 'Super Detective Junior', ' Gioco di investigazione con enigmi e missioni da risolvere.', 17.99, 10),
( 121, 'Super Racer Rossa', ' Auto da corsa rossa con turbo a retrocarica.', 42.5, 15),
( 122, 'Super Robot Guerriero X', ' Robot con armature intercambiabili e armi luminose.', 18.99, 1),
( 123, 'Tigrotto Danzante', ' Tigrotto che danza e ripete canzoni.', 42.5, 5),
( 124, 'Torre a Incastro Arcobaleno', ' Torre in legno colorato da impilare.', 22.8, 11),
( 125, 'Torre dei Cavalieri', ' Costruisci una torre medievale con accessori per battaglie.', 37.5, 3),
( 126, 'Torre dei Draghi', ' Set di costruzioni per creare una torre abitata da draghi.', 9.99, 3),
( 127, 'Torre di Tiro all’Anello', ' Gioco da giardino con anelli e torre bersaglio.', 35.5, 7),
( 128, 'Torre Matematica', ' Torre di blocchi da impilare in base a operazioni matematiche.', 28, 13),
( 129, 'Tromba Jazz Junior', ' Tromba per piccoli musicisti con effetti sonori.', 39.9, 6),
( 130, 'Violino delle Fate', ' Violino con melodie dolci e luci fatate.', 38.7, 6);

-- commento per prove in corso di scrittura 
/* SELECT *
FROM Product;

DELETE FROM Product
WHERE Product_ID =3 ;*/

-- Popolo la tabella State

DESCRIBE State; -- promemoria per preparare l'INSERT

INSERT INTO State
VALUE ( 1, 'Italia', 'ToysGroup', 2),
( 2, 'Nuova Zelanda', ' KiwiToys Ltd.', 1),
( 3, 'Russia', ' SmilesKatyushia', 1),
( 4, 'Sud Africa', ' PlaySA', 1),
( 5, 'Austria', ' WunderKinder Spielwaren', 2),
( 6, 'Francia', ' Petit Jouet', 2),
( 7, 'Germania', ' KinderKraft', 2),
( 8, 'Paesi Bassi', ' Dutch Playhouse', 2),
( 9, 'Portogallo', ' Brinquedos Lusos', 2),
( 10, 'Regno Unito', ' BritToys', 2),
( 11, 'Spagna', 'ToysGroup', 2),
( 12, 'Svizzera', 'ToysGroup', 2),
( 13, 'Danimarca', ' Viking Toys', 3),
( 14, 'Finlandia', ' JoyFin Toys', 3),
( 15, 'Norvegia', ' NorsePlay', 3),
( 16, 'Polonia', ' Zabawa Polska', 3),
( 17, 'Repubblica Ceca', ' Hračka CZ', 3),
( 18, 'Romania', ' Jocuri Românesc', 3),
( 19, 'Slovacchia', ' SlovakToys', 3),
( 20, 'Svezia', ' SvenskLek', 3),
( 21, 'Ungheria', ' MagyToys', 3),
( 22, 'Canada', ' MapleKids', 4),
( 23, 'Messico', ' Juguetes Azteca', 4),
( 24, 'Stati Uniti', ' Fun Nation', 4),
( 25, 'Costa Rica', ' Juguetico', 4),
( 26, 'Giamaica', ' Island Toys', 4),
( 27, 'Panama', ' PanPlay', 4),
( 28, 'Repubblica Dominicana', ' DominiPlay', 4),
( 29, 'Argentina', ' Juguetes del Sur', 5),
( 30, 'Brasile', ' Brinca Brasil', 5),
( 31, 'Cile', ' AndesPlay', 5),
( 32, 'Colombia', ' RisaToys', 5),
( 33, 'Perù', ' Juguetes Inca', 5),
( 34, 'Arabia Saudita', ' Toy Oasis', 6),
( 35, 'Egitto', ' Pharaoh Play', 6),
( 36, 'Emirati Arabi Uniti', ' DuneToys', 6),
( 37, 'Israele', ' PlayKids IL', 6),
( 38, 'Libano', ' Cedars of Play', 6),
( 39, 'Marocco', ' AtlasToys', 6),
( 40, 'Cina', ' Panda Toys', 7),
( 41, 'Corea del Sud', ' HanToys', 7),
( 42, 'Giappone', ' NipponPlay', 7),
( 43, 'Hong Kong', ' HarborToys', 7),
( 44, 'Indonesia', ' BaliPlay', 8),
( 45, 'Malesia', ' MalayKids', 8),
( 46, 'Singapore', ' LionToys', 8),
( 47, 'Thailandia', ' SiamPlay', 8),
( 48, 'Vietnam', ' Lotus Toys', 8),
( 49, 'Bangladesh', ' DhakaFun', 9),
( 50, 'India', ' Bharat Toys', 9),
( 51, 'Pakistan', ' PakKids', 9),
( 52, 'Sri Lanka', ' Ceylon Joy', 9);

-- commento per prove in corso di scrittura 
/*  SELECT *
FROM State;

DELETE FROM State
WHERE State_ID =3 ;*/

-- Popolo l'ultima tabella Sales

DESCRIBE Sales; -- promemoria per preparare l'INSERT

INSERT INTO Sales
VAlUE ( 1, 12, 44, '2020-01-01', 241 ),
( 2, 45, 51, '2020-01-04', 192 ),
( 3, 25, 13, '2020-01-08', 216 ),
( 4, 6, 47, '2020-01-10', 10 ),
( 5, 100, 1, '2020-01-12', 42 ),
( 6, 4, 35, '2020-01-15', 25 ),
( 7, 89, 45, '2020-01-20', 198 ),
( 8, 47, 1, '2020-01-22', 174 ),
( 9, 130, 24, '2020-01-23', 153 ),
( 10, 21, 36, '2020-01-30', 25 ),
( 11, 107, 20, '2020-01-30', 169 ),
( 12, 32, 5, '2020-01-31', 95 ),
( 13, 48, 30, '2020-01-31', 86 ),
( 14, 84, 36, '2020-02-01', 259 ),
( 15, 31, 22, '2020-02-04', 260 ),
( 16, 1, 46, '2020-02-05', 260 ),
( 17, 54, 39, '2020-02-09', 189 ),
( 18, 95, 11, '2020-02-17', 192 ),
( 19, 81, 42, '2020-02-17', 30 ),
( 20, 64, 15, '2020-02-17', 12 ),
( 21, 81, 7, '2020-02-20', 251 ),
( 22, 107, 4, '2020-02-21', 201 ),
( 23, 75, 21, '2020-03-02', 1 ),
( 24, 9, 11, '2020-03-13', 125 ),
( 25, 77, 1, '2020-03-17', 215 ),
( 26, 5, 11, '2020-03-20', 129 ),
( 27, 109, 6, '2020-03-22', 249 ),
( 28, 78, 16, '2020-03-24', 47 ),
( 29, 14, 23, '2020-04-15', 13 ),
( 30, 41, 1, '2020-04-19', 261 ),
( 31, 22, 1, '2020-04-19', 62 ),
( 32, 51, 32, '2020-04-21', 237 ),
( 33, 86, 32, '2020-04-23', 160 ),
( 34, 61, 1, '2020-04-29', 217 ),
( 35, 46, 29, '2020-05-01', 155 ),
( 36, 48, 34, '2020-05-04', 183 ),
( 37, 99, 29, '2020-05-10', 213 ),
( 38, 75, 4, '2020-05-14', 220 ),
( 39, 42, 36, '2020-05-14', 161 ),
( 40, 124, 39, '2020-05-15', 105 ),
( 41, 115, 48, '2020-05-23', 107 ),
( 42, 92, 47, '2020-05-25', 116 ),
( 43, 39, 36, '2020-05-27', 193 ),
( 44, 52, 14, '2020-06-02', 157 ),
( 45, 9, 41, '2020-06-08', 139 ),
( 46, 4, 1, '2020-06-09', 28 ),
( 47, 86, 18, '2020-06-11', 142 ),
( 48, 130, 52, '2020-06-25', 135 ),
( 49, 95, 32, '2020-07-09', 204 ),
( 50, 68, 19, '2020-07-23', 105 ),
( 51, 6, 12, '2020-07-23', 155 ),
( 52, 53, 33, '2020-08-16', 71 ),
( 53, 7, 41, '2020-08-19', 274 ),
( 54, 36, 9, '2020-08-26', 155 ),
( 55, 121, 20, '2020-08-30', 213 ),
( 56, 27, 11, '2020-09-05', 13 ),
( 57, 107, 1, '2020-09-07', 21 ),
( 58, 56, 19, '2020-09-15', 287 ),
( 59, 63, 40, '2020-09-24', 214 ),
( 60, 44, 24, '2020-09-24', 48 ),
( 61, 6, 52, '2020-09-26', 273 ),
( 62, 48, 21, '2020-09-30', 258 ),
( 63, 104, 42, '2020-10-30', 36 ),
( 64, 65, 41, '2020-11-01', 52 ),
( 65, 41, 14, '2020-11-21', 236 ),
( 66, 86, 3, '2020-12-01', 7 ),
( 67, 97, 18, '2020-12-05', 154 ),
( 68, 68, 18, '2020-12-05', 287 ),
( 69, 95, 30, '2020-12-08', 202 ),
( 70, 95, 30, '2020-12-08', 18 ),
( 71, 27, 2, '2020-12-12', 274 ),
( 72, 16, 2, '2020-12-16', 102 ),
( 73, 31, 1, '2020-12-16', 5 ),
( 74, 34, 3, '2020-12-28', 21 ),
( 75, 44, 21, '2020-12-29', 107 ),
( 76, 20, 14, '2020-12-31', 168 ),
( 77, 28, 18, '2021-01-01', 279 ),
( 78, 39, 16, '2021-01-04', 119 ),
( 79, 21, 14, '2021-01-05', 63 ),
( 80, 92, 50, '2021-01-19', 197 ),
( 81, 7, 31, '2021-01-20', 207 ),
( 82, 50, 50, '2021-01-29', 30 ),
( 83, 44, 40, '2021-02-01', 226 ),
( 84, 57, 45, '2021-02-03', 193 ),
( 85, 79, 14, '2021-02-08', 197 ),
( 86, 105, 29, '2021-02-10', 212 ),
( 87, 64, 5, '2021-02-10', 7 ),
( 88, 2, 35, '2021-02-11', 45 ),
( 89, 58, 29, '2021-02-11', 28 ),
( 90, 63, 19, '2021-02-22', 6 ),
( 91, 35, 24, '2021-03-07', 60 ),
( 92, 91, 39, '2021-03-10', 225 ),
( 93, 16, 28, '2021-03-14', 57 ),
( 94, 25, 48, '2021-03-18', 50 ),
( 95, 130, 24, '2021-03-20', 134 ),
( 96, 9, 34, '2021-03-28', 266 ),
( 97, 129, 5, '2021-03-31', 18 ),
( 98, 26, 14, '2021-04-04', 210 ),
( 99, 9, 19, '2021-04-08', 12 ),
( 100, 16, 1, '2021-04-16', 210 ),
( 101, 81, 3, '2021-04-24', 215 ),
( 102, 51, 11, '2021-04-26', 42 ),
( 103, 6, 14, '2021-05-18', 214 ),
( 104, 118, 16, '2021-05-19', 162 ),
( 105, 36, 10, '2021-06-03', 285 ),
( 106, 19, 41, '2021-06-14', 58 ),
( 107, 34, 11, '2021-06-18', 110 ),
( 108, 14, 16, '2021-06-25', 254 ),
( 109, 107, 51, '2021-06-25', 25 ),
( 110, 47, 46, '2021-06-27', 117 ),
( 111, 74, 3, '2021-07-03', 201 ),
( 112, 111, 11, '2021-07-05', 144 ),
( 113, 56, 36, '2021-07-09', 283 ),
( 114, 101, 3, '2021-07-09', 155 ),
( 115, 64, 22, '2021-07-12', 113 ),
( 116, 48, 1, '2021-07-19', 132 ),
( 117, 44, 52, '2021-07-29', 162 ),
( 118, 10, 33, '2021-08-02', 65 ),
( 119, 30, 1, '2021-08-03', 248 ),
( 120, 112, 26, '2021-08-06', 211 ),
( 121, 112, 41, '2021-08-20', 157 ),
( 122, 73, 9, '2021-08-21', 52 ),
( 123, 75, 29, '2021-08-23', 249 ),
( 124, 74, 44, '2021-09-01', 205 ),
( 125, 83, 24, '2021-09-10', 89 ),
( 126, 84, 26, '2021-09-10', 109 ),
( 127, 62, 18, '2021-09-11', 92 ),
( 128, 83, 11, '2021-09-15', 256 ),
( 129, 10, 26, '2021-09-18', 127 ),
( 130, 121, 50, '2021-09-20', 143 ),
( 131, 56, 8, '2021-09-23', 14 ),
( 132, 6, 3, '2021-09-23', 68 ),
( 133, 35, 14, '2021-10-11', 287 ),
( 134, 27, 31, '2021-10-29', 73 ),
( 135, 119, 2, '2021-11-08', 23 ),
( 136, 49, 16, '2021-11-08', 203 ),
( 137, 83, 17, '2021-12-03', 182 ),
( 138, 9, 35, '2021-12-06', 4 ),
( 139, 95, 26, '2022-01-03', 264 ),
( 140, 25, 17, '2022-01-07', 281 ),
( 141, 84, 24, '2022-01-10', 100 ),
( 142, 1, 28, '2022-01-11', 116 ),
( 143, 109, 51, '2022-02-06', 111 ),
( 144, 62, 26, '2022-02-12', 67 ),
( 145, 44, 3, '2022-02-21', 133 ),
( 146, 11, 16, '2022-02-26', 200 ),
( 147, 34, 24, '2022-02-28', 73 ),
( 148, 77, 3, '2022-03-08', 189 ),
( 149, 93, 51, '2022-03-11', 298 ),
( 150, 120, 24, '2022-03-17', 205 ),
( 151, 45, 32, '2022-03-17', 288 ),
( 152, 125, 7, '2022-03-29', 218 ),
( 153, 114, 1, '2022-04-14', 286 ),
( 154, 99, 29, '2022-04-15', 234 ),
( 155, 64, 52, '2022-04-18', 87 ),
( 156, 77, 42, '2022-04-20', 107 ),
( 157, 16, 19, '2022-04-20', 16 ),
( 158, 86, 46, '2022-04-25', 107 ),
( 159, 5, 15, '2022-05-12', 200 ),
( 160, 46, 45, '2022-05-13', 206 ),
( 161, 107, 11, '2022-05-16', 267 ),
( 162, 56, 47, '2022-05-18', 168 ),
( 163, 69, 20, '2022-05-20', 72 ),
( 164, 75, 52, '2022-05-26', 16 ),
( 165, 81, 15, '2022-05-27', 140 ),
( 166, 106, 15, '2022-05-31', 84 ),
( 167, 62, 10, '2022-06-02', 204 ),
( 168, 121, 52, '2022-06-04', 78 ),
( 169, 92, 6, '2022-06-10', 197 ),
( 170, 121, 35, '2022-06-10', 268 ),
( 171, 127, 48, '2022-06-18', 127 ),
( 172, 3, 21, '2022-06-20', 173 ),
( 173, 84, 28, '2022-06-26', 254 ),
( 174, 87, 21, '2022-07-16', 94 ),
( 175, 75, 26, '2022-07-17', 164 ),
( 176, 45, 5, '2022-07-18', 203 ),
( 177, 100, 27, '2022-07-27', 111 ),
( 178, 78, 28, '2022-08-02', 290 ),
( 179, 75, 17, '2022-08-19', 19 ),
( 180, 82, 50, '2022-08-20', 84 ),
( 181, 99, 28, '2022-08-21', 285 ),
( 182, 36, 1, '2022-08-23', 220 ),
( 183, 68, 7, '2022-08-24', 171 ),
( 184, 4, 41, '2022-09-07', 165 ),
( 185, 125, 29, '2022-09-11', 251 ),
( 186, 115, 6, '2022-09-13', 115 ),
( 187, 81, 42, '2022-09-13', 218 ),
( 188, 10, 48, '2022-09-14', 278 ),
( 189, 33, 11, '2022-09-17', 141 ),
( 190, 47, 51, '2022-09-23', 125 ),
( 191, 113, 40, '2022-09-23', 234 ),
( 192, 112, 2, '2022-10-07', 285 ),
( 193, 99, 50, '2022-10-07', 128 ),
( 194, 86, 12, '2022-10-24', 260 ),
( 195, 36, 42, '2022-10-30', 190 ),
( 196, 36, 26, '2022-11-05', 48 ),
( 197, 36, 26, '2022-11-05', 102 ),
( 198, 7, 18, '2022-11-14', 78 ),
( 199, 5, 51, '2022-11-17', 64 ),
( 200, 12, 47, '2022-11-18', 113 ),
( 201, 40, 6, '2022-11-21', 228 ),
( 202, 111, 6, '2022-11-21', 172 ),
( 203, 57, 7, '2022-11-25', 265 ),
( 204, 122, 11, '2022-11-27', 101 ),
( 205, 101, 10, '2022-12-03', 135 ),
( 206, 46, 18, '2022-12-15', 278 ),
( 207, 129, 11, '2022-12-15', 143 ),
( 208, 8, 17, '2022-12-15', 8 ),
( 209, 85, 38, '2023-01-18', 128 ),
( 210, 42, 46, '2023-01-19', 274 ),
( 211, 36, 2, '2023-01-30', 19 ),
( 212, 26, 2, '2023-01-30', 116 ),
( 213, 59, 31, '2023-01-31', 294 ),
( 214, 97, 45, '2023-02-04', 224 ),
( 215, 42, 15, '2023-02-06', 45 ),
( 216, 124, 9, '2023-02-10', 120 ),
( 217, 27, 11, '2023-02-12', 35 ),
( 218, 25, 9, '2023-03-01', 139 ),
( 219, 8, 30, '2023-03-02', 260 ),
( 220, 86, 6, '2023-03-11', 230 ),
( 221, 82, 6, '2023-03-13', 133 ),
( 222, 76, 46, '2023-03-14', 44 ),
( 223, 48, 1, '2023-03-20', 105 ),
( 224, 125, 40, '2023-03-24', 39 ),
( 225, 111, 1, '2023-04-07', 26 ),
( 226, 115, 10, '2023-04-07', 78 ),
( 227, 90, 5, '2023-04-09', 148 ),
( 228, 94, 46, '2023-04-12', 29 ),
( 229, 83, 22, '2023-04-16', 107 ),
( 230, 62, 35, '2023-04-21', 264 ),
( 231, 101, 3, '2023-04-26', 49 ),
( 232, 126, 36, '2023-05-08', 264 ),
( 233, 8, 20, '2023-05-14', 40 ),
( 234, 102, 17, '2023-05-14', 210 ),
( 235, 73, 14, '2023-05-16', 234 ),
( 236, 67, 3, '2023-06-23', 125 ),
( 237, 106, 30, '2023-07-04', 229 ),
( 238, 59, 32, '2023-07-08', 179 ),
( 239, 62, 14, '2023-07-10', 16 ),
( 240, 36, 32, '2023-07-19', 57 ),
( 241, 98, 12, '2023-07-23', 95 ),
( 242, 5, 26, '2023-07-23', 110 ),
( 243, 15, 36, '2023-07-23', 169 ),
( 244, 109, 23, '2023-07-26', 114 ),
( 245, 69, 47, '2023-07-27', 155 ),
( 246, 72, 47, '2023-08-05', 218 ),
( 247, 16, 9, '2023-08-08', 75 ),
( 248, 54, 33, '2023-08-08', 75 ),
( 249, 77, 8, '2023-08-08', 17 ),
( 250, 109, 28, '2023-08-11', 78 ),
( 251, 32, 8, '2023-08-20', 254 ),
( 252, 19, 7, '2023-08-20', 17 ),
( 253, 14, 31, '2023-08-24', 87 ),
( 254, 104, 17, '2023-09-02', 195 ),
( 255, 76, 17, '2023-09-02', 240 ),
( 256, 86, 11, '2023-09-03', 97 ),
( 257, 129, 15, '2023-09-06', 42 ),
( 258, 103, 33, '2023-09-08', 250 ),
( 259, 16, 4, '2023-09-08', 219 ),
( 260, 122, 21, '2023-09-11', 11 ),
( 261, 33, 3, '2023-09-24', 88 ),
( 262, 37, 2, '2023-09-29', 175 ),
( 263, 49, 16, '2023-10-04', 243 ),
( 264, 110, 33, '2023-10-11', 48 ),
( 265, 82, 28, '2023-10-15', 259 ),
( 266, 105, 20, '2023-10-15', 14 ),
( 267, 102, 45, '2023-10-16', 234 ),
( 268, 107, 12, '2023-10-18', 214 ),
( 269, 66, 9, '2023-10-27', 168 ),
( 270, 116, 8, '2023-11-12', 19 ),
( 271, 126, 26, '2023-11-16', 86 ),
( 272, 61, 42, '2023-11-18', 108 ),
( 273, 25, 33, '2023-12-13', 32 ),
( 274, 129, 26, '2024-01-06', 42 ),
( 275, 129, 43, '2024-01-07', 17 ),
( 276, 84, 1, '2024-01-09', 105 ),
( 277, 128, 23, '2024-01-12', 31 ),
( 278, 64, 14, '2024-01-21', 71 ),
( 279, 32, 2, '2024-01-22', 146 ),
( 280, 114, 12, '2024-01-26', 138 ),
( 281, 21, 31, '2024-02-02', 289 ),
( 282, 106, 44, '2024-02-05', 31 ),
( 283, 73, 28, '2024-02-06', 295 ),
( 284, 65, 23, '2024-02-08', 125 ),
( 285, 12, 12, '2024-02-10', 114 ),
( 286, 39, 1, '2024-02-10', 178 ),
( 287, 10, 1, '2024-02-16', 191 ),
( 288, 38, 41, '2024-02-18', 247 ),
( 289, 35, 4, '2024-02-26', 267 ),
( 290, 81, 45, '2024-03-06', 150 ),
( 291, 103, 7, '2024-03-09', 221 ),
( 292, 113, 1, '2024-03-09', 255 ),
( 293, 11, 1, '2024-03-09', 282 ),
( 294, 8, 32, '2024-03-24', 230 ),
( 295, 115, 5, '2024-03-30', 38 ),
( 296, 52, 10, '2024-04-04', 82 ),
( 297, 21, 11, '2024-04-05', 245 ),
( 298, 19, 4, '2024-04-07', 74 ),
( 299, 61, 15, '2024-04-18', 120 ),
( 300, 15, 22, '2024-04-25', 265 ),
( 301, 128, 35, '2024-04-29', 71 ),
( 302, 111, 51, '2024-05-04', 49 ),
( 303, 58, 41, '2024-05-09', 239 ),
( 304, 68, 50, '2024-05-11', 171 ),
( 305, 117, 35, '2024-06-10', 71 ),
( 306, 27, 44, '2024-06-13', 243 ),
( 307, 2, 23, '2024-06-13', 60 ),
( 308, 46, 10, '2024-06-14', 247 ),
( 309, 23, 23, '2024-06-15', 78 ),
( 310, 15, 23, '2024-06-16', 99 ),
( 311, 25, 26, '2024-06-29', 107 ),
( 312, 93, 6, '2024-07-03', 98 ),
( 313, 85, 35, '2024-07-08', 3 ),
( 314, 100, 29, '2024-07-08', 234 ),
( 315, 130, 16, '2024-07-17', 173 ),
( 316, 94, 7, '2024-07-31', 76 ),
( 317, 29, 30, '2024-08-07', 144 ),
( 318, 6, 29, '2024-08-18', 89 ),
( 319, 104, 10, '2024-08-21', 163 ),
( 320, 130, 39, '2024-08-29', 113 ),
( 321, 97, 1, '2024-08-31', 293 ),
( 322, 53, 9, '2024-09-05', 92 ),
( 323, 121, 22, '2024-09-16', 217 ),
( 324, 10, 48, '2024-09-17', 24 ),
( 325, 43, 29, '2024-09-21', 255 ),
( 326, 113, 19, '2024-09-30', 285 ),
( 327, 116, 17, '2024-10-24', 278 ),
( 328, 93, 19, '2024-10-25', 92 ),
( 329, 80, 39, '2024-10-26', 293 );

-- commento per prove in corso di scrittura 
/* SELECT *
FROM product;

DELETE FROM Sales
WHERE Sales_ID =3; */

/* TASK 4 query 1
Verifica che i campi definiti come PK siano univoci. 
In altre parole, scrivi una query per determinare l'univocità dei valori di ciascuna PK (una query per tabella implementata).*/

-- In pratica verifico che il totale dei records della tabella sia unguale al totale dei records distinti

SELECT 
    COUNT(Product_ID) = COUNT(DISTINCT Product_ID) AS 'Verifica unicità della PK, vera con valore 1'
FROM
    Product;

SELECT 
    COUNT(Category_ID) = COUNT(DISTINCT Category_ID) AS 'Verifica unicità della PK, vera con valore 1'
FROM
    Category;

SELECT 
    COUNT(State_ID) = COUNT(DISTINCT State_ID) AS 'Verifica unicità della PK, vera con valore 1'
FROM
    State;

SELECT 
    COUNT(Region_ID) = COUNT(DISTINCT Region_ID) AS 'Verifica unicità della PK, vera con valore 1'
FROM
    Region;
    
SELECT 
    COUNT(Sales_ID) = COUNT(DISTINCT Sales_ID) AS 'Verifica unicità della PK, vera con valore 1'
FROM
    Sales;
    
/* TASK 4 query 2
Esporre l'elenco delle transazioni indicando nel result set 
il codice documento, la data, il nome del prodotto, la categoria del prodotto, il nome dello stato, il nome della regione di vendita
e un campo booleano valorizzato in base alla condizione che siano passati più di 180 giorni dalla data vendita o meno (>180-> True, <=180 -> False).*/

SELECT 
    sa.Sales_ID AS 'Codice documento di vendita',
    sa.Sales_Date AS 'Data di vendita',
    p.Product_Name AS 'Nome prodotto',
    c.Category_Name AS 'Categoria prodotto',
    st.State_Name AS 'Stato acquirente',
    r.Region_Name AS 'Area geografica',
    IF(DATEDIFF(CURDATE(), sa.Sales_Date) > 180, 'True', 'False') AS 'Passati più di 180 giorni dalla vendita'
FROM
    Sales sa
        LEFT JOIN -- se non usi left perdi records
    Product p ON sa.Product_ID = p.Product_ID
        LEFT JOIN -- se non usi left perdi records
    Category c ON p.Category_ID = c.Category_ID
        LEFT JOIN -- se non usi left perdi records
    State st ON sa.State_ID = st.State_ID
        LEFT JOIN -- se non usi left perdi records
    Region r ON st.Region_ID = r.Region_ID;
    
/* TASK 4 query 3
Esporre l'elenco dei prodotti che hanno venduto, in totale, 
una quantità maggiore della media delle vendite realizzate nell'ultimo anno censito.
Ogni valore della condizione deve risultare da una query e non deve essere inserito a mano.
Nel result set devono comparire solo codice prodotto e totale venduto.*/

SELECT 
    sa.Product_ID AS 'Codice prodotto',
    SUM(sa.Quantity) AS 'Totale venduto sopra la media dell anno corrente'
FROM
    Sales sa
WHERE 
    sa.Sales_Date BETWEEN DATE_FORMAT(CURDATE(), '%Y-01-01') AND CURRENT_DATE()
GROUP BY 
    sa.Product_ID
HAVING 
    SUM(sa.Quantity) > (
        SELECT AVG(venduto2024)
        FROM (
            SELECT SUM(s.Quantity) AS venduto2024
            FROM Sales s
            WHERE s.Sales_Date BETWEEN DATE_FORMAT(CURDATE(), '%Y-01-01') AND CURRENT_DATE()
            GROUP BY s.Product_ID
        ) AS suquery
    );
    
/* TASK 4 query 4
Esporre l'elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.*/

DESCRIBE product;

SELECT 
    p.Product_Name AS 'Nome prodotto',
    SUM(sa.Quantity * p.Product_Price) AS 'Fatturato totale',
    YEAR(sa.Sales_Date) AS Anno
FROM
    Sales sa
        LEFT JOIN
    Product p ON sa.Product_ID = p.Product_ID
GROUP BY p.Product_name , sa.Sales_Date
ORDER BY 'Fatturato totale' DESC , Anno;

/* TASK 4 query 5
Esporre il fatturato totale per stato per anno.
Ordina il risultato per data e per fatturato decrescente*/

SELECT 
    st.State_Name AS Stato,
    SUM(sa.Quantity * p.Product_Price) AS 'Fatturato totale',
    YEAR(sa.Sales_Date) AS Anno
FROM
    Sales sa
        LEFT JOIN
    State st ON sa.State_ID = st.State_ID
        LEFT JOIN
    Product p ON sa.Product_ID = p.Product_ID
GROUP BY st.State_Name , Anno
ORDER BY Anno DESC , 'Fatturato totale' DESC;

/* TASK 4 query 6
Rispondere alla seguente domanda:
Qual è la categoria di articoli maggiormente richiesta dal mercato?*/

SELECT 
    c.Category_Name AS 'Categoria più venduta da ToysGroup'
    , SUM(sa.Quantity) AS Vendite
FROM
    Sales sa
        LEFT JOIN
    Product p ON sa.Product_ID = p.Product_ID
        LEFT JOIN
    Category c ON p.Category_ID = c.Category_ID
    GROUP BY c.Category_Name
    ORDER BY Vendite DESC
    LIMIT 1;
    
    /* TASK 4 query 7
Rispondere alla seguente domanda:
Quali sono sono i prodotti invenduti?
Proponi due approcci risolitivi differenti*/

-- primo approccio mio LEFT JOIN

SELECT 
    p.Product_Name AS 'Prodotti invenduti'
FROM
    Product p
        LEFT JOIN
    Sales s ON p.Product_ID = s.Product_ID
WHERE
    s.Sales_ID IS NULL;

-- secondo approccio SUBQUERY

SELECT 
    p.Product_Name AS 'Prodotti invenduti'
FROM
    Product p
WHERE
    p.Product_ID NOT IN (SELECT 
            s.Product_ID
        FROM
            Sales s);
            
-- In entrambi i casi 12 records. Ho verificato anche che i primi 3 non sono nella tabella vendite (13 - 17 - 18 Product_ID)

/* TASK 4 query 8
Creare una vista sui prodotti in modo tale da esporre una "versione denormalizzata" delle informazioni utili (codice prodotto, nome prodotto, nome categoria).*/
 
 CREATE VIEW Product_Details AS
    SELECT
        p.Product_Name AS Prodotto,
        p.Product_ID AS 'Codice prodotto',
        p.Product_Description AS 'Descrizione prodotto',
        p.Product_Price AS Prezzo,
        c.Category_Name AS Categoria,
        c.Category_Description AS 'Descrizione categoria'
    FROM
        Product p
            LEFT JOIN
        Category c ON p.Category_ID = c.Category_ID
    ORDER BY p.Product_Name;
 
-- per la consultazione e scrittura
 
 -- DROP VIEW Product_Details;
 
SELECT 
    *
FROM
    Product_Details;
    
/* TASK 4 query 9
Creare una vista per le informazioni geografiche.*/

CREATE VIEW  Geo_Info AS
    SELECT 
        r.Region_Name AS 'Areo geografica',
        r.Region_ID AS 'Codice area geografica',
        r.Region_Description AS 'Descrizione area geografica',
        st.State_Name AS Stato,
        st.State_ID AS 'Codice Stato'
    FROM
        Region r
            RIGHT JOIN
        State st ON r.Region_ID = st.Region_ID
    ORDER BY r.Region_ID;
 
 -- per la consultazione e scrittura
 
 -- DROP VIEW geo_Info;
 
SELECT 
    *
FROM
    Geo_Info;