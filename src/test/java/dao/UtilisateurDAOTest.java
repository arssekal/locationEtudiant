package dao;

import model.Utilisateur;

public class UtilisateurDAOTest {
    public static void main(String[] args) {
        UtilisateurDAO dao = new UtilisateurDAO();

        // Test save
        Utilisateur u = new Utilisateur();
        u.setNom("Lhoussaine");
        u.setEmail("lhoussaine@test.com");
        u.setMotDePasse("123456");
        u.setRole("etudiant");
        // dao.save(u);

        // Test findByEmail
        Utilisateur u2 = dao.findByEmail("lhoussaine@test.com");
        System.out.println("Utilisateur trouvé : " + u2);

        // // Test update
        u2.setNom("LhoussaineModif");
        //dao.update(u2);

        // // Test delete
        dao.delete(u2.getId());
    }
}
