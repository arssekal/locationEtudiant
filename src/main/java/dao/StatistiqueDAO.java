package dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

public class StatistiqueDAO {

    private SessionFactory sessionFactory;

    public StatistiqueDAO() {
        this.sessionFactory = HibernateUtil.getSessionFactory();
    }

    public StatistiqueDAO(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }




    /**
     * Récupère les statistiques pour un étudiant
     */
    public Map<String, Object> getStatistiquesEtudiant(Long utilisateurId) {
        Map<String, Object> stats = new HashMap<>();
        Session session = null;

        try {
            session = sessionFactory.openSession();

            // Nombre de favoris
            String hqlFavoris = "SELECT COUNT(f) FROM Favori f WHERE f.utilisateur.id = :userId";
            Long favorisCount = session.createQuery(hqlFavoris, Long.class)
                    .setParameter("userId", utilisateurId)
                    .uniqueResult();
            stats.put("favorisCount", favorisCount != null ? favorisCount : 0L);

            // Nombre de conversations distinctes (messages envoyés ou reçus)
            String hqlMessages =
                    "SELECT COUNT(DISTINCT contactId) " +
                            "FROM (" +
                            "   SELECT CASE WHEN m.expediteur.id = :userId THEN m.destinataire.id ELSE m.expediteur.id END AS contactId " +
                            "   FROM Message m " +
                            "   WHERE m.expediteur.id = :userId OR m.destinataire.id = :userId" +
                            ")";

            Long messagesCount = session.createQuery(hqlMessages, Long.class)
                    .setParameter("userId", utilisateurId)
                    .uniqueResult();
            stats.put("messagesCount", messagesCount != null ? messagesCount : 0L);

            // Nombre de recherches sauvegardées
            // Si vous n'avez pas de table pour les recherches sauvegardées, on met 0
            // Ou vous pouvez créer une table "recherches_sauvegardees" plus tard
            stats.put("recherchesCount", 0L);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return stats;
    }

    /**
     * Récupère les statistiques pour un propriétaire
     */
    public Map<String, Object> getStatistiquesProprietaire(Long utilisateurId) {
        Map<String, Object> stats = new HashMap<>();
        Session session = null;

        try {
            session = sessionFactory.openSession();

            // Nombre total d'annonces
            String hqlAnnonces = "SELECT COUNT(a) FROM Annonce a WHERE a.proprietaire.id = :userId";
            Long mesAnnonces = session.createQuery(hqlAnnonces, Long.class)
                    .setParameter("userId", utilisateurId)
                    .uniqueResult();
            stats.put("mesAnnonces", mesAnnonces != null ? mesAnnonces : 0L);

            // Nombre d'annonces disponibles (disponible = true)
            String hqlDisponibles = "SELECT COUNT(a) FROM Annonce a " +
                    "WHERE a.proprietaire.id = :userId AND a.disponible = true";
            Long annoncesDisponibles = session.createQuery(hqlDisponibles, Long.class)
                    .setParameter("userId", utilisateurId)
                    .uniqueResult();
            stats.put("annoncesDisponibles", annoncesDisponibles != null ? annoncesDisponibles : 0L);

            // Nombre de messages reçus (conversations distinctes avec des étudiants)
            String hqlMessagesRecus = "SELECT COUNT(DISTINCT m.expediteur.id) FROM Message m " +
                    "JOIN m.annonce a " +
                    "WHERE a.proprietaire.id = :userId AND m.destinataire.id = :userId";
            Long messagesRecus = session.createQuery(hqlMessagesRecus, Long.class)
                    .setParameter("userId", utilisateurId)
                    .uniqueResult();
            stats.put("messagesRecus", messagesRecus != null ? messagesRecus : 0L);

            // Nombre total de vues (somme des vues de toutes les annonces)
            String hqlVues = "SELECT COALESCE(SUM(a.nombreVues), 0) FROM Annonce a " +
                    "WHERE a.proprietaire.id = :userId";
            Long vuesTotal = session.createQuery(hqlVues, Long.class)
                    .setParameter("userId", utilisateurId)
                    .uniqueResult();
            stats.put("vuesTotal", vuesTotal != null ? vuesTotal : 0L);

            // Vues cette semaine depuis la table vues_annonces
            LocalDateTime oneWeekAgo = LocalDateTime.now().minus(7, ChronoUnit.DAYS);
            String hqlVuesWeek = "SELECT COUNT(v) FROM VueAnnonce v " +
                    "JOIN v.annonce a " +
                    "WHERE a.proprietaire.id = :userId AND v.dateVue >= :weekAgo";
            Long vuesThisWeek = session.createQuery(hqlVuesWeek, Long.class)
                    .setParameter("userId", utilisateurId)
                    .setParameter("weekAgo", oneWeekAgo)
                    .uniqueResult();
            stats.put("vuesThisWeek", vuesThisWeek != null ? vuesThisWeek : 0L);

        } catch (Exception e) {
            e.printStackTrace();
            // Valeurs par défaut en cas d'erreur
            if (!stats.containsKey("mesAnnonces")) stats.put("mesAnnonces", 0L);
            if (!stats.containsKey("annoncesDisponibles")) stats.put("annoncesDisponibles", 0L);
            if (!stats.containsKey("messagesRecus")) stats.put("messagesRecus", 0L);
            if (!stats.containsKey("vuesTotal")) stats.put("vuesTotal", 0L);
            if (!stats.containsKey("vuesThisWeek")) stats.put("vuesThisWeek", 0L);
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return stats;
    }

    /**
     * Récupère les statistiques globales pour l'admin
     */
    public Map<String, Object> getStatistiquesGlobales() {
        Map<String, Object> stats = new HashMap<>();
        Session session = null;

        try {
            session = sessionFactory.openSession();

            // Nombre total d'utilisateurs
            String hqlUtilisateurs = "SELECT COUNT(u) FROM Utilisateur u";
            Long totalUtilisateurs = session.createQuery(hqlUtilisateurs, Long.class)
                    .uniqueResult();
            stats.put("totalUtilisateurs", totalUtilisateurs != null ? totalUtilisateurs : 0L);

            // Nouveaux utilisateurs ce mois
            LocalDateTime debutMois = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0);
            String hqlNouveaux = "SELECT COUNT(u) FROM Utilisateur u WHERE u.dateInscription >= :debutMois";
            Long nouveauxUtilisateurs = session.createQuery(hqlNouveaux, Long.class)
                    .setParameter("debutMois", debutMois)
                    .uniqueResult();
            stats.put("nouveauxUtilisateurs", nouveauxUtilisateurs != null ? nouveauxUtilisateurs : 0L);

            // Nombre d'annonces actives (disponible = true)
            String hqlAnnoncesActives = "SELECT COUNT(a) FROM Annonce a WHERE a.disponible = true";
            Long annoncesActives = session.createQuery(hqlAnnoncesActives, Long.class)
                    .uniqueResult();
            stats.put("annoncesActives", annoncesActives != null ? annoncesActives : 0L);

            // Évolution des annonces actives (mois dernier vs ce mois)
            LocalDateTime debutMoisDernier = debutMois.minus(1, ChronoUnit.MONTHS);
            String hqlAnnoncesMoisDernier = "SELECT COUNT(a) FROM Annonce a " +
                    "WHERE a.disponible = true AND a.dateCreation < :debutMois";
            Long annoncesMoisDernier = session.createQuery(hqlAnnoncesMoisDernier, Long.class)
                    .setParameter("debutMois", debutMois)
                    .uniqueResult();

            if (annoncesMoisDernier != null && annoncesMoisDernier > 0) {
                double evolution = ((annoncesActives - annoncesMoisDernier) * 100.0) / annoncesMoisDernier;
                stats.put("annoncesActivesEvolution", evolution);
            } else {
                stats.put("annoncesActivesEvolution", 0.0);
            }

            // Nombre total de messages
            String hqlMessages = "SELECT COUNT(m) FROM Message m";
            Long totalMessages = session.createQuery(hqlMessages, Long.class)
                    .uniqueResult();
            stats.put("totalMessages", totalMessages != null ? totalMessages : 0L);

            // Messages cette semaine
            LocalDateTime oneWeekAgo = LocalDateTime.now().minus(7, ChronoUnit.DAYS);
            String hqlMessagesWeek = "SELECT COUNT(m) FROM Message m WHERE m.dateEnvoi >= :weekAgo";
            Long messagesThisWeek = session.createQuery(hqlMessagesWeek, Long.class)
                    .setParameter("weekAgo", oneWeekAgo)
                    .uniqueResult();
            stats.put("messagesThisWeek", messagesThisWeek != null ? messagesThisWeek : 0L);

            // Taux de satisfaction (calculé ou fixe)
            stats.put("tauxSatisfaction", 95);

        } catch (Exception e) {
            e.printStackTrace();
            // Valeurs par défaut en cas d'erreur
            if (!stats.containsKey("totalUtilisateurs")) stats.put("totalUtilisateurs", 0L);
            if (!stats.containsKey("nouveauxUtilisateurs")) stats.put("nouveauxUtilisateurs", 0L);
            if (!stats.containsKey("annoncesActives")) stats.put("annoncesActives", 0L);
            if (!stats.containsKey("annoncesActivesEvolution")) stats.put("annoncesActivesEvolution", 0.0);
            if (!stats.containsKey("totalMessages")) stats.put("totalMessages", 0L);
            if (!stats.containsKey("messagesThisWeek")) stats.put("messagesThisWeek", 0L);
            if (!stats.containsKey("tauxSatisfaction")) stats.put("tauxSatisfaction", 95);
        } finally {
            if (session != null) {
                session.close();
            }
        }

        return stats;
    }

    /**
     * Fermeture propre de la SessionFactory (à appeler lors de l'arrêt de l'application)
     */
    public void close() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}