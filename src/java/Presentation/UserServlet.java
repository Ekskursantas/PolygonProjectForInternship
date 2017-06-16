/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Presentation;

import Domain.Building;
import Domain.CheckupReport;
import Domain.Customer;
import Domain.DomainFacade;
import Domain.Employee;
import Domain.ServiceRequest;
import Domain.UserPrefs;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        //-- Establish or reestablish application demainModeltext
        HttpSession sessionObj = request.getSession();
        DomainFacade domainModel = (DomainFacade) sessionObj.getAttribute("Controller");
        if (domainModel == null) {
            // Session starts
            domainModel = DomainFacade.getInstance();
            sessionObj.setAttribute("Controller", domainModel);
        } else {
            domainModel = (DomainFacade) sessionObj.getAttribute("Controller");
        }

        //-- Identify command and delegate job
        String command = request.getParameter("command");
        switch (command) {
            case "addBuilding":
                addBuilding(request, response, domainModel);
                break;
            case "addCustomer":
                createCustomer(request, response, domainModel);
                break;
            case "showCustomers":
                showCustomers(request, response, domainModel);
                break;
            case "updateCheckupReport":
                updateCheckupReport(request, response, domainModel);
                break;
            case "showCheckupReports":
                showActiveCheckupReports(request, response, domainModel);
                showDoneCheckupReports(request, response, domainModel);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Reports.jsp");
                dispatcher.forward(request, response);
                break;
            case "requestCheckup":
                requestCheckup(request, response, domainModel);

                break;
            case "selectReport":
                selectReport(request, response, domainModel);
                break;
            case "selectFinishedReport":
                selectFinishedReport(request, response, domainModel);
                break;
            case "serviceRequest":
                saveServiceRequest(request, response, domainModel);
                break;
            case "takeServiceRequest":
                //get this parameter: srequest_id
                takeServiceRequest(request, response, domainModel);
                break;
            case "editBuilding":
                editBuilding(request, response, domainModel);
                break;
            case "saveBuildingEdits":
                saveBuildingEdits(request, response, domainModel);
                break;
            case "addRoom":
                addRoom(request, response, domainModel);
                break;
            case "assignEmployee":
                assignEmployee(request, response, domainModel);
                break;
            case "addEmployee":
                addEmployee(request, response, domainModel);
                break;

        }
    }

    private void saveBuildingEdits(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        //Receive relevant parameters
        String b_name, street;
        int zip, size, condition_level, parcel_no, buildingID;
        buildingID = Integer.parseInt(request.getParameter("building_id"));
        b_name = request.getParameter("b_name");
        street = request.getParameter("street");
        zip = Integer.parseInt(request.getParameter("zip"));
        size = Integer.parseInt(request.getParameter("size"));
        condition_level = Integer.parseInt(request.getParameter("condition_level"));
        parcel_no = Integer.parseInt(request.getParameter("parcel_no"));
        Building tempBuilding = new Building(buildingID, b_name, street, zip, size, condition_level, parcel_no);

        boolean result = domainModel.saveBuildingEdits(tempBuilding);

        request.setAttribute("SaveSuccessMessage", "Save successful: " + result);
        RequestDispatcher rd = request.getRequestDispatcher("Buildings.jsp");
        rd.forward(request, response);
    }

    //Editing a certain building
    private void editBuilding(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        int building_id = Integer.parseInt(request.getParameter("building_id"));
        Building tempBuilding;
        tempBuilding = domainModel.getBuilding(building_id);
        request.setAttribute("building", tempBuilding);
        request.setAttribute("building_id", building_id);
        RequestDispatcher rd = request.getRequestDispatcher("EditBuilding.jsp");
        rd.forward(request, response);
    }

    //This method makes the service request in the DB active based on it's ID 
    //and assigns an employee to it
    private boolean takeServiceRequest(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        boolean result = false;
        int srequest_id = Integer.parseInt(request.getParameter("srequest_id"));
        int employee_id = 1;
        result = domainModel.takeServiceRequest(srequest_id, employee_id);
        request.setAttribute("takeServiceMessage", "Success: " + result);
        RequestDispatcher rd = request.getRequestDispatcher("ShowServiceRequests.jsp");
        rd.forward(request, response);
        return result;
    }

    private boolean saveServiceRequest(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        boolean result = false;
        int service_id = Integer.parseInt(request.getParameter("selectService"));
        String description = request.getParameter("description");
        int customerID = Integer.parseInt(request.getParameter("customerID"));
        int buildingID;
        if (request.getParameter("buildingID") == null) {
            buildingID = Integer.parseInt(request.getParameter("selectBuilding"));
        } else {
            buildingID = Integer.parseInt(request.getParameter("buildingID"));
        }
        ServiceRequest service = new ServiceRequest(service_id, buildingID, customerID, description, "pending");
        result = domainModel.saveServiceRequest(service);
        request.setAttribute("message", "Service saved: " + result);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ServiceRequest.jsp");
        dispatcher.forward(request, response);
        return result;
    }

    private boolean addBuilding(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        boolean result = false;

        //Get userPrefs object from session
        HttpSession session = request.getSession();
        UserPrefs userPrefs = (UserPrefs) session.getAttribute("UserPrefs");
        int customerID = userPrefs.getUserID();

        String name = request.getParameter("b_name");
        String street = request.getParameter("street");
        int size = Integer.parseInt(request.getParameter("size"));
        int zip = Integer.parseInt(request.getParameter("zip"));
        int year = Integer.parseInt(request.getParameter("year"));
        String usage = request.getParameter("usage");

//        Building tempBuild = new Building(customerID, name, street, size, zip);
        Building tempBuild = new Building(0, name, street, zip, 0, size, year, usage, 0, customerID);
        result = domainModel.addBuilding(tempBuild);
        System.out.println(tempBuild.getStreet());
        RequestDispatcher dispatcher = request.getRequestDispatcher("Buildings.jsp");
        dispatcher.forward(request, response);
        return result;
    }

    // Sends customer object to DomainFacade
    private void createCustomer(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException, SQLException {
        String company_name = request.getParameter("company_name");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String username = request.getParameter("username");
        String pwd = request.getParameter("pwd");
        String email = request.getParameter("email");
        String phone_no = request.getParameter("phone_no");

        Customer customer = new Customer(company_name, fname, lname, username, pwd, email, phone_no);
        boolean result = domainModel.createCustomer(customer);
        request.setAttribute("Message", "Building added: " + result);
        RequestDispatcher dispatcher = request.getRequestDispatcher("AddBuilding.jsp");
        dispatcher.forward(request, response);
    }

    private void showCustomers(HttpServletRequest request, HttpServletResponse response, DomainFacade df) throws ServletException, IOException {
        List<Customer> customers = df.showCustomers();
        request.setAttribute("customers", customers);

        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewCustomers.jsp");
        dispatcher.forward(request, response);
    }

    private void showActiveCheckupReports(HttpServletRequest request, HttpServletResponse response, DomainFacade df) throws ServletException, IOException {
        List<CheckupReport> reports = df.showActiveCheckupReports();
        request.setAttribute("reports", reports);

    }

    private void showDoneCheckupReports(HttpServletRequest request, HttpServletResponse response, DomainFacade df) throws ServletException, IOException {
        List<CheckupReport> donereports = df.showDoneCheckupReports();
        request.setAttribute("donereports", donereports);

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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

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

    private void updateCheckupReport(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        //conclusion
        int creport_id = Integer.parseInt(request.getParameter("creport_id"));
        int condition_level = Integer.parseInt(request.getParameter("condition_level"));
        //outside examination
        String roof = request.getParameter("roof");
        String walls_outside = request.getParameter("walls_outside");
        //damage and repair
        String comments = request.getParameter("comments");
        String damaged = request.getParameter("damaged");
        String damage_when = request.getParameter("damage_when");
        String damage_where = request.getParameter("damage_where");
        String damage_what = request.getParameter("damage_what");
        String damage_repaired = request.getParameter("damage_repaired");
        //inside examination
        String walls = request.getParameter("walls");
        String ceiling = request.getParameter("ceiling");
        String floor = request.getParameter("floor");
        String windows_doors = request.getParameter("window_door");
        //moisture scanning
        String moisture_scanning = request.getParameter("moisture_scanning");
        String moisture_measure = request.getParameter("moisture_measure");

        CheckupReport report = new CheckupReport(creport_id, condition_level, comments, roof, walls_outside, damaged, damage_when, damage_where, damage_what, damage_repaired, walls, ceiling, floor, windows_doors, moisture_scanning, moisture_measure);
        domainModel.updateCheckupReport(report);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Reports.jsp");
        dispatcher.forward(request, response);
    }

    private void requestCheckup(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("building_id"));
        domainModel.createCheckupReport(id);
        request.setAttribute("savedRequest", "true");
        RequestDispatcher rd = request.getRequestDispatcher("Reports.jsp");
        rd.forward(request, response);
    }

    private void selectReport(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("reportid"));
        CheckupReport report = domainModel.getReportByID(id);
        request.setAttribute("report", report);
        RequestDispatcher dispatcher = request.getRequestDispatcher("FillCheckupReport.jsp");
        dispatcher.forward(request, response);
    }

    private void selectFinishedReport(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("reportid"));
        CheckupReport report = domainModel.getReportByID(id);
        if (report == null) {
            System.out.println("Problem in selectFinishedReport(). Report object null.");
        }
        request.setAttribute("report", report);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ShowCheckupReport.jsp");
        dispatcher.forward(request, response);
    }

    private void assignEmployee(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        int employee_id = Integer.parseInt(request.getParameter("employeeid"));
        int creport_id = Integer.parseInt(request.getParameter("reportid"));

        domainModel.assignEmployee(creport_id, employee_id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Reports.jsp");
        dispatcher.forward(request, response);
    }

    private void addEmployee(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws SQLException, ServletException, IOException {

        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String username = request.getParameter("username");
        String pwd = request.getParameter("pwd");
        String email = request.getParameter("email");
        String phone_no = request.getParameter("phone_no");

        Employee employee = new Employee(fname, lname, username, pwd, email, phone_no);
        domainModel.createEmployee(employee);

        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    private void addRoom(HttpServletRequest request, HttpServletResponse response, DomainFacade domainModel) throws ServletException, IOException {
        int size = Integer.parseInt(request.getParameter("size"));
        int b_id = Integer.parseInt(request.getParameter("b_id"));

        System.out.println(size + " " + b_id);
        domainModel.addRoom(b_id, size);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);

    }

}
