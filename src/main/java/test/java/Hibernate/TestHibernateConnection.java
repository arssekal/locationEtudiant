package Hibernate;

import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;
public class TestHibernateConnection {
    public static void main(String[] args) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            System.out.println("✅ Connexion Hibernate réussie !");
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Erreur de connexion Hibernate !");
        }
    }
}
