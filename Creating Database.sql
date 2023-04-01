USE BUDT703_Project_0506_08

--SQL delete tables:
	DROP TABLE IF EXISTS [Spotify.Create];   	
	DROP TABLE IF EXISTS [Spotify.Release];   	
	DROP TABLE IF EXISTS [Spotify.Sign];   	
	DROP TABLE IF EXISTS [Spotify.Play];   	
	DROP TABLE IF EXISTS [Spotify.Classify];   	
	DROP TABLE IF EXISTS [Spotify.Receive];   	
	DROP TABLE IF EXISTS [Spotify.Award];   	
	DROP TABLE IF EXISTS [Spotify.Album];   	
	DROP TABLE IF EXISTS [Spotify.Genre];
	DROP TABLE IF EXISTS [Spotify.Artist];
	DROP TABLE IF EXISTS [Spotify.Company];
	DROP TABLE IF EXISTS [Spotify.Playlist];
	DROP TABLE IF EXISTS [Spotify.User];
	DROP TABLE IF EXISTS [Spotify.Subscription];
	DROP TABLE IF EXISTS [Spotify.Song];

-- SQL Create Table:
CREATE TABLE [Spotify.Song] (
	sngId CHAR(10) NOT NULL,
	sngName VARCHAR(40), 
	sngReleaseDate DATE, 
	sngDuration INTEGER, 
	sngPlayCount INTEGER, 
	sngLike INTEGER
	CONSTRAINT pk_Song_sngId PRIMARY KEY (sngId) )
CREATE TABLE [Spotify.Subscription] (
	sbsId CHAR(10) NOT NULL,
	sbsName VARCHAR(20), 
	sbsDesc VARCHAR(40),
	CONSTRAINT pk_Subscription_sbsId PRIMARY KEY (sbsId) ) 
CREATE TABLE [Spotify.User] (
	usrId CHAR(10) NOT NULL,
	usrFirstName VARCHAR(20), 
	usrLastName VARCHAR(20),
	usrDateOfBirth DATE, 
	usrGender VARCHAR(20), 
	sbsId CHAR(10) NOT NULL, 
	CONSTRAINT pk_User_usrId PRIMARY KEY (usrId), 
	CONSTRAINT fk_User_sbsId FOREIGN KEY (sbsId)
		REFERENCES [Spotify.Subscription] (sbsId)
		ON DELETE CASCADE ON UPDATE CASCADE )
CREATE TABLE [Spotify.Playlist] (
	plyId CHAR(10) NOT NULL,
	plyName VARCHAR(20), 
	CONSTRAINT pk_Playlist_plyId PRIMARY KEY (plyId) ) 
CREATE TABLE [Spotify.Company] (
	cmpId CHAR(10) NOT NULL,
	cmpName VARCHAR(20), 
	CONSTRAINT pk_Company_cmpId PRIMARY KEY (cmpId) ) 
CREATE TABLE [Spotify.Artist] (
	artId CHAR(10) NOT NULL,
	artName VARCHAR(25), 
	CONSTRAINT pk_Artist_artId PRIMARY KEY (artId) ) 
CREATE TABLE [Spotify.Genre] (
	gnrId CHAR(10) NOT NULL,
	gnrName VARCHAR(20), 
	CONSTRAINT pk_Genre_gnrId PRIMARY KEY (gnrId) ) 
CREATE TABLE [Spotify.Album] (
	albId CHAR(10) NOT NULL,
	albName VARCHAR(20), 
	albDate DATE,
	CONSTRAINT pk_Album_albId PRIMARY KEY (albId) ) 
CREATE TABLE [Spotify.Award] (
	awrId CHAR(10) NOT NULL,
	awrName VARCHAR(20), 
	awrDesc VARCHAR(40),
	CONSTRAINT pk_Award_awrId PRIMARY KEY (awrId) ) 
CREATE TABLE [Spotify.Receive] (
	awrId CHAR(10) NOT NULL,
	artId CHAR(10) NOT NULL,
	CONSTRAINT pk_Receive_artId_awrId PRIMARY KEY (artId, awrId),
	CONSTRAINT fk_Receive_artId FOREIGN KEY (artId)
		REFERENCES [Spotify.Artist] (artId)
		ON DELETE NO ACTION ON UPDATE NO ACTION, 
	CONSTRAINT fk_Receive_awrId FOREIGN KEY (awrId)
		REFERENCES [Spotify.Award] (awrId)
		ON DELETE NO ACTION ON UPDATE NO ACTION  ) 
CREATE TABLE [Spotify.Classify] (
	sngId CHAR(10) NOT NULL,
	gnrId CHAR(10) NOT NULL,
	CONSTRAINT pk_Receive_sngId_gnrId PRIMARY KEY (sngId, gnrId),
	CONSTRAINT fk_sngId FOREIGN KEY (sngId)
		REFERENCES [Spotify.Song] (sngId)
		ON DELETE CASCADE ON UPDATE CASCADE, 
	CONSTRAINT fk_gnrId FOREIGN KEY (gnrId)
		REFERENCES [Spotify.Genre] (gnrId)
		ON DELETE CASCADE ON UPDATE CASCADE  ) 
CREATE TABLE [Spotify.Play] (
	sngId CHAR(10) NOT NULL,
	usrId CHAR(10) NOT NULL, 
	plyTimes INTEGER,
	likes INTEGER,
	CONSTRAINT pk_Play_sngId_usrId PRIMARY KEY (sngId, usrId), 
	CONSTRAINT fk_Play_sngId FOREIGN KEY (sngId)
	REFERENCES [Spotify.Song] (sngId)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Play_usrId FOREIGN KEY (usrId)
	REFERENCES [Spotify.User] (usrId)
	ON DELETE CASCADE ON UPDATE CASCADE )
CREATE TABLE [Spotify.Sign] (
	albId CHAR(10) NOT NULL,
	artId CHAR(10) NOT NULL, 
	cmpId CHAR(10) NOT NULL,
	CONSTRAINT pk_Sign_albId_artId PRIMARY KEY (albId, artId), 
	CONSTRAINT fk_Sign_albId FOREIGN KEY (albId)
		REFERENCES [Spotify.Album] (albId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Sign_artId FOREIGN KEY (artId)
		REFERENCES [Spotify.Artist] (artId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Sign_cmpId FOREIGN KEY (cmpId)
		REFERENCES [Spotify.Company] (cmpId)
		ON DELETE CASCADE ON UPDATE CASCADE )
CREATE TABLE [Spotify.Release] (
	sngId CHAR(10) NOT NULL,
	artId CHAR(10) NOT NULL, 
	cmpId CHAR(10) NOT NULL,
	CONSTRAINT pk_Release_sngId_artId PRIMARY KEY (sngId, artId), 
	CONSTRAINT fk_Release_sngId FOREIGN KEY (sngId)
		REFERENCES [Spotify.Song] (sngId)
		ON DELETE CASCADE ON UPDATE CASCADE, 
	CONSTRAINT fk_Release_artId FOREIGN KEY (artId)
		REFERENCES [Spotify.Artist] (artId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Release_cmpId FOREIGN KEY (cmpId)
		REFERENCES [Spotify.Company] (cmpId)
		ON DELETE CASCADE ON UPDATE CASCADE )
CREATE TABLE [Spotify.Create] (
	sngId CHAR(10) NOT NULL,
	plyId CHAR(10) NOT NULL, 
	usrId CHAR(10) NOT NULL,
	CONSTRAINT pk_Create_sngId_plyId PRIMARY KEY (sngId, plyId), 
	CONSTRAINT fk_Create_sngId FOREIGN KEY (sngId)
		REFERENCES [Spotify.Song] (sngId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Create_plyId FOREIGN KEY (plyId)
		REFERENCES [Spotify.Playlist] (plyId)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_Create_usrId FOREIGN KEY (usrId)
		REFERENCES [Spotify.User] (usrId)
		ON DELETE CASCADE ON UPDATE CASCADE )


--SQL Insert Data:
INSERT INTO [Spotify.Song] VALUES
	('7862SMB007','Solo de Mi','12/14/2018',197, 6482642, 95441),
	('4642COO003', 'Coolant', '08/10/2018', 211, 7445324, 580243),
	('6894LRB002', 'La Rebelion', '04/01/2019', 161, 5673621, 320994),
	('3825DLB002', 'Dont Look Back In Anger', '10/02/1995', 287, 9488372, 526993),
	('4551EVC001', 'Everybodys Changing', '01/01/2004', 215, 4633212, 242551),
	('2879WZR005', 'Island In The Sun', '05/15/2001', 200, 3566781, 444362),
	('9212WLT001', 'Will you still love me tomorrow', '01/01/2004', 287, 226631, 140234),
	('2210MDN003', 'Anti-Hero', '10/21/2022', 200, 2565855, 104231),
	('2210MDN005', 'Youre On Your Own, Kid', '10/21/2022', 194, 1665305, 489244),
	('2210MDN004', 'Snow On The Beach feat.Lana Del Rey', '10/21/2022', 256, 1987396, 712237),
	('1909MRF010','Memories','09/20/2019',189, 151056, 290013),
	('1511HRH004', 'Can"t Help Falling In Love', '11/23/2015', 171, 350802, 58930),
	('1404SSM003', 'Stay with me', '04/14/2014', 172, 162480, 91038)


INSERT INTO [Spotify.Subscription] VALUES
	('0000000141', 'Subscription', 'Student'),
	('0000002562', 'Subscription', 'Family'),
	('0000003879', 'Subscription', 'Duo'), 
	('0000000035', 'Subscriber', 'Premium')


INSERT INTO [Spotify.User] VALUES
	('7698200841', 'Javier', 'Ortiz', '04/03/1998', 'Male', '0000000141'),
	('4873629912', 'Yullie', 'Yang', '05/25/1999', 'Female', '0000002562'),
	('8273411123', 'Charlie', 'Kang', '12/25/1996', 'Male', '0000003879'),
	('0541341543', 'Malik', 'McDay', '12/01/1994', 'Male', '0000000035'),
	('1541542656', 'Ikshita', 'Ganta','07/03/1998','Female', '0000002562'),
	('0290328108', 'Nishanthi', 'Ravichandran', '10/03/1997', 'Female', '0000000035')
	


INSERT INTO [Spotify.Playlist] VALUES
	('5678345121', 'best latin songs'),
	('8724017223', 'Pap'),
	('9899822351', 'Autumn Plalist'),
	('2893028392', 'OnlyNAVs'),
	('9203728455', 'Favourites')


INSERT INTO [Spotify.Company] VALUES
	('RMS0000001', 'Rimas Entertainment'),	
	('SNY0000001', 'Sony Music'),         	
	('UMG0000001', 'UMG Recording'),
	('BBR0000001', 'Big Brother'),
	('UIR0000001', 'Universal-Island'),
	('GFN0000001', 'Geffen'),
	('KNS0000001', 'Kultural&Spetakkel'),
	('RPB0000001', 'Republic')



INSERT INTO [Spotify.Artist] VALUES
	('BBB0000001', 'Bad Bunny'),
	('COO0000001', 'Coolant'),
	('JBV0000001', 'J Balvin'),
	('OAS0000001', 'Oasis'),
	('KAN0000001', 'Keane'),
	('WZR0000001', 'Weezer'),
	('IMG0000001', 'Inger Marie Gundersen'),
	('TSF0000001', 'Taylor Swift'),
	('MRF0000001', 'Maroon 5'),
	('HRH0000001', 'Haley Reinhart'),
	('SSM0000001', 'Sam Smith')


INSERT INTO [Spotify.Genre] VALUES
	('GNR0000003', 'Latin'),
	('GNR0000004', 'R&B'),
	('GNR0000005', 'Alternative'),
	('GNR0000006', 'Jazz'),
	('GNR0000001', 'Pop'),
	('TG79641852', 'Latin Urbano'),
	('EI56106780', 'rap'), 
	('PO20385323', 'Electronic')
	



INSERT INTO [Spotify.Album] VALUES
	('7862SMBSDM', 'Solo de Mi', '12/14/2018'),
	('4642COOXUQ', 'Coolant', '08/10/2018'),
	('6894LRBCDA', 'La Rebelion', '04/01/2019'),
	('7723MRNGLR', 'Morning Glory?', '10/02/1995'),
	('5822HPSFRS', 'Hopes And Fears', '01/01/2004'),
	('2879WZRGRA', 'Weezer(Green Album)', '05/15/2001'),
	('9112WZRGRA', 'Make this moment', '01/01/2004'),
	('2210MDN3AM', 'Midnight', '10/21/2022'),
	('aN27194746', 'Aura', '8/24/18'),
	('1909MRFJRD', 'JORDI', '06/11/2019'),
	('1604HRHBTR', 'Better', '04/29/2016'),
	('1404SSMILH', 'In The Lonely Hour', '04/14/2014')


INSERT INTO [Spotify.Award] VALUES
	('GRMYAWD001', 'Grammy', 'Record of the Year'),
	('BILLBRD001', 'Billboard', 'Top Latin Song '),
	('MTVVMAD001', 'MTV Video Music', 'Best Latin '),
	('BRITAWD001', 'Brit Awards', 'Breakthrough Act'),
	('GRMYAWD002', 'Grammy', 'Best Music Video'),
	('GRMYAWD003', 'Grammy', 'Album of the Year')


INSERT INTO [Spotify.Receive] VALUES
	('GRMYAWD001', 'BBB0000001'),
	('BILLBRD001', 'COO0000001'),
	('MTVVMAD001', 'JBV0000001'),
	('BRITAWD001', 'OAS0000001'),
	('BRITAWD001', 'KAN0000001'),
	('GRMYAWD002', 'WZR0000001'),
	('GRMYAWD003', 'TSF0000001')


INSERT INTO [Spotify.Classify] VALUES
	('7862SMB007', 'GNR0000003'),
	('4642COO003', 'GNR0000003'),
	('6894LRB002', 'GNR0000003'),
	('3825DLB002', 'GNR0000004'),
	('4551EVC001', 'GNR0000005'),
	('2879WZR005', 'GNR0000005'),
	('9212WLT001', 'GNR0000006'),
	('2210MDN003', 'GNR0000001'),
	('2210MDN005', 'GNR0000001'),
	('2210MDN004', 'GNR0000001')


INSERT INTO [Spotify.Play] VALUES
	('7862SMB007', '7698200841', 54,1),
	('4642COO003', '7698200841', 42,1),
	('6894LRB002', '7698200841', 39,1),
	('3825DLB002', '4873629912', 12,1),
	('4551EVC001', '4873629912', 12,1),
	('2879WZR005', '4873629912', 10,0),
	('9212WLT001', '4873629912', 7,1),
	('2210MDN003', '8273411123', 26,1),
	('2210MDN005', '8273411123', 22,1),
	('2210MDN004', '8273411123', 24,1),
	('1909MRF010', '0541341543', 11, 0),
	('1511HRH004', '1541542656', 7, 1),
	('1404SSM003', '0290328108', 9, 0)


INSERT INTO [Spotify.Sign] VALUES
	('7862SMBSDM', 'BBB0000001', 'RMS0000001'),
	('4642COOXUQ', 'COO0000001', 'SNY0000001'),
	('6894LRBCDA', 'JBV0000001', 'UMG0000001'),
	('7723MRNGLR', 'OAS0000001', 'BBR0000001'),
	('5822HPSFRS', 'KAN0000001', 'UIR0000001'),
	('2879WZRGRA', 'WZR0000001', 'GFN0000001'),
	('9112WZRGRA', 'IMG0000001', 'KNS0000001'),
	('2210MDN3AM', 'TSF0000001', 'RPB0000001'),
	('1909MRFJRD', 'MRF0000001', 'SNY0000001'),
	('1604HRHBTR', 'HRH0000001', 'UMG0000001'),
	('1404SSMILH', 'SSM0000001', 'SNY0000001')
	
INSERT INTO [Spotify.Release] VALUES
	('7862SMB007', 'BBB0000001', 'RMS0000001'),
	('4642COO003', 'COO0000001', 'SNY0000001'),
	('6894LRB002', 'JBV0000001', 'UMG0000001'),
	('3825DLB002', 'OAS0000001', 'BBR0000001'),
	('4551EVC001', 'KAN0000001', 'UIR0000001'),
	('9212WLT001', 'IMG0000001', 'KNS0000001'),
	('2210MDN003', 'TSF0000001', 'RPB0000001'),
	('2210MDN005', 'TSF0000001', 'RPB0000001'),
	('2210MDN004', 'TSF0000001', 'RPB0000001'),
	('1909MRF010', 'MRF0000001', 'SNY0000001'),
	('1511HRH004', 'HRH0000001', 'UMG0000001'),
	('1404SSM003', 'SSM0000001', 'SNY0000001')

INSERT INTO [Spotify.Create] VALUES
	('7862SMB007', '5678345121', '7698200841'),
	('4642COO003', '5678345121', '7698200841'),
	('6894LRB002', '5678345121', '7698200841'),
	('3825DLB002', '8724017223', '4873629912'),
	('4551EVC001', '8724017223', '4873629912'),
	('2879WZR005', '8724017223', '4873629912'),
	('9212WLT001', '8724017223', '4873629912'),
	('2210MDN003', '9899822351', '8273411123'),
	('2210MDN005', '9899822351', '8273411123'),
	('2210MDN004', '9899822351', '8273411123'),
	('1909MRF010', '2893028392', '0541341543'),
	('1511HRH004', '2893028392', '1541542656'),
	('1404SSM003', '9203728455', '0290328108')
