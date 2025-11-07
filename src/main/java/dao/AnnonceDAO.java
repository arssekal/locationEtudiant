package dao;

import model.Annonce;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.List;

public class AnnonceDAO {

    private SessionFactory sessionFactory;

    public AnnonceDAO(){
        try {
            sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
        }catch (Exception e){
            System.err.println("Erreur de l'initialisation de SessionFactory : " + e.getMessage());
            e.printStackTrace();
        }

    }


    public boolean CreateAnnonce(Annonce annonce){
        Transaction transaction = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();



            // Vérifications
            if (annonce.getProprietaire() == null) {
                throw new IllegalArgumentException("Le propriétaire est obligatoire");
            }

            if (!"PROPRIETAIRE".equalsIgnoreCase(annonce.getProprietaire().getRole())) {
                throw new IllegalArgumentException("Seuls les propriétaires peuvent créer des annonces. Rôle actuel: " + annonce.getProprietaire().getRole());
            }

            if (annonce.getDisponible() == null) {
                annonce.setDisponible(true);
            }

            session.persist(annonce);
            transaction.commit();
            System.out.println("✅ Annonce créée avec succès - ID: " + annonce.getId());
            return true;

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            System.err.println("❌ Erreur lors de la création de l'annonce: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public boolean updateAnnonce(Annonce annonce, Long proprietaireId) {
        Transaction transaction = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            Annonce annonceExistante = session.find(Annonce.class, annonce.getId());

            if (annonceExistante == null) {
                throw new IllegalArgumentException("Annonce introuvable avec id : " + annonce.getId());
            }

            // ✅ CORRECTION: Comparer avec proprietaireId
            if (!annonceExistante.getProprietaire().getId().equals(proprietaireId)) {
                throw new SecurityException("Vous n'êtes pas autorisé à modifier cette annonce");
            }

            // Garder le propriétaire d'origine
            annonce.setProprietaire(annonceExistante.getProprietaire());

            session.merge(annonce);
            transaction.commit();

            System.out.println("✅ Annonce mise à jour avec succès - ID: " + annonce.getId());
            return true;

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            System.err.println("❌ Erreur: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
        }
    }

    public boolean marquerNonDisponible(Long annonceId, Long proprietaireId) {
        Transaction transaction = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            Annonce annonce = session.find(Annonce.class, annonceId);

            if (annonce == null) {
                throw new IllegalArgumentException("Annonce introuvable avec id : " + annonceId);
            }

            // ✅ CORRECTION: Comparer avec proprietaireId
            if (!annonce.getProprietaire().getId().equals(proprietaireId)) {
                throw new SecurityException("Vous n'êtes pas autorisé à modifier cette annonce");
            }

            annonce.setDisponible(false);
            session.merge(annonce);
            transaction.commit();

            System.out.println("✅ Annonce marquée comme non disponible - ID: " + annonceId);
            return true;

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            System.err.println("❌ Erreur: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
        }
    }

    public boolean reactiverAnnonce(Long annonceId, Long proprietaireId) {
        Transaction transaction = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            Annonce annonce = session.find(Annonce.class, annonceId);

            if (annonce == null) {
                throw new IllegalArgumentException("Annonce introuvable avec id : " + annonceId);
            }

            // ✅ CORRECTION: Comparer avec proprietaireId
            if (!annonce.getProprietaire().getId().equals(proprietaireId)) {
                throw new SecurityException("Vous n'êtes pas autorisé à modifier cette annonce");
            }

            annonce.setDisponible(true);
            session.merge(annonce);
            transaction.commit();

            System.out.println("✅ Annonce réactivée - ID: " + annonceId);
            return true;

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            System.err.println("❌ Erreur: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
        }
    }

    public boolean deleteAnnonce(Long annonceId, Long proprietaireId) {
        Transaction transaction = null;
        Session session = null;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            Annonce annonce = session.find(Annonce.class, annonceId);

            if (annonce == null) {
                throw new IllegalArgumentException("Annonce introuvable avec id : " + annonceId);
            }

            // ✅ CORRECTION: Comparer avec proprietaireId
            if (!annonce.getProprietaire().getId().equals(proprietaireId)) {
                throw new SecurityException("Vous n'êtes pas autorisé à supprimer cette annonce");
            }

            session.remove(annonce);
            transaction.commit();

            System.out.println("✅ Annonce supprimée - ID: " + annonceId);
            return true;

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            System.err.println("❌ Erreur: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
        }
    }



    public Annonce getAnnonceById(Long id) {
        Session session = null;
        Transaction transaction = null;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            System.out.println("🔍 Recherche de l'annonce ID: " + id);

            // Récupérer l'annonce (le propriétaire sera chargé automatiquement avec EAGER)
            Annonce annonce = session.find(Annonce.class, id);

            if (annonce != null) {
                System.out.println("✅ Annonce trouvée: " + annonce.getTitre());
                System.out.println("✅ Ville: " + annonce.getVille());
                System.out.println("✅ Prix: " + annonce.getPrix());

                if (annonce.getProprietaire() != null) {
                    System.out.println("✅ Propriétaire: " + annonce.getProprietaire().getNom() );
                    System.out.println("✅ Email propriétaire: " + annonce.getProprietaire().getEmail());

                } else {
                    System.out.println("⚠️ Propriétaire NULL");
                }
            } else {
                System.out.println("❌ Aucune annonce trouvée pour l'ID: " + id);
            }

            transaction.commit();
            return annonce;

        } catch (Exception e) {
            if (transaction != null) {
                try {
                    transaction.rollback();
                    System.out.println("🔄 Transaction rollback effectué");
                } catch (Exception rollbackEx) {
                    System.err.println("❌ Erreur lors du rollback: " + rollbackEx.getMessage());
                }
            }
            System.err.println("❌ Erreur lors de la récupération de l'annonce ID " + id + ": " + e.getMessage());
            e.printStackTrace();
            return null;

        } finally {
            if (session != null && session.isOpen()) {
                session.close();
                System.out.println("🔒 Session fermée");
            }
        }
    }


    public List<Annonce> getAllAnnoncesDisponibles() {
        Session session = null;
        Transaction transaction = null;

        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();

            System.out.println("🔍 Récupération de toutes les annonces disponibles...");

            // Utiliser JOIN FETCH pour charger le propriétaire en une seule requête
            String hql = "SELECT DISTINCT a FROM Annonce a " +
                    "LEFT JOIN FETCH a.proprietaire " +
                    "WHERE a.disponible = true " +
                    "ORDER BY a.id DESC";

            Query<Annonce> query = session.createQuery(hql, Annonce.class);
            List<Annonce> annonces = query.list();

            System.out.println("✅ Nombre d'annonces disponibles trouvées: " + annonces.size());

            // Log quelques détails
            for (Annonce annonce : annonces) {
                if (annonce.getProprietaire() != null) {
                    System.out.println("   - " + annonce.getTitre() + " (Propriétaire: " +
                            annonce.getProprietaire().getNom() + ")");
                } else {
                    System.out.println("   - " + annonce.getTitre() + " (⚠️ Propriétaire NULL)");
                }
            }

            transaction.commit();
            return annonces;

        } catch (Exception e) {
            if (transaction != null) {
                try {
                    transaction.rollback();
                    System.out.println("🔄 Transaction rollback effectué");
                } catch (Exception rollbackEx) {
                    System.err.println("❌ Erreur lors du rollback: " + rollbackEx.getMessage());
                }
            }
            System.err.println("❌ Erreur lors de la récupération des annonces disponibles: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();

        } finally {
            if (session != null && session.isOpen()) {
                session.close();
                System.out.println("🔒 Session fermée");
            }
        }
    }
         public List<Annonce> getAllAnnonces(){
        Session session = null ;

        try {
            session = sessionFactory.openSession();

            String hql = "FROM Annonce a ORDER BY  a.id DESC";

            Query<Annonce> query = session.createQuery(hql,Annonce.class);

            List<Annonce> annonces = query.list();

            for (Annonce annonce : annonces) {
                annonce.getProprietaire().getNom() ;

            }
            return annonces;
        }catch (Exception e){
            System.err.println("Erreur de l'annonce de l'id : " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();

        }finally{
            if (session != null){
                session.close();
            }
        }
         }
    public List<Annonce> getAnnoncesByProprietaire(Long proprietaireId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            String hql = "FROM Annonce a WHERE a.proprietaire.id = :proprietaireId " +
                    "ORDER BY a.id DESC";
            Query<Annonce> query = session.createQuery(hql, Annonce.class);
            query.setParameter("proprietaireId", proprietaireId);

            List<Annonce> annonces = query.list();

            for (Annonce annonce : annonces) {
                annonce.getProprietaire().getNom();
            }

            return annonces;

        } catch (Exception e) {
            System.err.println("Erreur lors de la récupération des annonces du propriétaire: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();

        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    /**
     * Rechercher des annonces par ville
     * @param ville Le nom de la ville
     * @return Liste des annonces dans cette ville
     */
    public List<Annonce> rechercherParVille(String ville) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            String hql = "FROM Annonce a WHERE LOWER(a.ville) LIKE LOWER(:ville) " +
                    "AND a.disponible = true ORDER BY a.id DESC";
            Query<Annonce> query = session.createQuery(hql, Annonce.class);
            query.setParameter("ville", "%" + ville + "%");

            List<Annonce> annonces = query.list();

            for (Annonce annonce : annonces) {
                annonce.getProprietaire().getNom();
            }

            return annonces;

        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche par ville: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();

        } finally {
            if (session != null) {
                session.close();
            }
        }
    }


    public List<Annonce> rechercherParPrix(Double prixMax) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            String hql = "FROM Annonce a WHERE a.prix <= :prixMax " +
                    "AND a.disponible = true ORDER BY a.prix ASC";
            Query<Annonce> query = session.createQuery(hql, Annonce.class);
            query.setParameter("prixMax", prixMax);

            List<Annonce> annonces = query.list();

            for (Annonce annonce : annonces) {
                annonce.getProprietaire().getNom();
            }

            return annonces;

        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche par prix: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();

        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    /**
     * Rechercher des annonces par type
     * @param type Le type de logement (Studio, T1, T2, etc.)
     * @return Liste des annonces de ce type
     */
    public List<Annonce> rechercherParType(String type) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            String hql = "FROM Annonce a WHERE a.type = :type " +
                    "AND a.disponible = true ORDER BY a.id DESC";
            Query<Annonce> query = session.createQuery(hql, Annonce.class);
            query.setParameter("type", type);

            List<Annonce> annonces = query.list();

            for (Annonce annonce : annonces) {
                annonce.getProprietaire().getNom();
            }

            return annonces;

        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche par type: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();

        } finally {
            if (session != null) {
                session.close();
            }
        }
    }







    public Long countAnnoncesByProprietaire(Long proprietaireId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();
            String hql = "SELECT COUNT(a) FROM Annonce a WHERE a.proprietaire.id = :proprietaireId";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("proprietaireId", proprietaireId);

            Long count = query.uniqueResult();
            return count != null ? count : 0L;

        } catch (Exception e) {
            System.err.println("Erreur lors du comptage des annonces: " + e.getMessage());
            e.printStackTrace();
            return 0L;

        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    public void close() {
        if (sessionFactory != null && !sessionFactory.isClosed()) {
            sessionFactory.close();
            System.out.println("SessionFactory fermée");
        }
    }

    public Long countAnnoncesDisponiblesByProprietaire(Long proprietaireId) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            String hql = "SELECT COUNT(a) FROM Annonce a WHERE a.proprietaire.id = :proprietaireId " +
                    "AND a.disponible = true";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("proprietaireId", proprietaireId);

            Long count = query.uniqueResult();
            return count != null ? count : 0L;

        } catch (Exception e) {
            System.err.println("Erreur lors du comptage des annonces disponibles: " + e.getMessage());
            e.printStackTrace();
            return 0L;

        } finally {
            if (session != null) {
                session.close();
            }
        }




    }

    public List<Annonce> rechercheAvancee(String ville, Double prixMax, String type, Integer nbChambresMin) {
        Session session = null;
        try {
            session = sessionFactory.openSession();

            StringBuilder hql = new StringBuilder("FROM Annonce a WHERE a.disponible = true");

            if (ville != null && !ville.trim().isEmpty()) {
                hql.append(" AND LOWER(a.ville) LIKE LOWER(:ville)");
            }
            if (prixMax != null && prixMax > 0) {
                hql.append(" AND a.prix <= :prixMax");
            }
            if (type != null && !type.trim().isEmpty()) {
                hql.append(" AND a.type = :type");
            }
            if (nbChambresMin != null && nbChambresMin > 0) {
                hql.append(" AND a.nbChambres >= :nbChambresMin");
            }

            hql.append(" ORDER BY a.datePublication DESC");

            Query<Annonce> query = session.createQuery(hql.toString(), Annonce.class);

            if (ville != null && !ville.trim().isEmpty()) {
                query.setParameter("ville", "%" + ville + "%");
            }
            if (prixMax != null && prixMax > 0) {
                query.setParameter("prixMax", prixMax);
            }
            if (type != null && !type.trim().isEmpty()) {
                query.setParameter("type", type);
            }
            if (nbChambresMin != null && nbChambresMin > 0) {
                query.setParameter("nbChambresMin", nbChambresMin);
            }

            List<Annonce> annonces = query.list();

            for (Annonce annonce : annonces) {
                annonce.getProprietaire().getNom();
            }

            return annonces;

        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche avancée: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();

        } finally {
            if (session != null) {
                session.close();
            }
        }
    }




}
