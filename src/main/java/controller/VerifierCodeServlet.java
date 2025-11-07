package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class VerifierCodeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, IOException, ServletException {
        String codeSaisi = request.getParameter("code");
        int codeAttendu = (int) request.getSession().getAttribute("codeVerification");

        if (String.valueOf(codeAttendu).equals(codeSaisi)) {
            request.getSession().setAttribute("isVerified", true);
            response.sendRedirect(request.getContextPath() + "/utilisateur/dashboard");
        } else {
            request.setAttribute("erreur", "Code de vérification est incorrect !");
            request.getRequestDispatcher("/WEB-INF/jsp/verifier_code.jsp").forward(request, response);
        }
    }
}