package test.java.db;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import org.hibernate.Session;
import util.HibernateUtil;

@WebServlet("/test-connexion")  // ✅ Annotation pour mapper l'URL
public class TestConnexionServlet extends HttpServlet {  // ✅ Déclaration de classe manquante !

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/plain;charset=UTF-8");

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            if (session.isConnected()) {
                resp.getWriter().println("✅ Connexion Hibernate/MySQL réussie !");
            } else {
                resp.getWriter().println("❌ La session Hibernate n'est pas connectée.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("❌ Erreur : " + e.getMessage());
        }
    }
}