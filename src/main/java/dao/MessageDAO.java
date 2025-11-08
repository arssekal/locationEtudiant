package dao;

import model.Message;
import model.Utilisateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import java.time.LocalDateTime;
import java.util.List;

public class MessageDAO {
    private SessionFactory sessionFactory;

    public MessageDAO(){
        try {
            sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
        }catch (Exception e){
            System.err.println("Erreur de l'initialisation de SessionFactory : " + e.getMessage());
            e.printStackTrace();
        }

    }

    // Créer un nouveau message
    public void creerMessage(Message message) {
        EntityManager em = sessionFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            message.setDateEnvoi(LocalDateTime.now());
            message.setLu(false);
            em.persist(message);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // Récupérer tous les messages reçus par un utilisateur
    public List<Message> getMessagesRecus(Long utilisateurId) {
        EntityManager em = sessionFactory.createEntityManager();
        try {
            TypedQuery<Message> query = em.createQuery(
                    "SELECT m FROM Message m WHERE m.destinataire.id = :userId ORDER BY m.dateEnvoi DESC",
                    Message.class
            );
            query.setParameter("userId", utilisateurId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Récupérer tous les messages envoyés par un utilisateur
    public List<Message> getMessagesEnvoyes(Long utilisateurId) {
        EntityManager em = sessionFactory.createEntityManager();
        try {
            TypedQuery<Message> query = em.createQuery(
                    "SELECT m FROM Message m WHERE m.expediteur.id = :userId ORDER BY m.dateEnvoi DESC",
                    Message.class
            );
            query.setParameter("userId", utilisateurId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Récupérer un message par son ID
    public Message getMessageById(Long id) {
        EntityManager em = sessionFactory.createEntityManager();
        try {
            return em.find(Message.class, id);
        } finally {
            em.close();
        }
    }

    // Marquer un message comme lu
    public void marquerCommeLu(Long messageId) {
        EntityManager em = sessionFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            Message message = em.find(Message.class, messageId);
            if (message != null) {
                message.setLu(true);
                em.merge(message);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // Supprimer un message
    public void supprimerMessage(Long messageId) {
        EntityManager em = sessionFactory.createEntityManager();
        try {
            em.getTransaction().begin();
            Message message = em.find(Message.class, messageId);
            if (message != null) {
                em.remove(message);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // Compter les messages non lus d'un utilisateur
    public long compterMessagesNonLus(Long utilisateurId) {
        EntityManager em = sessionFactory.createEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(m) FROM Message m WHERE m.destinataire.id = :userId AND m.lu = false",
                    Long.class
            );
            query.setParameter("userId", utilisateurId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Récupérer les messages liés à une annonce
    public List<Message> getMessagesParAnnonce(Long annonceId) {
        EntityManager em = sessionFactory.createEntityManager();
        try {
            TypedQuery<Message> query = em.createQuery(
                    "SELECT m FROM Message m WHERE m.annonce.id = :annonceId ORDER BY m.dateEnvoi DESC",
                    Message.class
            );
            query.setParameter("annonceId", annonceId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void close() {
        if (sessionFactory != null && sessionFactory.isOpen()) {
            sessionFactory.close();
        }
    }
}