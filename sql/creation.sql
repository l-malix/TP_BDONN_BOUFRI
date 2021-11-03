
CREATE TABLE public.Camion (
                immatriculation VARCHAR(30) NOT NULL,
                remarque VARCHAR(40),
                CONSTRAINT pk_camion PRIMARY KEY (immatriculation)
);


CREATE TABLE public.Chauffeur (
                nom_chauffeur VARCHAR(20) NOT NULL,
                prenom_chauffeur VARCHAR(20) NOT NULL,
                immatriculation VARCHAR(30) NOT NULL,
                CONSTRAINT pk_chauffeur PRIMARY KEY (nom_chauffeur, prenom_chauffeur)
);


CREATE TABLE public.QuaiDeChargement (
                ville_chargement VARCHAR(20) NOT NULL,
                adresse_quai VARCHAR(70) NOT NULL,
                CONSTRAINT pk_ville PRIMARY KEY (ville_chargement)
);


CREATE TABLE public.Produit (
                nom_produit VARCHAR(20) NOT NULL,
                CONSTRAINT pk_produit PRIMARY KEY (nom_produit)
);


CREATE TABLE public.Stock (
                id_stock INTEGER NOT NULL,
                nom_produit VARCHAR(20) NOT NULL,
                qte_produit INTEGER NOT NULL,
                VilleDeChargement VARCHAR(20) NOT NULL,
                CONSTRAINT pk_stock PRIMARY KEY (id_stock)
);


CREATE TABLE public.societe (
                nom_societe VARCHAR(20) NOT NULL,
                adresse VARCHAR(70) NOT NULL,
                ville VARCHAR(20) NOT NULL,
                code_postal VARCHAR(10) NOT NULL,
                CONSTRAINT pk_societe PRIMARY KEY (nom_societe)
);


CREATE TABLE public.DepotDeLivraison (
                adresse_livraison VARCHAR(70) NOT NULL,
                nom_societe VARCHAR(20) NOT NULL,
                ville VARCHAR(20) NOT NULL,
                CONSTRAINT pk_depot_livraison PRIMARY KEY (adresse_livraison)
);


CREATE TABLE public.Commande (
                id_commande INTEGER NOT NULL,
                date_livraison TIMESTAMP NOT NULL,
                nom_societe VARCHAR(20) NOT NULL,
                adresse_livraison VARCHAR(70) NOT NULL,
                quantite INTEGER NOT NULL,
                nom_produit VARCHAR(20) NOT NULL,
                CONSTRAINT pk_commande PRIMARY KEY (id_commande)
);


CREATE TABLE public.Livraison (
                id_livraison INTEGER NOT NULL DEFAULT nextval('public.livraison_id_livraison_seq'),
                date_livraison TIMESTAMP NOT NULL,
                date_de_chargement TIMESTAMP NOT NULL,
                id_commande INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                nom_produit VARCHAR NOT NULL,
                ville_de_chargement VARCHAR(20) NOT NULL,
                nom_chauffeur VARCHAR(20) NOT NULL,
                prenom_chauffeur VARCHAR(20) NOT NULL,
                CONSTRAINT pk_livraison PRIMARY KEY (id_livraison)
);



ALTER TABLE public.Chauffeur ADD CONSTRAINT camion_chauffeur_fk
FOREIGN KEY (immatriculation)
REFERENCES public.Camion (immatriculation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Livraison ADD CONSTRAINT chauffeur_livraison_fk
FOREIGN KEY (nom_chauffeur, prenom_chauffeur)
REFERENCES public.Chauffeur (nom_chauffeur, prenom_chauffeur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Stock ADD CONSTRAINT quaidechargement_stock_fk
FOREIGN KEY (VilleDeChargement)
REFERENCES public.QuaiDeChargement (ville_chargement)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Livraison ADD CONSTRAINT quaidechargement_livraison_fk
FOREIGN KEY (ville_de_chargement)
REFERENCES public.QuaiDeChargement (ville_chargement)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Stock ADD CONSTRAINT produit_stock_fk
FOREIGN KEY (nom_produit)
REFERENCES public.Produit (nom_produit)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.DepotDeLivraison ADD CONSTRAINT societe_depotdelivraison_fk
FOREIGN KEY (nom_societe)
REFERENCES public.societe (nom_societe)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT societe_commande_fk
FOREIGN KEY (nom_societe)
REFERENCES public.societe (nom_societe)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commande ADD CONSTRAINT depotdelivraison_commande_fk
FOREIGN KEY (adresse_livraison)
REFERENCES public.DepotDeLivraison (adresse_livraison)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Livraison ADD CONSTRAINT commande_livraison_fk
FOREIGN KEY (id_commande)
REFERENCES public.Commande (id_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;