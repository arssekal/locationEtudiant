package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Utilisateur;
import service.UtilisateurService;

import java.io.IOException;

public class UtilisateurServlet extends HttpServlet {
    private final UtilisateurService utilisateurService = new UtilisateurService();

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");

        if(action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
            return;
        }
        if("inscription".equalsIgnoreCase(action)) {
            traiterInscription(request, response);
        }
        else if("connexion".equalsIgnoreCase(action)) {
            traiterConnexion(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
        }
    }

    private void traiterInscription(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        String role = request.getParameter("role");

        Utilisateur utilisateur = new Utilisateur(nom, email, motDePasse, role);
        boolean success = utilisateurService.inscrire(utilisateur);

        if (success) {
            response.sendRedirect("jsp/login.jsp?success=1");
        } else {
            request.setAttribute("messageErreur", "Inscription échouée. Vérifiez vos informations !");
            request.getRequestDispatcher("jsp/inscription.jsp").forward(request, response);
        }
    }

    private void traiterConnexion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        Utilisateur utilisateur = utilisateurService.connecter(email, motDePasse);

        if(utilisateur != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateur);
            response.sendRedirect("tableau_de_bord.jsp");
        } else {
            request.setAttribute("messageErreur", "Email ou mot de passe incorrect !");
            request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
        }
    }

}
