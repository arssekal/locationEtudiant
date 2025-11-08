package controller;

import dao.StatistiqueDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import model.Utilisateur;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import util.HibernateUtil;

import java.io.IOException;
import java.sql.Connection;
import java.util.Map;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        try (Session hibernateSession = sessionFactory.openSession()) {
            StatistiqueDAO statistiqueDAO = new StatistiqueDAO((SessionFactory) hibernateSession);
            Map<String, Object> stats = null;

            switch (utilisateur.getRole().toLowerCase()) {
                case "etudiant":
                    stats = statistiqueDAO.getStatistiquesEtudiant((long) utilisateur.getId().intValue());
                    break;

                case "proprietaire":
                    stats = statistiqueDAO.getStatistiquesProprietaire((long) utilisateur.getId().intValue());
                    break;

                default:
                    stats = statistiqueDAO.getStatistiquesGlobales();
            }

            request.setAttribute("stats", stats);
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des statistiques");
            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        }
    }
}
