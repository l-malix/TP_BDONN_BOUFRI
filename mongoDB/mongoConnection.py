from pymongo import MongoClient
import csv


def initialiserDB():
    cluster = "mongodb+srv://lmalix:lmalix@clientsfiles.2mk7f.mongodb.net/myFirstDatabase?retryWrites=true&w=majority"
    client = MongoClient(cluster)
    db = client.fiches_collaborateurs
    return db.fiches


def ajouterFiche(ficheCSV):
    csv_file = open(ficheCSV, "r")
    dict_reader = csv.DictReader(csv_file)
    list_of_dicts = [dict(x) for x in list(dict_reader)]
    return list_of_dicts


if __name__ == "__main__":
    fiche = initialiserDB()
    data = ajouterFiche("fiche_pascal_lelievre.csv")

    # Pour inserer un doc
    # fiche.insert_many(data)

    # 1- Le nombre total de fiches:

    print("Nombre de documents: ", fiche.count_documents({}))

    # 2 - Nombre de fiches de chaque collaborateur:

    print("Nbr de fiches de Alice DUMONS",
          fiche.count_documents({"Collaborateur": "Alice DUMOND"}))

    print("Nbr de fiches de Pascal LELIEVRE",
          fiche.count_documents({"Collaborateur": "Pascal LELIEVRE"}))

    print("Nbr de fiches de Laetitia DUPOND",
          fiche.count_documents({"Collaborateur": "Laetitia DUPOND"}))

    # 3 - Fiche de Jacques REY:

    response = fiche.find({"Nom": "Rey", "Prenom": "Jacques"})
    print("Fiche de Jaques REY: ")
    for r in response:
        print(r)

    # 4 - Fiche d'entreprise "Primeur & co"

    response = fiche.find({"Societe": "Primeur & co"})
    print("Fiche de la société Primeur & co: ")
    for r in response:
        print(r)
