package model;

public class CalculDistance {
    
    // Rayon moyen de la Terre en kilomètres
    private final double R;

    public CalculDistance(double R) {
        this.R = R;
    }

    // Convertir les degrés en radians
    private double toRadians(double degrees) {
        return degrees * Math.PI / 180.0;
    }
    
    // Calculer la distance entre deux points géographiques en kilomètres
    public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        double deltaLat = toRadians(lat2 - lat1);
        double deltaLon = toRadians(lon2 - lon1);

        double a = Math.pow(Math.sin(deltaLat / 2), 2) + Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) * Math.pow(Math.sin(deltaLon / 2), 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        return R * c;
    }
    
    // Calculer la distance entre deux points géographiques en mètres
    public double calculateDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {
        return calculateDistance(lat1, lon1, lat2, lon2) * 1000;
    }

}
