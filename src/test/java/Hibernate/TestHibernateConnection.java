package Hibernate;

import model.Utilisateur;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class TestHibernateConnection {
    public static void main(String[] args) {
        Session session = null;
        Transaction tx = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            System.out.println("✅ Connexion Hibernate réussie !");

            // Test d'insertion
            Utilisateur user = new Utilisateur();
            user.setEmail("lilomimi266@gmail.com");
            user.setMotDePasse("Svvw2098");
            user.setNom("Mehdaoui");
            user.setPrenom("Zakariya");
            user.setRole("ETUDIANT");  // String au lieu d'enum

            session.persist(user);
            tx.commit();

            System.out.println("✅ Utilisateur créé : " + user);

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            System.err.println("❌ Erreur : " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }
}