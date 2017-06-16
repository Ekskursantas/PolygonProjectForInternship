/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Presentation;

import Domain.DomainFacade;
import Domain.UserPrefs;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "Authenticate", urlPatterns = {"/Authenticate"})
public class Authenticate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //-- Establish or reestablish application demainModeltext
            HttpSession sessionObj = request.getSession();
            DomainFacade domainModel = (DomainFacade) sessionObj.getAttribute("Controller");
            if (domainModel == null)
            {
                // Session starts
                domainModel = DomainFacade.getInstance();
                sessionObj.setAttribute("Controller", domainModel);
            } else
            {
                domainModel = (DomainFacade) sessionObj.getAttribute("Controller");
            }

            //-- Identify command and delegate job
            String command = request.getParameter("command");
            switch (command) {
                case "login":
                    authenticate(request,response,domainModel);
                    break;
                case "logout":
                    request.getSession().invalidate();
                    request.logout();
                    RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
                    rd.forward(request, response);
                    break;
            }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void authenticate(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        UserPrefs userPrefs = domainModel.authenticate(email,password);
        //If login was successful:
        if (userPrefs != null) {
            request.getSession().setAttribute("UserPrefs", userPrefs);
            request.setAttribute("errorMessage","Logged in. All good.");
        }
        else {
            RequestDispatcher rd = request.getRequestDispatcher("Login.jsp?mismatch=true");
            rd.forward(request, response);
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("MyAccount.jsp");
        rd.forward(request, response);
    }

    

}
