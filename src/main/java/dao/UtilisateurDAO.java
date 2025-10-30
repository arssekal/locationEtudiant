package dao;

import model.Utilisateur;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;
import jakarta.persistence.NoResultException;

public class UtilisateurDAO {

    public void save(Utilisateur utilisateur) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();

            session.persist(utilisateur);

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
    }


    public void update(Utilisateur utilisateurModifie) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            int id = utilisateurModifie.getId();
            Utilisateur utilisateurExistant = session.find(Utilisateur.class, id);
            if (utilisateurExistant != null) {
                transaction = session.beginTransaction();
                utilisateurExistant.setNom(utilisateurModifie.getNom());
                utilisateurExistant.setEmail(utilisateurModifie.getEmail());
                utilisateurExistant.setMotDePasse(utilisateurModifie.getMotDePasse());
                utilisateurExistant.setRole(utilisateurModifie.getRole());

                session.merge(utilisateurExistant);
                transaction.commit();
                System.out.println("Utilisateur mis à jour !");
            } else {
                throw new RuntimeException("Utilisateur avec id: "+ utilisateurModifie.getId() +" n'est pas trouvé");
            }
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException("Erreur lors de l'enregistrement de l'utilisateur", e);
        }
    }

    public void delete(int id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Utilisateur utilisateur = session.find(Utilisateur.class, id);
            if (utilisateur != null) session.remove(utilisateur);
            else  throw new RuntimeException("Utilisateur avec ID " + id + " introuvable.");
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException("Erreur lors de suppression de l'utilisateur", e);
        }
    }
    public Utilisateur findById(int id) throws RuntimeException {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Utilisateur utilisateur = session.find(Utilisateur.class, id);
            if (utilisateur == null) {
                throw new RuntimeException("Utilisateur avec ID " + id + " introuvable.");
            }
            return utilisateur;
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la recherche de l'utilisateur", e);
        }
    }

    public Utilisateur findByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            try {
                return session.createQuery("FROM Utilisateur WHERE email = :email", Utilisateur.class)
                        .setParameter("email", email)
                        .getSingleResult();
            } catch (NoResultException e) {
                return null;
            }
        }
    }
}
