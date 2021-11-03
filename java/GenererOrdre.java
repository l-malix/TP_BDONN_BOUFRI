package org.centrale.tp_bdonn;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;

public class GenererOrdre {

    private String nom_chaffeur;
    private String prenom_chauffeur;
    private String fichier;

    BufferedWriter writer;

    public GenererOrdre(String nom_chaffeur, String prenom_chauffeur) {
        this.nom_chaffeur = nom_chaffeur;
        this.prenom_chauffeur = prenom_chauffeur;

        this.fichier = "Ordre_" + this.nom_chaffeur +"_" + this.prenom_chauffeur + ".csv";

        try {
            File f = new File(this.fichier);
            this.fichier = f.getAbsolutePath();
            this.writer = new BufferedWriter(new FileWriter(f.getAbsolutePath()));
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }


    public void ecrireLigne(String ligne) {
        try {
            this.writer.write(ligne + "\n");
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void genererOrdreDeMission() {

        String adresse_quai = "";
        String date_chargement = "";
        String date_livraison;
        String ville_de_chargement = "";
        String adresse_livraison;
        String nom_societe;
        String nom_produit;
        String quantite;

        try {
            Class.forName("org.postgresql.Driver");
            String dbURL="jdbc:postgresql://localhost/boufri";
            Connection connect = DriverManager.getConnection(dbURL,"malix", "lmalix");

            String query = "SELECT * FROM ((livraison join Commande ON livraison.id_commande = Commande.id_commande)" +
                    " join QuaiDeChargement ON livraison.ville_de_chargement = quaidechargement.ville_chargement)" +
                    " join DepotDeLivraison ON DepotDeLivraison.adresse_livraison = Commande.adresse_livraison" +
                    " WHERE nom_chauffeur="+"'"+this.nom_chaffeur+"'"+"AND prenom_chauffeur="+"'"+this.prenom_chauffeur+"'"+";";

            PreparedStatement stmt = connect.prepareStatement(query);
            ResultSet res = stmt.executeQuery();

            ecrireLigne("Chauffeur : ;" + this.prenom_chauffeur + ";" + this.nom_chaffeur);

            while (res.next()) {
                if (!res.getString("adresse_quai").equals(adresse_quai) &&
                        !res.getString("date_de_chargement").equals(date_chargement)) {
                    adresse_quai = res.getString("adresse_quai");
                    date_chargement = res.getString("date_de_chargement");
                    ecrireLigne("Adresse de quai : ;" + adresse_quai);
                    ecrireLigne("Date de chargement : ;" + date_chargement);
                    ecrireLigne("Société;Dépôt;Date;Produit;Quantité");
                }
                String ligne = res.getString("nom_societe") + ";" +
                                res.getString("adresse_livraison") + " " + res.getString("ville")+ ";"+
                                res.getString("date_livraison") + ";" +
                                res.getString("nom_produit") + ";" +
                                res.getString("quantite") + " kg";
                ecrireLigne(ligne);
            }


            stmt.close();
            connect.close();
        }
        catch(java.lang.ClassNotFoundException e)
        {
            System.err.println("ClassNotFoundException : " + e.getMessage());
        }
        catch (SQLException ex)
        {
            System.err.println("SQLException : " + ex.getMessage());
        }
        try {
            this.writer.flush();
            this.writer.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }
}
