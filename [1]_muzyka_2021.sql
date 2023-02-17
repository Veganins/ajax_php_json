/*==============================================================*/
/*                 BAZA DANYCH PŁYT MUZYCZNYCH         			*/
/*               Opracowanie: Ireneusz Balawender         	    */
/*        ZST Rzeszów - Systemy Zarządzania Bazami Danych       */
/*==============================================================*/
/*==============================================================*/
/*     Skasowanie starej wersji bazy i budowa nowej			    */
/*==============================================================*/
  DROP DATABASE IF EXISTS muzyka2021;
  CREATE DATABASE muzyka2021;
  USE muzyka2021;
/*==============================================================*/
/* Utworzenie nowych tabel					                    */
/*==============================================================*/
CREATE TABLE artysta
(
	id_artysty INT UNSIGNED NOT NULL AUTO_INCREMENT,
	nazwa_artysty TINYTEXT NOT NULL,
	rodzaj_artysty ENUM('Solista', 'Zespół') NOT NULL,
		PRIMARY KEY (id_artysty)
)
Engine=InnoDB DEFAULT CHARACTER SET 'utf8';

CREATE TABLE wydawca
(
	id_wydawcy INT UNSIGNED AUTO_INCREMENT,
	nazwa_wydawcy TINYTEXT NOT NULL,
	adres_wydawcy VARCHAR(50) NOT NULL,
	miasto_wydawcy VARCHAR(45) NOT NULL,
	kraj_wydawcy VARCHAR(25) NOT NULL,
	telefon_wydawcy VARCHAR(15) UNIQUE NOT NULL,
	email_wydawcy varchar(45) UNIQUE NOT NULL,
	www_wydawcy varchar(50) UNIQUE NOT NULL,
		PRIMARY KEY (id_wydawcy)
)
Engine=InnoDB DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci';

CREATE TABLE plyta
(
	id_plyty INT UNSIGNED AUTO_INCREMENT,
	tytul VARCHAR(45) NOT NULL,
	stan INT UNSIGNED NOT NULL,
	data_wyd_org DATE NOT NULL,
	data_wyd_ree DATE,
	nr_reedycji INT UNSIGNED NULL,
	rodzaj ENUM('Dance', 'Rock', 'Blues', 'Pop', 'Jazz', 'Metal', 'Punk', 'Mix', 'Rap') NOT NULL,
	opinia ENUM('Super', 'Bardzo dobra', 'Dobra', 'Przeciętna', 'Mierna', 'Beznadziejna') NOT NULL,
	nosnik ENUM('CD', 'DVD', 'Vinyl', 'Blu-Ray', 'Dystrybucja Cyfrowa') NOT NULL,
	l_nosnikow INT UNSIGNED NOT NULL DEFAULT 1,
	typ_nosnika VARCHAR(16) NOT NULL,
	cena DECIMAL(5,2) NOT NULL DEFAULT 0.00,
	rabat DECIMAL(4,2) NULL,
		PRIMARY KEY (id_plyty),
			id_wydawcy INT UNSIGNED NOT NULL,
				CONSTRAINT plyta_id_wydawcy_fk
				FOREIGN KEY (id_wydawcy)
				REFERENCES wydawca(id_wydawcy)
					ON UPDATE CASCADE
					ON DELETE CASCADE,
			id_artysty INT UNSIGNED NOT NULL,
				CONSTRAINT plyta_id_artysty_fk
				FOREIGN KEY (id_artysty)
				REFERENCES artysta(id_artysty)
					ON UPDATE CASCADE
					ON DELETE CASCADE
)
Engine=InnoDB DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci';

CREATE TABLE utwor
(
	id_utworu INT UNSIGNED AUTO_INCREMENT,
	tytul_utworu TINYTEXT NOT NULL,
	czas_utworu TIME NOT NULL, 
		PRIMARY KEY (id_utworu),
		id_plyty INT UNSIGNED NOT NULL,
			CONSTRAINT utwor_id_plyty_fk
			FOREIGN KEY (id_plyty)
			REFERENCES plyta(id_plyty)
)
Engine=InnoDB DEFAULT CHARACTER SET 'utf8' COLLATE 'utf8_polish_ci';

/*==============================================================*/
/* Wprowadzenie zestawów danych do tabel		                */
/*==============================================================*/
INSERT INTO wydawca VALUES (null, 'EMI Music Poland', 'ul. Osmańska 11', '02-823 Warszawa', 'Polska', '(22) 549 18 00', 'kontakt@emimusic.pl','www.emimusic.pl');
INSERT INTO wydawca VALUES (null, 'Sony Music Poland','ul. Chóralna 14', '02-879 Warszawa', 'Polska', '(22) 336 60 00', 'pl_kontakt@sonymusic.com','www.sonymusic.pl');
INSERT INTO wydawca VALUES (null, 'Universal Music Polska','ul. Włodarzewska 69','02-384 Warszawa','Polska','(22) 592 82 00','universal@universalmusic.pl','https://universalmusic.pl');
INSERT INTO wydawca VALUES (null, 'Magic Records', 'ul. Włodarzewska 69', '02-384 Warszawa', 'Polska', '(22) 668 66 00', 'kontakt@magicrecords.pl','www.magicrecords.pl');
INSERT INTO wydawca VALUES (null, 'Warner Music Poland','ul. Osmańska 11','02-823 Warszawa', 'Polska', '(22) 549 18 10','kontakt@warnermusic.pl','https://www.warnermusic.pl');

INSERT INTO artysta VALUES (null, 'Bob Dylan', 'Solista');
INSERT INTO artysta VALUES (null, 'Metallica', 'Zespół');
INSERT INTO artysta VALUES (null, 'Linkin Park', 'Zespół');
INSERT INTO artysta VALUES (null, 'Lana DelRey', 'Solista');
INSERT INTO artysta VALUES (null, 'Kortez', 'Solista');
INSERT INTO artysta VALUES (null, 'Sting', 'Solista');
INSERT INTO artysta VALUES (null, 'Sade', 'Solista');
INSERT INTO artysta VALUES (null, 'Massive Attack', 'Zespół');
INSERT INTO artysta VALUES (null, 'George Michael', 'Solista');

INSERT INTO plyta VALUES (null, 'Nashville Skyline', 17, '1969-04-09', '2005-12-01', null, 'Pop', 'Dobra', 'CD', 1,'JevelCase', 49.75, 4.99, 1, 1);
INSERT INTO plyta VALUES (null, 'Down in the Groove', 12, '1988-06-15','1992-04-06',null, 'Pop', 'Przecietna', 'CD', 1,'JevelCase', 39.00, null, 1, 2);
INSERT INTO plyta VALUES (null, 'MTV Unplugged', 14,'1995-04-18',null,null, 'Jazz','Super', 'DVD',1,'JevelCase/Album', 75.49, 5.99, 2, 2);
INSERT INTO plyta VALUES (null, '...And Justice for All', 11, '1988-10-09','2018-11-02',2, 'Metal', 'Dobra', 'CD',1, 'JevelCase',36.00, 4.99, 4, 2);
INSERT INTO plyta VALUES (null, 'Garage Inc.', 14,'1998-11-20',null, null, 'Metal', 'Super','CD',2,'JevelCase',43.20,null, 2, 2);
INSERT INTO plyta VALUES (null, 'Black Album', 2,'1991-02-21',null, null, 'Metal','Super','CD',1, 'JevelCase',59.00, 10.00,2,2);
INSERT INTO plyta VALUES (null, 'Modern Times', 15, '2006-07-29',null,null, 'Blues','Dobra','CD',1, 'JevelCase/Album', 39.99, 4.50,3, 1);
INSERT INTO plyta VALUES (null, 'Hybrid Theory', 24, '2000-10-24','2020-08-16',2, 'Rock','Dobra','DVD',1,'JevelCase/Album', 65.90,null, 3, 3);
INSERT INTO plyta VALUES (null, 'Meteora', 19, '2003-03-25','2009-01-01',null,'Rock','Super','CD',1,'JevelCase',50.00,3.99,4,3);
INSERT INTO plyta VALUES (null, 'Minutes to Midnight', 21, '2007-05-15',null, null, 'Rock', 'Super','CD',1,'JevelCase',49.50, null, 4, 3);
INSERT INTO plyta VALUES (null, 'A Thousand Suns', 33, '2010-09-13',null, null, 'Rock', 'Super','DVD',1,'JevelCase/Album',89.90,10.99, 1,3);
INSERT INTO plyta VALUES (null, 'Ride The Lightning', 13, '1984-07-27','2016-04-15',2, 'Metal', 'Mierna','Vinyl',1,'Standard', 96.40, null, 2, 1);
INSERT INTO plyta VALUES (null, 'Master of Puppets', 21, '1986-03-03','2017-11-17',1, 'Metal', 'Super','CD',1,'JevelCase', 49.99,null, 1,1);
INSERT INTO plyta VALUES (null, '...And Justice for All', 7, '1988-08-25','2018-11-02',1, 'Metal', 'Super','CD',1,'Digipack', 39.99, 5.00,3, 1);
INSERT INTO plyta VALUES (null, 'Load', 21, '1996-06-04',null,null, 'Metal', 'Super','CD',1, 'Digipack',44.75, null, 3,1);
INSERT INTO plyta VALUES (null, 'Reload', 17, '1997-11-18',null, null, 'Metal', 'Mierna','Vinyl',1,'Standard', 50.75,9.50,2,1);
INSERT INTO plyta VALUES (null, 'Mezzanine', 14, '1998-04-20','2019-08-23', 2, 'Mix', 'dobra','CD',2,'JevelCase',37.45,null,4,8);
INSERT INTO plyta VALUES (null, 'Protection', 10, '1994-09-26','2016-12-02',3, 'Mix', 'dobra','Vinyl',1,'Standard/Album',79.99,2.50,4,8);
INSERT INTO plyta VALUES (null, 'Older', 11, '1996-04-17',null,null, 'Pop', 'Bardzo dobra','CD',1,'JevelCase',35.00,null,2,9);

INSERT INTO utwor VALUES (null, 'Girl From The North Country', '00:03:41', 1);
INSERT INTO utwor VALUES (null, 'Nashville Skyline Rag', '00:03:12', 1);
INSERT INTO utwor VALUES (null, 'To Be Alone With You', '00:02:05', 1);
INSERT INTO utwor VALUES (null, 'I Threw It All Away', '00:02:23', 1);
INSERT INTO utwor VALUES (null, 'Peggy Day', '00:01:59', 1);
INSERT INTO utwor VALUES (null, 'Lay Lady Lay', '00:03:20', 1);
INSERT INTO utwor VALUES (null, 'One More Night', '00:02:25', 1);
INSERT INTO utwor VALUES (null, 'Tell Me That It Isn\'t True', '00:02:45', 1);
INSERT INTO utwor VALUES (null, 'Country Pie', '00:01:35', 1);
INSERT INTO utwor VALUES (null, 'Tonight I\'ll Be Staying Here With You', '00:03:23', 1);

INSERT INTO utwor VALUES (null, 'Let\'s Stick Together', '00:03:09', 2);
INSERT INTO utwor VALUES (null, 'When Did You Leave Heaven?', '00:02:15', 2);
INSERT INTO utwor VALUES (null, 'Sally Sue Brown', '00:02:29', 2);
INSERT INTO utwor VALUES (null, 'Death Is Not the End', '00:05:10', 2);
INSERT INTO utwor VALUES (null, 'Had a Dream About You, Baby', '00:02:53', 2);
INSERT INTO utwor VALUES (null, 'Ugliest Girl in the World', '00:03:32', 2);
INSERT INTO utwor VALUES (null, 'Silvio', '00:03:05', 2);
INSERT INTO utwor VALUES (null, 'Ninety Miles an Hour (Down a Dead End Street)', '00:02:56', 2);
INSERT INTO utwor VALUES (null, 'Shenandoah', '00:03:38', 2);
INSERT INTO utwor VALUES (null, 'Rank Strangers to Me', '00:02:57', 2);

INSERT INTO utwor VALUES (null, 'Lowmans Lyric', '00:08:05', 3);
INSERT INTO utwor VALUES (null, 'Helpless', '00:04:04', 3);
INSERT INTO utwor VALUES (null, 'Tuesdays Gone', '00:08:18', 3);
INSERT INTO utwor VALUES (null, 'Poor Twisted Me', '00:05:04', 3);
INSERT INTO utwor VALUES (null, 'When the Deal Goes Down', '00:04:02', 3);
INSERT INTO utwor VALUES (null, 'Fade To Black', '00:08:03', 3);
INSERT INTO utwor VALUES (null, 'The Four Horsemen', '00:05:07', 3);
INSERT INTO utwor VALUES (null, 'Nothing Else Matters', '00:06:50', 3);
INSERT INTO utwor VALUES (null, 'Last Caress', '00:03:07', 3);
INSERT INTO utwor VALUES (null, 'Nothing Else Matters', '00:06:33', 3);
INSERT INTO utwor VALUES (null, 'Mama Said', '00:08:03', 3);
INSERT INTO utwor VALUES (null, 'Wasting My Hate', '00:03:42', 3);
INSERT INTO utwor VALUES (null, 'Last Caress', '00:01:20', 3);
INSERT INTO utwor VALUES (null, 'So What', '00:02:28', 3);

INSERT INTO utwor VALUES (null, 'Blackened', '00:06:42', 4);
INSERT INTO utwor VALUES (null, '...And Justice for All', '00:09:46', 4);
INSERT INTO utwor VALUES (null, 'Eye of the Beholder', '00:06:25', 4);
INSERT INTO utwor VALUES (null, 'One', '00:07:26', 4);
INSERT INTO utwor VALUES (null, 'OnThe Shortest Straw', '00:06:35', 4);
INSERT INTO utwor VALUES (null, 'Harvester of Sorrow', '00:05:45', 4);
INSERT INTO utwor VALUES (null, 'The Frayed Ends of Sanity', '00:07:43', 4);
INSERT INTO utwor VALUES (null, 'The Frayed Ends of SanityTo Live Is to Die', '00:09:49', 4);
INSERT INTO utwor VALUES (null, 'Dyers Eve', '00:05:14', 4);

INSERT INTO utwor VALUES (null, 'Free Speech for the Dumb', '00:02:35', 5);
INSERT INTO utwor VALUES (null, 'It\’s Electric', '00:03:33', 5);
INSERT INTO utwor VALUES (null, 'Sabbra Cadabra', '00:06:20', 5);
INSERT INTO utwor VALUES (null, 'Turn the Page', '00:06:06', 5);
INSERT INTO utwor VALUES (null, 'Die, Die My Darling', '00:02:29', 5);
INSERT INTO utwor VALUES (null, 'Loverman', '00:07:52', 5);
INSERT INTO utwor VALUES (null, 'Mercyful Fate', '00:11:11', 5);
INSERT INTO utwor VALUES (null, 'Astronomy', '00:06:37', 5);
INSERT INTO utwor VALUES (null, 'Whiskey in the Jar', '00:05:04', 5);
INSERT INTO utwor VALUES (null, 'Tuesday\’s Gone', '00:09:05', 5);
INSERT INTO utwor VALUES (null, 'The More I See', '00:04:48', 5);

INSERT INTO utwor VALUES (null, 'Enter Sandman', '00:05:31', 6);
INSERT INTO utwor VALUES (null, 'Sad But True', '00:05:24', 6);
INSERT INTO utwor VALUES (null, 'Holier Than Thou', '00:03:47',6);
INSERT INTO utwor VALUES (null, 'The Unforgiven', '00:06:27', 6);
INSERT INTO utwor VALUES (null, 'Wherever I May Roam', '00:06:44', 6);
INSERT INTO utwor VALUES (null, 'Dont Tread on Me', '00:04:00', 6);
INSERT INTO utwor VALUES (null, 'Trough The Never', '00:04:04', 6);
INSERT INTO utwor VALUES (null, 'Nothing Else Matters', '00:06:29', 6);
INSERT INTO utwor VALUES (null, 'On Wolf and Man', '00:04:17', 6);
INSERT INTO utwor VALUES (null, 'The God that Failed', '00:05:09', 6);
INSERT INTO utwor VALUES (null, 'My Friend of Misery', '00:06:50', 6);
INSERT INTO utwor VALUES (null, 'The Struggle Within', '00:03:54', 6);

INSERT INTO utwor VALUES (null, 'Thunder Over Mountain', '00:05:55', 7);
INSERT INTO utwor VALUES (null, 'Spirit on the Water', '00:07:42', 7);
INSERT INTO utwor VALUES (null, 'Rollin and Tumblin', '00:06:01', 7);
INSERT INTO utwor VALUES (null, 'When the Deal Goes Down', '00:05:04', 7);
INSERT INTO utwor VALUES (null, 'Someday Baby', '00:04:56', 7);
INSERT INTO utwor VALUES (null, 'Workingsmans Blues', '00:06:07', 7);
INSERT INTO utwor VALUES (null, 'Beyond the Horizon', '00:05:36', 7);
INSERT INTO utwor VALUES (null, 'Nettie Moore', '00:06:53', 7);
INSERT INTO utwor VALUES (null, 'The Levees Gonna Break', '00:05:43', 7);
INSERT INTO utwor VALUES (null, 'Aint Talking', '00:08:48', 7);

INSERT INTO utwor VALUES (null, 'Papercut', '00:03:05', 8);
INSERT INTO utwor VALUES (null, 'One Step Closer', '00:02:35', 8);
INSERT INTO utwor VALUES (null, 'With You - (Linkin Park / Dust Brothers)', '00:03:23', 8);
INSERT INTO utwor VALUES (null, 'Points of Authority', '00:03:20', 8);
INSERT INTO utwor VALUES (null, 'Crawling', '00:03:28', 8);
INSERT INTO utwor VALUES (null, 'Runaway - (Linkin Park / Mark Wakefield)', '00:03:04', 8);
INSERT INTO utwor VALUES (null, 'By Myself', '00:03:10', 8);
INSERT INTO utwor VALUES (null, 'In the End', '00:03:36', 8);
INSERT INTO utwor VALUES (null, 'A Place for My Head', '00:03:05', 8);
INSERT INTO utwor VALUES (null, 'Forgotten', '00:03:14', 8);
INSERT INTO utwor VALUES (null, 'Cure for the Itch', '00:02:37', 8);
INSERT INTO utwor VALUES (null, 'Pushing Me Away', '00:03:11', 8);

INSERT INTO utwor VALUES (null, 'Foreword', '00:00:13', 9);
INSERT INTO utwor VALUES (null, 'Don\'t Stay', '00:03:08', 9);
INSERT INTO utwor VALUES (null, 'Somewhere I Belong', '00:03:33', 9);
INSERT INTO utwor VALUES (null, 'Lying from You', '00:02:54', 9);
INSERT INTO utwor VALUES (null, 'Hit the Floor', '00:02:44', 9);
INSERT INTO utwor VALUES (null, 'Easier to Run', '00:03:24', 9);
INSERT INTO utwor VALUES (null, 'Faint', '00:02:42', 9);
INSERT INTO utwor VALUES (null, 'Figure.09', '00:03:17', 9);
INSERT INTO utwor VALUES (null, 'Breaking the Habit', '00:03:16', 9);
INSERT INTO utwor VALUES (null, 'From the Inside', '00:02:55', 9);
INSERT INTO utwor VALUES (null, 'Nobody\'s Listening', '00:02:58', 9);
INSERT INTO utwor VALUES (null, 'Session', '00:02:24', 9);
INSERT INTO utwor VALUES (null, 'Numb', '00:03:07', 9);

INSERT INTO utwor VALUES (null, 'Wake', '00:01:43', 10);
INSERT INTO utwor VALUES (null, 'Given Up', '00:03:11', 10);
INSERT INTO utwor VALUES (null, 'Leave Out All the Rest', '00:03:31', 10);
INSERT INTO utwor VALUES (null, 'Bleed It Out', '00:02:46', 10);
INSERT INTO utwor VALUES (null, 'Shadow of the Day', '00:04:52', 10);
INSERT INTO utwor VALUES (null, 'What I\'ve Done', '00:03:28', 10);
INSERT INTO utwor VALUES (null, 'Hands Held High', '00:03:55', 10);
INSERT INTO utwor VALUES (null, 'No More Sorrowh', '00:03:43', 10);
INSERT INTO utwor VALUES (null, 'Valentine\'s Day', '00:03:18', 10);
INSERT INTO utwor VALUES (null, 'In Between', '00:03:18', 10);
INSERT INTO utwor VALUES (null, 'In Pieces', '00:03:40', 10);
INSERT INTO utwor VALUES (null, 'The Little Things Give You Away', '00:06:23', 10);

INSERT INTO utwor VALUES (null, 'Fight Fire with Fire', '00:04:44', 11);
INSERT INTO utwor VALUES (null, 'Ride the Lightning', '00:06:37', 11);
INSERT INTO utwor VALUES (null, 'For Whom the Bell Tolls', '00:05:11', 11);
INSERT INTO utwor VALUES (null, 'Fade to Black', '00:06:55', 11);
INSERT INTO utwor VALUES (null, 'Trapped Under Ice', '00:04:04', 11);
INSERT INTO utwor VALUES (null, 'Escape', '00:04:24', 11);
INSERT INTO utwor VALUES (null, 'Creeping Death', '00:06:36', 11);
INSERT INTO utwor VALUES (null, 'The Call of Ktulu', '00:08:55', 11);

INSERT INTO utwor VALUES (null, 'Battery', '00:05:12', 12);
INSERT INTO utwor VALUES (null, 'Master of Puppets', '00:08:35', 12);
INSERT INTO utwor VALUES (null, 'The Thing That Should Not Be', '00:06:36', 12);
INSERT INTO utwor VALUES (null, 'Welcome Home (Sanitarium)', '00:06:27', 12);
INSERT INTO utwor VALUES (null, 'Disposable Heroes', '00:08:16', 12);
INSERT INTO utwor VALUES (null, 'Leper Messiah', '00:05:40', 12);
INSERT INTO utwor VALUES (null, 'Orion', '00:08:27', 12);
INSERT INTO utwor VALUES (null, 'Damage, Inc.', '00:05:32', 12);

INSERT INTO utwor VALUES (null, 'Angel', '00:06:18', 17);
INSERT INTO utwor VALUES (null, 'Risingson', '00:04:58', 17);
INSERT INTO utwor VALUES (null, 'Teardrop', '00:05:29', 17);
INSERT INTO utwor VALUES (null, 'Inertia Creeps', '00:05:56', 17);
INSERT INTO utwor VALUES (null, 'Exchange', '00:04:11', 17);
INSERT INTO utwor VALUES (null, 'Dissolved Girl', '00:06:07', 17);
INSERT INTO utwor VALUES (null, 'Man Next Door', '00:05:55', 17);
INSERT INTO utwor VALUES (null, 'Black Milk', '00:06:20', 17);
INSERT INTO utwor VALUES (null, 'Mezzanine', '00:05:54', 17);
INSERT INTO utwor VALUES (null, 'Group Four', '00:08:13', 17);
INSERT INTO utwor VALUES (null, '(Exchange)', '00:04:08', 17);

INSERT INTO utwor VALUES (null, 'Protection', '00:07:51', 18);
INSERT INTO utwor VALUES (null, 'Karmacoma', '00:05:16', 18);
INSERT INTO utwor VALUES (null, 'Three', '00:03:49', 18);
INSERT INTO utwor VALUES (null, 'Weather Storm', '00:04:59', 18);
INSERT INTO utwor VALUES (null, 'Spying Glass', '00:05:20', 18);
INSERT INTO utwor VALUES (null, 'Better Things', '00:04:13', 18);
INSERT INTO utwor VALUES (null, 'Eurochild', '00:05:11', 18);
INSERT INTO utwor VALUES (null, 'Sly', '00:05:24', 18);
INSERT INTO utwor VALUES (null, 'Heat Miser', '00:03:39', 18);
INSERT INTO utwor VALUES (null, 'Light My Fire', '00:03:15', 18);

INSERT INTO utwor VALUES (null, 'Jesus to a Child', '00:06:50', 19);
INSERT INTO utwor VALUES (null, 'Fastlove', '00:05:24', 19);
INSERT INTO utwor VALUES (null, 'Older', '00:05:33', 19);
INSERT INTO utwor VALUES (null, 'Spinning the Wheel', '00:06:21', 19);
INSERT INTO utwor VALUES (null, 'It Doesn\’t Really Matter', '00:04:50', 19);
INSERT INTO utwor VALUES (null, 'The Strangest Thing', '00:06:01', 19);
INSERT INTO utwor VALUES (null, 'To Be Forgiveng', '00:05:21', 19);
INSERT INTO utwor VALUES (null, 'Move On', '00:04:45', 19);
INSERT INTO utwor VALUES (null, 'Star People', '00:05:16', 19);
INSERT INTO utwor VALUES (null, 'You Have Been Loved', '00:05:31', 19);
INSERT INTO utwor VALUES (null, 'Free', '00:03:00', 19);