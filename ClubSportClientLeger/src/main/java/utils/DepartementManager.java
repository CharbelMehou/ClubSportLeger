package utils;

import java.util.HashMap;

public class DepartementManager {
    private HashMap<String, String> departements;

    public DepartementManager() {
        departements = new HashMap<>();
        initialize();
    }

    private void initialize() {
        departements.put("01", "Ain");
        departements.put("02", "Aisne");
        departements.put("03", "Allier");
        departements.put("04", "Alpes-de-Haute-Provence");
        departements.put("05", "Hautes-Alpes");
        departements.put("06", "Alpes-Maritimes");
        departements.put("07", "Ardèche");
        departements.put("08", "Ardennes");
        departements.put("09", "Ariège");
        departements.put("10", "Aube");
        departements.put("11", "Aude");
        departements.put("12", "Aveyron");
        departements.put("13", "Bouches-du-Rhône");
        departements.put("14", "Calvados");
        departements.put("15", "Cantal");
        departements.put("16", "Charente");
        departements.put("17", "Charente-Maritime");
        departements.put("18", "Cher");
        departements.put("19", "Corrèze");
        departements.put("2A", "Corse-du-Sud");
        departements.put("2B", "Haute-Corse");
        departements.put("21", "Côte-d'Or");
        departements.put("22", "Côtes-d'Armor");
        departements.put("23", "Creuse");
        departements.put("24", "Dordogne");
        departements.put("25", "Doubs");
        departements.put("26", "Drôme");
        departements.put("27", "Eure");
        departements.put("28", "Eure-et-Loir");
        departements.put("29", "Finistère");
        departements.put("30", "Gard");
        departements.put("31", "Haute-Garonne");
        departements.put("32", "Gers");
        departements.put("33", "Gironde");
        departements.put("34", "Hérault");
        departements.put("35", "Ille-et-Vilaine");
        departements.put("36", "Indre");
        departements.put("37", "Indre-et-Loire");
        departements.put("38", "Isère");
        departements.put("39", "Jura");
        departements.put("40", "Landes");
        departements.put("41", "Loir-et-Cher");
        departements.put("42", "Loire");
        departements.put("43", "Haute-Loire");
        departements.put("44", "Loire-Atlantique");
        departements.put("45", "Loiret");
        departements.put("46", "Lot");
        departements.put("47", "Lot-et-Garonne");
        departements.put("48", "Lozère");
        departements.put("49", "Maine-et-Loire");
        departements.put("50", "Manche");
        departements.put("51", "Marne");
        departements.put("52", "Haute-Marne");
        departements.put("53", "Mayenne");
        departements.put("54", "Meurthe-et-Moselle");
        departements.put("55", "Meuse");
        departements.put("56", "Morbihan");
        departements.put("57", "Moselle");
        departements.put("58", "Nièvre");
        departements.put("59", "Nord");
        departements.put("60", "Oise");
        departements.put("61", "Orne");
        departements.put("62", "Pas-de-Calais");
        departements.put("63", "Puy-de-Dôme");
        departements.put("64", "Pyrénées-Atlantiques");
        departements.put("65", "Hautes-Pyrénées");
        departements.put("66", "Pyrénées-Orientales");
        departements.put("67", "Bas-Rhin");
        departements.put("68", "Haut-Rhin");
        departements.put("69D", "Rhône");
        departements.put("69M", "Métropole de Lyon");
        departements.put("70", "Haute-Saône");
        departements.put("71", "Saône-et-Loire");
        departements.put("72", "Sarthe");
        departements.put("73", "Savoie");
        departements.put("74", "Haute-Savoie");
        departements.put("75", "Paris");
        departements.put("76", "Seine-Maritime");
        departements.put("77", "Seine-et-Marne");
        departements.put("78", "Yvelines");
        departements.put("79", "Deux-Sèvres");
        departements.put("80", "Somme");
        departements.put("81", "Tarn");
        departements.put("82", "Tarn-et-Garonne");
        departements.put("83", "Var");
        departements.put("84", "Vaucluse");
        departements.put("85", "Vendée");
        departements.put("86", "Vienne");
        departements.put("87", "Haute-Vienne");
        departements.put("88", "Vosges");
        departements.put("89", "Yonne");
        departements.put("90", "Territoire de Belfort");
        departements.put("91", "Essonne");
        departements.put("92", "Hauts-de-Seine");
        departements.put("93", "Seine-Saint-Denis");
        departements.put("94", "Val-de-Marne");
        departements.put("95", "Val-d'Oise");
        departements.put("971", "Guadeloupe");
        departements.put("972", "Martinique");
        departements.put("973", "Guyane");
        departements.put("974", "La Réunion");
        departements.put("975", "Saint-Pierre-et-Miquelon");
        departements.put("976", "Mayotte");
        departements.put("977", "Saint-Barthélemy");
        departements.put("978", "Saint-Martin");
        departements.put("984", "Terres australes et antarctiques françaises");
        departements.put("986", "Wallis-et-Futuna");
        departements.put("987", "Polynésie française");
        departements.put("988", "Nouvelle-Calédonie");
        departements.put("989", "Île de Clipperton");
        departements.put("ETR", "ETRANGER");
    }

    public String getDepartementName(String code) {
        return departements.get(code);
    }
}
