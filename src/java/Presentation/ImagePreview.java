/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Presentation;

import com.google.gson.Gson;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "ImagePreview", urlPatterns = {"/ImagePreview"})
public class ImagePreview extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private List imageUrlList = new ArrayList();
    // Location where the pictures will be received from. (It is the same location as in the Upload Servlet in most cases)
    private static final String UPLOAD_PATH 
    = "/var/lib/tomcat8/webapps/POLYGON/BuildingImages/";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String b_id = request.getParameter("b_id");
        imageUrlList.clear();
        try {
            File f = new File(UPLOAD_PATH + b_id);

            for (File imageFile : f.listFiles()) {
                System.out.println(imageFile.getName());
                String imageFileName = "BuildingImages" + "/" +  b_id + "/" + imageFile.getName();
                
                // add this images name to the list we are building up
                
                imageUrlList.add(imageFileName);

            }
        } catch (Exception ex) {
            request.setAttribute("message",
                    "File does not exist");
            RequestDispatcher rd = request.getRequestDispatcher("message.jsp");
            rd.forward(request, response);
        }
        String output = new Gson().toJson(imageUrlList);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(output);

    }

}
