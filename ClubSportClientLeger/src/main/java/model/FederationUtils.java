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
    public static ArrayList<String> extractDepartements(ArrayList<Federation> federations,String nomRegion ) {
        Set<String> departements = new HashSet<>();
        if(nomRegion!=null && !nomRegion.isEmpty()) {
        for (Federation federation : federations) {
        		if(federation.getRegion() != null && federation.getRegion().equals(nomRegion))
        				departements.add(federation.getDepartement());
        	}
        }
       	if (nomRegion==null || nomRegion.isEmpty()) {
       		for (Federation federation : federations) {
        				departements.add(federation.getDepartement());
        	}
       	}
        return new ArrayList<>(departements);
    }

    public static ArrayList<String> extractCommunes(ArrayList<Federation> federations,String codeDepartement) {
        Set<String> communes = new HashSet<>();
        if(codeDepartement!=null && !codeDepartement.isEmpty()) {        	
	        for (Federation federation : federations) {
	        	if(federation.getDepartement()!=null && federation.getDepartement().equals(codeDepartement))
	            communes.add(federation.getCommune());
	        }
        }
        if(codeDepartement==null || codeDepartement.isEmpty()) {        	        	
            for (Federation federation : federations) {
                communes.add(federation.getCommune());
            }
        }
        return new ArrayList<>(communes);
    }

    public static ArrayList<String> extractRegions(ArrayList<Federation> federations,String nomFederation) {
        Set<String> regions = new HashSet<>();
        if(nomFederation!=null && !nomFederation.isEmpty()) {        	
		        for (Federation federation : federations) {
		        	if(federation.getFederation()!=null && federation.getFederation().equals(nomFederation))
		            regions.add(federation.getRegion());
		        }
	     }
        if(nomFederation==null || nomFederation.isEmpty()) {        	
	        for (Federation federation : federations) {
	            regions.add(federation.getRegion());
	        }
     }
        return new ArrayList<>(regions);
    }
}
