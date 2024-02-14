import Foundation

let JSONCountries = """
{
    "europe": [
        {
            "name": "Albanie",
            "flag": "Albanie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Albanie.png",
            "capital": "Tirana"
        },
        {
            "name": "Andorre",
            "flag": "Andorre.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Andorre.png",
            "capital": "Andorre-La-Vieille"
        },
        {
            "name": "Autriche",
            "flag": "Autriche.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Autriche.png",
            "capital": "Vienne"
        },
        {
            "name": "Bielorussie",
            "flag": "Bielorussie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Bielorussie.png",
            "capital": "Minsk"
        },
        {
            "name": "Belgique",
            "flag": "Belgique.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Belgique.png",
            "capital": "Bruxelles"
        },
        {
            "name": "Bosnie-Herzégovine",
            "flag": "BH.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_BH.png",
            "capital": "Sarajevo"
        },
        {
            "name": "Bulgarie",
            "flag": "Bulgarie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Bulgarie.png",
            "capital": "Sofia"
        },
        {
            "name": "Croatie",
            "flag": "Croatie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Croatie.png",
            "capital": "Zagreb"
        },
        {
            "name": "République Tchèque",
            "flag": "RC.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_RC.png",
            "capital": "Tirana"
        },
        {
            "name": "Danemark",
            "flag": "Danemark.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Danemark.png",
            "capital": "Copenhague"
        },
        {
            "name": "Estonie",
            "flag": "Estonie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Estonie.png",
            "capital": "Tallinn"
        },
        {
            "name": "Finlande",
            "flag": "Finlande.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Finlande.png",
            "capital": "Helsinki"
        },
        {
            "name": "France",
            "flag": "France.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_France.png",
            "capital": "Paris"
        },
        {
            "name": "Georgie",
            "flag": "Georgie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Georgie.png",
            "capital": "Tbilissi"
        },
        {
            "name": "Allemagne",
            "flag": "Allemagne.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Allemagne.png",
            "capital": "Berlin"
        },
        {
            "name": "Grèce",
            "flag": "Grèce.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Grèce.png",
            "capital": "Athènes"
        },
        {
            "name": "Hongrie",
            "flag": "Hongrie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Hongrie.png",
            "capital": "Budapest"
        },
        {
            "name": "Islande",
            "flag": "Islande.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Islande.png",
            "capital": "Reykjavik"
        },
        {
            "name": "Irlande",
            "flag": "Irlande.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Irlande.png",
            "capital": "Dublin"
        },
        {
            "name": "Italie",
            "flag": "Italie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Italie.png",
            "capital": "Rome"
        },
        {
            "name": "Kosovo",
            "flag": "Kosovo.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Kosovo.png",
            "capital": "Pristina"
        },
        {
            "name": "Lettonie",
            "flag": "Lettonie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Lettonie.png",
            "capital": "Riga"
        },
        {
            "name": "Liechtenstein",
            "flag": "Liechtenstein.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Liechtenstein.png",
            "capital": "Vaduz"
        },
        {
            "name": "Lituanie",
            "flag": "Lituanie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Lituanie.png",
            "capital": "Vilnius"
        },
        {
            "name": "Luxembourg",
            "flag": "Luxembourg.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Luxembourg.png",
            "capital": "Luxembourg"
        },
        {
            "name": "Malte",
            "flag": "Malte.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Malte.png",
            "capital": "La Valette"
        },
        {
            "name": "Moldavie",
            "flag": "Moldavie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Moldavie.png",
            "capital": "Chișinău"
        },
        {
            "name": "Monaco",
            "flag": "Monaco.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Monaco.png",
            "capital": "Monaco"
        },
        {
            "name": "Montenegro",
            "flag": "Montenegro.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Montenegro.png",
            "capital": "Podgorica"
        },
        {
            "name": "Pays-Bas",
            "flag": "PB.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_PB.png",
            "capital": "Amsterdam"
        },
        {
            "name": "Macédoine du Nord",
            "flag": "MDN.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_MDN.png",
            "capital": "Skopje"
        },
        {
            "name": "Norvège",
            "flag": "Norvège.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Norvège.png",
            "capital": "Oslo"
        },
        {
            "name": "Pologne",
            "flag": "Pologne.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Pologne.png",
            "capital": "Varsovie"
        },
        {
            "name": "Portugal",
            "flag": "Portugal.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Portugal.png",
            "capital": "Lisbonne"
        },
        {
            "name": "Roumanie",
            "flag": "Roumanie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Roumanie.png",
            "capital": "Bucarest"
        },
        {
            "name": "Russie",
            "flag": "Russie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Russie.png",
            "capital": "Moscou"
        },
        {
            "name": "Saint-Marin",
            "flag": "SM.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_SM.png",
            "capital": "Saint-Marin"
        },
        {
            "name": "Serbie",
            "flag": "Serbie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Serbie.png",
            "capital": "Belgrade"
        },
        {
            "name": "Slovaquie",
            "flag": "Slovaquie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Slovaquie.png",
            "capital": "Bratislava"
        },
        {
            "name": "Slovénie",
            "flag": "Slovénie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Slovénie.png",
            "capital": "Ljubljana"
        },
        {
            "name": "Espagne",
            "flag": "Espagne.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Espagne.png",
            "capital": "Madrid"
        },
        {
            "name": "Suède",
            "flag": "Suède.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Suède.png",
            "capital": "Stockholm"
        },
        {
            "name": "Suisse",
            "flag": "Suisse.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Suisse.png",
            "capital": "Berne"
        },
        {
            "name": "Turquie",
            "flag": "Turquie.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Turquie.png",
            "capital": "Ankara"
        },
        {
            "name": "Ukraine",
            "flag": "Ukraine.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Ukraine.png",
            "capital": "Kiev"
        },
        {
            "name": "Royaume-Uni",
            "flag": "UK.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_UK.png",
            "capital": "Londres"
        },
        {
            "name": "Vatican",
            "flag": "Vatican.png",
            "flagHistory": "Histoire",
            "coatOfArms": "COA_Vatican.png",
            "capital": "Vatican"
        },
    ]
}
"""
