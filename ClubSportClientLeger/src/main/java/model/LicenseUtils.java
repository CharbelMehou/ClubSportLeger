package model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class LicenseUtils {
	
	public static double getTotalAllMales(ArrayList<License> licenses) {
        double totalMales = 0;
        for (License license : licenses) {
            totalMales += license.getTotalMales();
        }
        return totalMales;
    }

    public  static double getTotalAllFemales(ArrayList<License> licenses) {
        double totalFemales = 0;
        for (License license : licenses) {
            totalFemales += license.getTotalFemales();
        }
        return totalFemales;
    }

    public static double getTotalAllLicenses(ArrayList<License> licenses) {
        double total = 0;
        for (License license : licenses) {
            total += license.getTotal();
        }
        return total;
    }
    public static int getTotalAllH_1_4_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_1_4_ans();
        }
        return total;
    }

    public static int getTotalAllH_5_9_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_5_9_ans();
        }
        return total;
    }

    public static int getTotalAllH_10_14_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_10_14_ans();
        }
        return total;
    }

    public   static int getTotalAllH_15_19_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_15_19_ans();
        }
        return total;
    }

    public static int getTotalAllH_20_24_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_20_24_ans();
        }
        return total;
    }
    public static int getTotalAllH_25_29_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_25_29_ans();
        }
        return total;
    }
    public static int getTotalAllH_30_34_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_30_34_ans();
        }
        return total;
    }
    public static int getTotalAllH_35_39_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_35_39_ans();
        }
        return total;
    }
    public static int getTotalAllH_40_44_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_40_44_ans();
        }
        return total;
    }
    public static int getTotalAllH_45_49_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_45_49_ans();
        }
        return total;
    }
    public static int getTotalAllH_50_54_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_50_54_ans();
        }
        return total;
    }
    public static int getTotalAllH_55_59_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_55_59_ans();
        }
        return total;
    }
    public static int getTotalAllH_60_64_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_60_64_ans();
        }
        return total;
    }
    public static int getTotalAllH_65_69_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_65_69_ans();
        }
        return total;
    }
    public static int getTotalAllH_70_74_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_70_74_ans();
        }
        return total;
    }
    public static int getTotalAllH_75_79_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_75_79_ans();
        }
        return total;
    }
    public static int getTotalAllH_80_99_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getH_80_99_ans();
        }
        return total;
    }
//    Femmes
    public static int getTotalAllF_1_4_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_1_4_ans();
        }
        return total;
    }

    public static int getTotalAllF_5_9_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_5_9_ans();
        }
        return total;
    }

    public static int getTotalAllF_10_14_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_10_14_ans();
        }
        return total;
    }

    public static int getTotalAllF_15_19_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_15_19_ans();
        }
        return total;
    }

    public static int getTotalAllF_20_24_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_20_24_ans();
        }
        return total;
    }
    public static  int getTotalAllF_25_29_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_25_29_ans();
        }
        return total;
    }
    public static int getTotalAllF_30_34_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_30_34_ans();
        }
        return total;
    }
    public static int getTotalAllF_35_39_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_35_39_ans();
        }
        return total;
    }
    public static int getTotalAllF_40_44_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_40_44_ans();
        }
        return total;
    }
    public static int getTotalAllF_45_49_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_45_49_ans();
        }
        return total;
    }
    public static int getTotalAllF_50_54_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_50_54_ans();
        }
        return total;
    }
    public static int getTotalAllF_55_59_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_55_59_ans();
        }
        return total;
    }
    public static int getTotalAllF_60_64_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_60_64_ans();
        }
        return total;
    }
    public static int getTotalAllF_65_69_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_65_69_ans();
        }
        return total;
    }
    public static int getTotalAllF_70_74_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_70_74_ans();
        }
        return total;
    }
    public static int getTotalAllF_75_79_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_75_79_ans();
        }
        return total;
    }
    public static int getTotalAllF_80_99_ans(ArrayList<License> licenses) {
        int total = 0;
        for (License license : licenses) {
            total += license.getF_80_99_ans();
        }
        return total;
    }
 // Classe pour représenter le classement
    public static class Ranking {
        private String name;
        private int totalLicenses;

        public Ranking(String name, int totalLicenses) {
            this.name = name;
            this.totalLicenses = totalLicenses;
        }

        public String getName() {
            return name;
        }

        public int getTotalLicenses() {
            return totalLicenses;
        }
    }

    // Méthode pour obtenir et trier les licences par commune
    public static ArrayList<Ranking> getAndSortCommuneTotals(ArrayList<License> licenses) {
        HashMap<String, Integer> totals = new HashMap<>();
        for (License license : licenses) {
            totals.put(license.getCommune(), totals.getOrDefault(license.getCommune(), 0) + license.getTotal());
        }
        return sortAndConvertRankings(totals);
    }
    public static ArrayList<Ranking> getAndSortDepartementTotals(ArrayList<License> licenses) {
        HashMap<String, Integer> totals = new HashMap<>();
        for (License license : licenses) {
            totals.put(license.getDepartement(), totals.getOrDefault(license.getDepartement(), 0) + license.getTotal());
        }
        return sortAndConvertRankings(totals);
    } 
    public static ArrayList<Ranking> getAndSortRegionTotals(ArrayList<License> licenses) {
        HashMap<String, Integer> totals = new HashMap<>();
        for (License license : licenses) {
            totals.put(license.getRegion(), totals.getOrDefault(license.getRegion(), 0) + license.getTotal());
        }
        return sortAndConvertRankings(totals);
    }
    // Méthode auxiliaire pour trier et convertir les totaux en une liste de Ranking
    private static ArrayList<Ranking> sortAndConvertRankings(HashMap<String, Integer> totals) {
    	ArrayList<Ranking> rankings = new ArrayList<>();
        totals.entrySet().stream()
            .sorted((entry1, entry2) -> entry2.getValue().compareTo(entry1.getValue()))
            .forEach(entry -> rankings.add(new Ranking(entry.getKey(), entry.getValue())));
        return rankings;
    }
    public static ArrayList<String> extractFederations(ArrayList<License> licences) {
        Set<String> federationsSet = new HashSet<>();
        for (License licence : licences) {
        	federationsSet.add(licence.getFederation());
        }
        return new ArrayList<>(federationsSet);
    }
    
    public static String calculateProportionHF(ArrayList<License> licenses,int totalLicences) {
        double totalMales = getTotalAllMales(licenses);
        double totalFemales = getTotalAllFemales(licenses);

        double ratioMales;
        double ratioFemales;
        String proportion;

        if (totalFemales == 0 && totalMales == 0) {          
                proportion = "Pas de données";
        } else {
        	ratioMales = (totalMales / totalLicences)*100;
        	ratioFemales = (totalFemales / totalLicences)*100;

            proportion = String.format("%.2f %(H) - %.2f %(F)", ratioMales,ratioFemales);
        }

        return proportion;
    }
    public static String calculateProportionHF(License license,int totalLicences) {
        double totalMales = license.getTotalMales();
        double totalFemales =license.getTotalFemales();

        double ratioMales;
        double ratioFemales;
        String proportion;

        if (totalFemales == 0 && totalMales == 0) {          
                proportion = "Pas de données";
        } else {
        	ratioMales = (totalMales / totalLicences)*100;
        	ratioFemales = (totalFemales / totalLicences)*100;

            proportion = String.format("%.2f %%(H) - %.2f %%(F)", ratioMales,ratioFemales);
        }

        return proportion;
    }

}
