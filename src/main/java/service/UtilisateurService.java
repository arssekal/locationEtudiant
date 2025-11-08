package service;

import dao.UtilisateurDAO;
import model.Utilisateur;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class UtilisateurService {
    private final UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    public List<String> inscrire(Utilisateur utilisateur, String confirmerMotPass) {
        if(!"etudiant".equals(utilisateur.getRole()) && !"proprietaire".equals(utilisateur.getRole())) return new ArrayList<>(Collections.singletonList("role doit étre soit Etudiant soit Proprietaire!"));
        List<String> erreurs = validerUtilisateur(utilisateur);
        if(!confirmerMotPass.equals(utilisateur.getMotDePasse())) {
            erreurs.add("Les mots de passe ne correspondent pas.");
        }
        if(!erreurs.isEmpty()) return erreurs;
        utilisateurDAO.save(utilisateur);
        return erreurs;
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

    public List<String> updateUtilisateur(Utilisateur utilisateur) {
        List<String> erreurs = new ArrayList<>();
        if(utilisateur.getNom().isEmpty()) erreurs.add("Nom Obligatoire");
        if(!validerEmail(utilisateur.getEmail())) erreurs.add("Email invalide");
        if(!validerMotDePasse(utilisateur.getMotDePasse())) erreurs.add("Le mot de passe doit contenir au moins 8 caractères, une lettre et un chiffre");
        utilisateurDAO.update(utilisateur);
        return erreurs;
    }

    public Utilisateur getUtilisateurParId(Long id) {
        return utilisateurDAO.findById(id);
    }
}
