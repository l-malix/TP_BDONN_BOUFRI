INSERT into Camion (immatriculation, remarque)
VALUES  ('AC-543-AG',NULL),
        ('AD-671-KA',NULL),
        ('AH-126-GG',NULL),
        ('AM-654-TU',NULL),
        ('BA-865-PF',NULL),
        ('BA-921-AA', 'au garage pour réparation'),
        ('CK-221-KW',NULL),
        ('CL-128-TR',NULL),
        ('CN-225-AB',NULL);

INSERT INTO Chauffeur (nom_chauffeur, prenom_chauffeur, immatriculation)
VALUES ('DENT'      , 'Arthur'   , 'AC-543-AG'),
        ('LE ROC''H' , 'Henry'    , 'BA-865-PF'),
        ('DUPUIS'   , 'Nathalie' , 'AH-126-GG'),
        ('WEBER'    , 'Jacques'  , 'BA-921-AA'),
        ('EMOUCHET' , 'David'    , 'AD-671-KA'),
        ('CE''NEDRA' , 'Alexandra', 'CN-225-AB');

INSERT INTO QuaiDeChargement (ville_chargement, adresse_quai)
VALUES ('SOUMOULOU', '5 allée Beltegeuse'),
        ('METZ'    , '15 rue des rochers' ),
        ('NICE'    , '10 boulevard des marins' );

INSERT INTO Produit (nom_produit)
VALUES  ('Melon'),
        ('Pomme de terre'),
        ('Fraise'),
        ('Poireau'),
        ('Orange'),
        ('Kiwi'),
        ('Mandarine');

INSERT INTO Stock (id_stock  ,nom_produit, qte_produit, VilleDeChargement)
VALUES  (1, 'Melon'          , 850  , 'SOUMOULOU'),
        (2, 'Pomme de terre' , 12450, 'SOUMOULOU'),
        (3, 'Fraise'         , 75   , 'SOUMOULOU'),
        (4, 'Poireau'        , 300  , 'SOUMOULOU'),
        (5, 'Orange'         , 150  , 'SOUMOULOU'),
        (6, 'Pomme de terre' , 32700, 'METZ'),
        (7, 'Fraise'         , 100  , 'METZ'),
        (8, 'Kiwi'           , 400  , 'METZ'),
        (9, 'Poireau'        , 400  , 'METZ'),
        (10, 'Melon'         , 550  , 'NICE'),
        (11, 'Pomme de terre', 8350 , 'NICE'),
        (12, 'Fraise'        , 235  , 'NICE'),
        (13, 'Kiwi'          , 650  , 'NICE'),
        (14, 'Mandarine'     , 150  , 'NICE'),
        (15, 'Poireau'       , 250  , 'NICE');

INSERT INTO societe (nom_societe, adresse, ville, code_postal)
VALUES ('KAEDE', '12 Boulevard Wezemir', 'Paris', '75012'),
        ('KUROMU', '1 Cours Saint Pierre', 'Bordeaux', '33000'),
        ('KASUMI', '24 Rue du pont', 'Angers', '49000');

INSERT INTO DepotDeLivraison (adresse_livraison, nom_societe, ville)
VALUES ('5 allée des pinsons', 'KAEDE', 'Pau'),
        ('25 rue des tulipes', 'KAEDE', 'Bayonne'),
        ('2 rue des plantes' , 'KAEDE', 'Marseille'),
        ('67 rue des 5 portes', 'KAEDE', 'Brest'),
        ('8 rue des marchands','KUROMU', 'Tarbes'),
        ('1 rue de la braderie','KUROMU', 'Lille'),
        ('32 impasse de lumières','KUROMU', 'Lyon'),
        ('14 rue de la tour','KASUMI', 'Narbonne'),
        ('7 allée des 3 saules','KASUMI', 'Reims');

INSERT INTO Commande (id_commande, date_livraison, nom_societe, adresse_livraison, quantite, nom_produit)
VALUES  (1 , '2021-11-15', 'KAEDE', '5 allée des pinsons', 500, 'Pommes'),
        (2 , '2021-11-15', 'KAEDE', '5 allée des pinsons', 800, 'Pomme de terre'),
        
        (3, '2021-11-15', 'KASUMI', '14 rue de la tour', 200, 'Poires'),

        (4,'2021-11-17', 'KUROMU', '32 impasse de lumières', 100, 'Kiwi'),

        (5,'2021-11-18', 'KASUMI', '14 rue de la tour', 200, 'Poireau'),
        (6,'2021-11-18', 'KASUMI', '14 rue de la tour', 600, 'Pomme de terre'),

        (7,'2021-11-22', 'KUROMU', '1 rue de la braderie', 200, 'Mandarine'),
        (8,'2021-11-22', 'KUROMU', '1 rue de la braderie', 400, 'Oranges');

INSERT INTO Livraison (id_livraison, date_livraison, date_de_chargement, id_commande, quantite, nom_produit, ville_de_chargement, nom_chauffeur, prenom_chauffeur)
VALUES (1,'2021-11-15 08:00:00', '2021-11-15 06:00:00', 1, 500, 'Pommes', 'SOUMOULOU', 'DENT', 'Arthur'),
       (2,'2021-11-15 08:00:00', '2021-11-15 06:00:00', 2, 800, 'Pomme de terre', 'SOUMOULOU', 'DENT', 'Arthur'),
       (3,'2021-11-15 14:00:00', '2021-11-15 06:00:00', 3, 200, 'Poires', 'SOUMOULOU', 'DENT', 'Arthur'),

       (4,'2021-11-18 14:00:00', '2021-11-18 08:00:00', 5, 200, 'Poireau', 'SOUMOULOU', 'CE''NEDRA', 'Alexandra'),
       (5,'2021-11-18 14:00:00', '2021-11-18 08:00:00', 6, 600, 'Pomme de terre', 'SOUMOULOU', 'CE''NEDRA', 'Alexandra');