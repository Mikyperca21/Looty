package model;

public enum Dimensione {
    S, M, L;

    public static Dimensione fromString(String str) {
        for (Dimensione d : Dimensione.values()) {
            if (d.name().equalsIgnoreCase(str)) {
                return d;
            }
        }
        throw new IllegalArgumentException("Valore non valido per Dimensione: " + str);
    }
}
