package model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class FederationUtils {

	 public static ArrayList<String> extractFederations(ArrayList<Federation> federations) {
	        Set<String> federationsSet = new HashSet<>();
	        for (Federation federation : federations) {
	        	federationsSet.add(federation.getFederation());
	        }
	        return new ArrayList<>(federationsSet);
	    }
    public static ArrayList<String> extractDepartements(ArrayList<Federation> federations) {
        Set<String> departements = new HashSet<>();
        for (Federation federation : federations) {
            departements.add(federation.getDepartement());
        }
        return new ArrayList<>(departements);
    }

    public static ArrayList<String> extractCommunes(ArrayList<Federation> federations) {
        Set<String> communes = new HashSet<>();
        for (Federation federation : federations) {
            communes.add(federation.getCommune());
        }
        return new ArrayList<>(communes);
    }

    public static ArrayList<String> extractRegions(ArrayList<Federation> federations) {
        Set<String> regions = new HashSet<>();
        for (Federation federation : federations) {
            regions.add(federation.getRegion());
        }
        return new ArrayList<>(regions);
    }
}
