package service;

import dao.UtilisateurDAO;
import model.Utilisateur;

import java.util.ArrayList;
import java.util.List;

public class UtilisateurService {
    private final UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    public  boolean inscrire(Utilisateur utilisateur) {
        if(!validerUtilisateur(utilisateur).isEmpty()) return false;
        utilisateurDAO.save(utilisateur);
        return true;
    }
    public Utilisateur connecter(String email, String motDePasse) {
        if(!validerEmail(email) || !validerMotDePasse(motDePasse)) return null;
        Utilisateur utilisateur = utilisateurDAO.findByEmail(email);
        if (utilisateur == null) return null;
        if(motDePasse.equals(utilisateur.getMotDePasse())) return utilisateur;
        return null;
    }
    public  boolean emailExiste(String email) {
        Utilisateur utilisateur = utilisateurDAO.findByEmail(email);
        return utilisateur != null;
    }

    public  boolean validerMotDePasse(String motDePasse) {
        boolean longueurOk =  motDePasse.length() >= 8;
        boolean contientLettre = motDePasse.matches(".*[A-Za-zÀ-ÿ].*");
        boolean contientChiffre = motDePasse.matches(".*[0-9].*");

        return longueurOk && contientLettre && contientChiffre;
    }

    public boolean validerEmail(String email) {
        if (email == null || email.isEmpty()) {
            return false;
        }
        String regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email.matches(regex);
    }

    public List<String> validerUtilisateur(Utilisateur utilisateur) {
        List<String> erreurs = new ArrayList<>();
        if(utilisateur.getNom().isEmpty()) erreurs.add("Nom Obligatoire");
        if(!validerEmail(utilisateur.getEmail())) erreurs.add("Email invalide");
        if (emailExiste(utilisateur.getEmail())) erreurs.add("Cet email est déjà utilisé");
        if(!validerMotDePasse(utilisateur.getMotDePasse())) erreurs.add("Le mot de passe doit contenir au moins 8 caractères, une lettre et un chiffre");
        return erreurs;
    }
}
