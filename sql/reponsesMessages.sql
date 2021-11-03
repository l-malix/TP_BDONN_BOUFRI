/* Message 2 */
SELECT * FROM chauffeur;

/* Messaage 3 */
UPDATE camion
SET remarque = 'au garage jusqu''à fin Novembre'
WHERE immatriculation='AC-543-AG'

/* Message 4 */
SELECT camion.immatriculation FROM 
camion LEFT JOIN chauffeur
ON camion.immatriculation = chauffeur.immatriculation
WHERE chauffeur.nom_chauffeur = NULL AND camion.remarque = NULL;

/* Message 5 */
SELECT CASE WHEN 
livraison.id_commande is NULL THEN 'livraison non programmée'
ELSE 'livraison programmée' END AS status_livraison
,commande.date_livraison, nom_societe, adresse_livraison, commande.quantite, commande.nom_produit
FROM commande LEFT JOIN livraison
ON commande.id_commande = livraison.id_livraison
WHERE commande.date_livraison 
BETWEEN '2021-11-01' AND '2021-12-31';

/* Message 6 */
SELECT date_livraison, nom_produit, quantite FROM livraison
WHERE nom_chauffeur = 'LE ROC''H' AND prenom_chauffeur = 'Henry';

DELETE FROM chauffeur
WHERE nom_chauffeur = 'LE ROC''H' AND prenom_chauffeur = 'Henry';

/* Message 7 */
INSERT INTO livraison (id_livraison, date_livraison, date_de_chargement, id_commande, quantite, nom_produit, ville_de_chargement, nom_chauffeur, prenom_chauffeur)
VALUES (6,'2021-11-17 00:00:00', '2021-11-17 07:00:00', 4, 100, 'Kiwi', 'NICE', 'WEBER', 'Jaques');

/* Message 9  - Trigger 1*/
CREATE OR REPLACE FUNCTION fun_trigger1() RETURNS TRIGGER language 'plpgsql' AS
$BODY$
DECLARE
        old_qt INTEGER ;
BEGIN
        SELECT qte_produit FROM Stock JOIN livraison
        ON Stock.nom_produit = livraison.nom_produit AND Stock.VilleDeChargement = livraison.ville_de_chargement
        WHERE Stock.nom_produit = NEW.nom_produit AND Stock.VilleDeChargement = NEW.ville_de_chargement into old_qt;
       
        UPDATE Stock
        SET qte_produit = old_qt - NEW.quantite
        WHERE Stock.nom_produit = NEW.nom_produit AND Stock.VilleDeChargement = NEW.ville_de_chargement;
        RETURN NEW;
END ;
$BODY$ ;
 
CREATE TRIGGER trigger1
        BEFORE INSERT
        ON livraison
        FOR EACH ROW EXECUTE PROCEDURE fun_trigger1();

/* Message 9  - Trigger 2*/
CREATE OR REPLACE FUNCTION fun_trigger2() RETURNS TRIGGER language 'plpgsql' AS
$BODY$
DECLARE
        old_qt INTEGER ;
BEGIN
        SELECT qte_produit FROM Stock
        WHERE Stock.nom_produit = OLD.nom_produit AND Stock.VilleDeChargement =  OLD.ville_de_chargement into old_qt;
       
        UPDATE Stock
        SET qte_produit = old_qt + OLD.quantite
        WHERE Stock.nom_produit = OLD.nom_produit AND Stock.VilleDeChargement = OLD.ville_de_chargement;
        RETURN NEW;
END ;
$BODY$ ;
 
 
CREATE TRIGGER trigger2
        AFTER DELETE
        ON livraison
        FOR EACH ROW EXECUTE PROCEDURE fun_trigger2();

/* Message 9  - Trigger 3*/
CREATE OR REPLACE FUNCTION fun_trigger3() RETURNS TRIGGER language 'plpgsql' AS
$BODY$
DECLARE
        old_qt INTEGER ;
        new_qt INTEGER ;
BEGIN
        SELECT qte_produit FROM Stock
        WHERE Stock.nom_produit = OLD.nom_produit AND Stock.VilleDeChargement = OLD.ville_de_chargement into old_qt;
       
       
       
        UPDATE Stock
        SET qte_produit = old_qt + OLD.quantite
        WHERE Stock.nom_produit = OLD.nom_produit AND Stock.VilleDeChargement = OLD.ville_de_chargement;
       
        SELECT qte_produit FROM Stock
        WHERE Stock.nom_produit = NEW.nom_produit AND Stock.VilleDeChargement = NEW.ville_de_chargement into old_qt;
       
        UPDATE Stock
        SET qte_produit = old_qt - NEW.quantite
        WHERE Stock.nom_produit = NEW.nom_produit AND Stock.VilleDeChargement = NEW.ville_de_chargement;
       
        RETURN NEW;
END ;
$BODY$ ;
 
 
CREATE TRIGGER trigger3
        AFTER UPDATE
        ON livraison
        FOR EACH ROW EXECUTE PROCEDURE fun_trigger3();

/* Message 11 */
INSERT INTO chauffeur (nom_chauffeur, prenom_chauffeur, immatriculation)
VALUES ('KIMOUS', 'Pierre', 'CL-128-TR');

/* Message 13 */
ALTER TABLE Camion
ADD type_camion VARCHAR(30);
UPDATE Camion
SET type_camion = 'regulier';
 
ALTER TABLE chauffeur
ADD certification VARCHAR(50);
UPDATE chauffeur
SET certification = 'regulier';

/* Message 15 */
UPDATE chauffeur
SET certification = 'regulier, frigorifiques, double essieu'
WHERE nom_chauffeur = 'CE''NEDRA' AND prenom_chauffeur = 'Alexandra';

UPDATE chauffeur
SET certification = 'regulier, frigorifiques'
WHERE nom_chauffeur = 'EMOUCHET' AND prenom_chauffeur = 'David';

