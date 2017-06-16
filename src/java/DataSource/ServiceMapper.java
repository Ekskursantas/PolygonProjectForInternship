/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataSource;

import Domain.ServiceRequest;
import Domain.ServiceList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;





public class ServiceMapper {
    
//    private static Connection con;
//    private static ServiceMapper sm;
//    
//    ServiceMapper() {
//        con = (Connection) DBConnector.getInstance().getConnection();
//        
//    }
//    public static void main(String[] args) {
//        ServiceMapper sm = new ServiceMapper();
//        boolean result = sm.takeServiceRequest(con, 6, 1);
//        System.out.println("result = " + result);
//    }
    
    
    //Returns the list of services without their indexes
    public ArrayList<ServiceList> getServiceList(Connection con) {
        ArrayList<ServiceList> serviceList = new ArrayList();
        String sqlString = "select * from Services";
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sqlString);
            while (rs.next()) {
                serviceList.add(new ServiceList(rs.getInt(1),rs.getString(2)));
            }
            stmt.close();
            rs.close();
        } catch (SQLException ex) {
            System.out.println("Error in getAllServices() method; exception: "+ex);
        }
        return serviceList;
    }
    
    
    public boolean saveServiceRequest(Connection con,ServiceRequest service) {
        boolean result = false;
        String sqlString = "INSERT INTO ServiceRequest (building_id,requestDate,service_id,description,reportStatus)\n" +
"VALUES (?,current_date(),?,?,?);";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setInt(1, service.getBuilding_id());
//            stmt.setInt(2, service.getEmployee_id());
            stmt.setInt(2, service.getService_id());
            stmt.setString(3, service.getDescription());
            stmt.setString(4, service.getReportStatus());
            result = true;
            
            stmt.execute();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(ServiceMapper.class.getName()).log(Level.SEVERE, null, ex);
            result = false;
        }
        return result;
    }

    List<ServiceRequest> showPendingServiceRequests(Connection con) {
        List<ServiceRequest> serviceRequests = new ArrayList();
        String sqlString = "SELECT * FROM ServiceRequest where reportStatus='pending';";
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sqlString);
            while (rs.next()) {
                serviceRequests.add(new ServiceRequest(
                        rs.getInt("building_id"),
                        rs.getInt("employee_id"),
                        null,  //employee name at this point is not needed
                        rs.getString("requestDate"),
                        null,
                        rs.getInt("service_id"),
                        getService(con,rs.getInt("service_id")).getService_name(),
                        rs.getString("description"),
                        "pending",
                        rs.getInt("srequest_id")));
            }
            stmt.close();
            rs.close();
        } catch (SQLException ex) {
            System.out.println("Exception in showPendingServiceRequests. Ex: "+ex);
        }
        return serviceRequests;
    }
    
    ServiceList getService(Connection con, int service_id) {
        ServiceList service = null;
        String sqlString = "select * from Services where service_id='"+service_id+"'";
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sqlString);
            while (rs.next()) {
                service = new ServiceList(rs.getInt("service_id"),rs.getString("service_name"));
            }
            stmt.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(ServiceMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return service;
    }
        String getServiceName(Connection con, int service_id) {
        String service = null;
        String sqlString = "select * from Services where service_id='"+service_id+"'";
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sqlString);
            while (rs.next()) {
                service = rs.getString("service_name");
            }
            stmt.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(ServiceMapper.class.getName()).log(Level.SEVERE, null, ex);
        }
        return service;
    }
    
    boolean takeServiceRequest(Connection con,int srequest_id,int employee_id) {
        boolean result = false;
        String sqlString = "UPDATE `Polygon`.`ServiceRequest` SET `reportStatus`='active' ,employee_id=? \n" +
"WHERE `srequest_id`=?;";
        PreparedStatement stmt;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setInt(1, employee_id);
            stmt.setInt(2, srequest_id);
            stmt.execute();
            result = true;
        } catch (SQLException ex) {
            Logger.getLogger(ServiceMapper.class.getName()).log(Level.SEVERE, null, ex);
            result = false;
        }
        
        return result;
    }
}
