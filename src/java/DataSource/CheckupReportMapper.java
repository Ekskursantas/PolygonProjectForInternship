/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataSource;

import Domain.Building;
import Domain.CheckupReport;
import Domain.Customer;
import Domain.Employee;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class CheckupReportMapper {

    // Returns recently created reports. Marked as pending.
    public List<CheckupReport> getPendingReports(Connection con) {
        ArrayList<CheckupReport> reports = new ArrayList<>();
        String sql = "select * from CheckupReport "
                + "join Building ON Building.building_id=CheckupReport.building_id "
                + "join Customer ON Customer.customer_id=Building.customer_id "
                + "join City ON Building.zip=City.zip "
                + "where reportStatus='pending'";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                // Create a building object for the report
                Building b = new Building(
                        rs.getString("street"),
                        rs.getInt("size"),
                        rs.getInt("zip"),
                        rs.getString("city"));
                // Create a customer object for the report 
                Customer c = new Customer(
                        rs.getString("company_name"),
                        rs.getString("fname"),
                        rs.getString("lname")
                );
                // Create empty employee object for report
                Employee e = new Employee(
                        " ", " "
                );
                // Create report 
                CheckupReport cr = new CheckupReport(
                        rs.getInt("creport_id"),
                        b,
                        c,
                        e,
                        rs.getString("checkDate"),
                        rs.getInt("checkupreport.condition_level"),
                        rs.getString("reportStatus"),
                        rs.getString("comments")
                );
                // Add report to list
                reports.add(cr);
            }

            return reports;
        } catch (Exception e) {
            System.out.println("Problem in CheckupReportMapper.getPendingReports ");
            System.out.println(e.getMessage());
            return null;
        }
    }
    
    // Returns reports which have been assigned for an employee to fill in.
    public List<CheckupReport> getActiveReports(Connection con) {
        ArrayList<CheckupReport> reports = new ArrayList<>();
        String sql = "select * from CheckupReport "
                + "join Building ON Building.building_id=CheckupReport.building_id "
                + "join Customer ON Customer.customer_id=Building.customer_id "
                + "join Employee ON Employee.emp_id=CheckupReport.employee_id "
                + "join City ON Building.zip=City.zip "
                + "where reportStatus='active' "
                + "order by creport_id ";
        
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                // Create a building object for the report
                Building b = new Building(
                        rs.getString("street"),
                        rs.getInt("size"),
                        rs.getInt("zip"),
                        rs.getString("city"));
                // Create a customer object for the report
                Customer c = new Customer(
                        rs.getString("company_name"),
                        rs.getString("fname"),
                        rs.getString("lname")
                );
                // Create an employee object for the report
                Employee e = new Employee(
                        rs.getString("Employee.fname"),
                        rs.getString("Employee.lname")
                );
                // Create a report object
                CheckupReport cr = new CheckupReport(
                        rs.getInt("creport_id"),
                        b,
                        c,
                        e,
                        rs.getString("reportStatus")
                );
                // Add report to list
                reports.add(cr);
            }

            return reports;
        } catch (Exception e) {
            System.out.println("Problem in CheckupReportMapper.getActiveReports ");
            System.out.println(e.getMessage());
            return null;
        }
    }

    // Returns filled in reports.
    public List<CheckupReport> getDoneReports(Connection con) {
        ArrayList<CheckupReport> reports = new ArrayList<>();
        String sql = "select * from CheckupReport "
                + "join Building ON Building.building_id=CheckupReport.building_id "
                + "join Customer ON Customer.customer_id=Building.customer_id "
                + "join Employee ON Employee.emp_id=CheckupReport.employee_id "
                + "join City ON Building.zip=City.zip "
                + "where reportStatus='done'";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                // Create a building object for the report
                Building b = new Building(
                        rs.getString("street"),
                        rs.getInt("size"),
                        rs.getInt("zip"),
                        rs.getString("city"));
                // Create a customer object for the report
                Customer c = new Customer(
                        rs.getString("company_name"),
                        rs.getString("fname"),
                        rs.getString("lname")
                );
                // Create an employee object for the report
                Employee e = new Employee(
                        rs.getString("Employee.fname"),
                        rs.getString("Employee.lname")
                );
                // Create a report object
                CheckupReport cr = new CheckupReport(
                        rs.getInt("creport_id"),
                        b,
                        c,
                        e,
                        rs.getString("checkDate"),
                        rs.getInt("checkupreport.condition_level"),
                        rs.getString("reportStatus"),
                        rs.getString("comments")
                );
                // Add report to list
                reports.add(cr);
            }

            return reports;
        } catch (Exception e) {
            System.out.println("Problem in CheckupReportMapper.getDoneReports ");
            System.out.println(e.getMessage());
            return null;
        }
    }
    
    //Gives back the list of building IDs that an employee has assign as a job
    public List<CheckupReport> getMyReports(int employeeID, Connection con) {
        List<CheckupReport> myReports = new ArrayList();
        String sqlString = "SELECT creport_id FROM CheckupReport where reportStatus='active' and employee_id=?";
        PreparedStatement stmt;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setInt(1, employeeID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()){
                myReports.add(getReportByID(rs.getInt("creport_id"),con));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CheckupReportMapper.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println( "Problem in getMyReports. ex = " + ex);
        }
        
        return myReports;
    }

    // Returns an individual report.
    public CheckupReport getReportByID(int reportid, Connection con) {
        CheckupReport cr = null;
        String sql = "select * from CheckupReport "
                + "join Building ON Building.building_id=CheckupReport.building_id "
                + "join Customer ON Customer.customer_id=Building.customer_id "
                + "join Employee ON Employee.emp_id=CheckupReport.employee_id "
                + "join City ON Building.zip=City.zip "
                + "where creport_id=?";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, reportid);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                // Create a building object for the report
                Building b = new Building(
                        rs.getString("name"),
                        rs.getString("street"),
                        rs.getInt("size"),
                        rs.getInt("zip"),
                        rs.getInt("year"),
                        rs.getString("buildingUse"),
                        rs.getString("city"));
                // Create a customer object for the report
                Customer c = new Customer(
                        rs.getString("company_name"),
                        rs.getString("Customer.fname"),
                        rs.getString("Customer.lname")
                );
                // Create an employee object for the report
                Employee e = new Employee(
                        rs.getString("Employee.fname"),
                        rs.getString("Employee.lname")
                );
                // Create the report
                cr = new CheckupReport(
                        rs.getInt("creport_id"),
                        b,
                        c,
                        e,
                        rs.getString("checkDate"),
                        rs.getInt("checkupreport.condition_level"),
                        rs.getString("reportStatus"),
                        rs.getString("comments"),
                        rs.getString("roof"),
                        rs.getString("walls_outside"),
                        rs.getString("damaged"),
                        rs.getString("damage_when"),
                        rs.getString("damage_where"),
                        rs.getString("damage_what"),
                        rs.getString("damage_repaired"),
                        rs.getString("walls"),
                        rs.getString("ceiling"),
                        rs.getString("floor"),
                        rs.getString("windows_doors"),
                        rs.getString("moisture_scanning"),
                        rs.getString("moisture_measure")
                );

            }

            return cr;
        } catch (Exception e) {
            System.out.println("Problem in CheckupReportMapper.getReportByID ");
            System.out.println(e.getMessage());
            return null;
        }

    }

    // Creates a report in the databse after customer requests for checkup for their building. Marked as pending.
    public boolean createCheckupReport(int building_id, Connection con) {
        boolean result = false;
        String sqlString = "INSERT INTO CheckupReport(building_id, checkDate, reportStatus) "
                + "VALUES (?, current_date(),'pending') ";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setInt(1, building_id);

            stmt.execute();
            stmt.close();
            result = true;
        } catch (SQLException ex) {
            result = false;
            System.out.println("Exception in CheckupReportMapper. ex = " + ex);
        }
        return result;
    }
    
    // Assigns an employee to do a checkup on requested building. Marked as active.
    public boolean assignEmployee (int report_id, int employee_id, Connection con) {
    boolean result = false;
        String sqlString = "UPDATE CheckupReport  "
                + "SET employee_id=?, reportStatus='active' "
                + "WHERE creport_id=?";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setInt(1, employee_id);
            stmt.setInt(2, report_id);
            stmt.execute();
            stmt.close();
            result = true;
        } catch (SQLException ex) {
            result = false;
            System.out.println("Exception in CheckupReportMapper. ex = " + ex);
        }
        return result;
    }
    
    // Saves information filled in during checkup to the database. Marked as done. 
    public boolean updateCheckupReport(CheckupReport cr, Connection con) {
        boolean result = false;
        String sqlString = "UPDATE CheckupReport  "
                + "SET checkDate=current_date(), condition_level=?, reportStatus='done', "
                + "comments=?, roof=?, walls_outside=?, damaged=?, damage_when=?, damage_where=?, damage_what=?, damage_repaired=?, "
                + "walls=?, ceiling=?, floor=?, windows_doors=?, moisture_scanning=?, moisture_measure=? "
                + "WHERE creport_id=?";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setInt(1, cr.getCondition_level());
            stmt.setString(2, cr.getComments());
            
            stmt.setString(3, cr.getRoof());
            stmt.setString(4, cr.getWalls_outside());
            
            stmt.setString(5, cr.getDamaged());
            stmt.setString(6, cr.getDamage_when());
            stmt.setString(7, cr.getDamage_where());
            stmt.setString(8, cr.getDamage_what());
            stmt.setString(9, cr.getDamage_repaired());
            
            stmt.setString(10, cr.getWalls());
            stmt.setString(11, cr.getCeiling());
            stmt.setString(12, cr.getFloor());
            stmt.setString(13, cr.getWindows_doors());
            stmt.setString(14, cr.getMoisture_scanning());
            stmt.setString(15, cr.getMoisture_measure());
            
            stmt.setInt(16, cr.getCreport_id());
            stmt.execute();
            stmt.close();
            result = true;
        } catch (SQLException ex) {
            result = false;
            System.out.println("Exception in CheckupReportMapper. ex = " + ex);
        }
        return result;
    }
}
