package util;

import model.Utilisateur;
import model.Annonce;
import model.Message;
import model.Favori;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.service.ServiceRegistry;

public class HibernateUtil {

    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            // Charger le fichier hibernate.cfg.xml
            Configuration configuration = new Configuration();
            configuration.configure("hibernate.cfg.xml");

            // ✅ AJOUT EXPLICITE DES ENTITÉS
            configuration.addAnnotatedClass(Utilisateur.class);
            configuration.addAnnotatedClass(Annonce.class);
            configuration.addAnnotatedClass(Message.class);
            configuration.addAnnotatedClass(Favori.class);

            // Créer le ServiceRegistry
            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                    .applySettings(configuration.getProperties())
                    .build();

            // Construire la SessionFactory
            SessionFactory sessionFactory = configuration.buildSessionFactory(serviceRegistry);

            System.out.println("✅ Hibernate initialisé avec succès !");
            return sessionFactory;
        } catch (Throwable ex) {
            System.err.println("❌ Erreur d'initialisation Hibernate : " + ex);
            ex.printStackTrace();
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        if (sessionFactory != null) {
            sessionFactory.close();
            System.out.println("✅ SessionFactory fermée");
        }
    }
}