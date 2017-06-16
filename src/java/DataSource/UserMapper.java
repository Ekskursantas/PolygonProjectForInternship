/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataSource;

import Domain.UserPrefs;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;


public class UserMapper {
    
    //Checks first if the user is a customer
    //If not, it will call an employee authentication method that will return
    //a UserPrefs object if it could log in as an employee
    public UserPrefs authenticate(Connection con, String email, String password) {
        UserPrefs userPrefs = null;
        String sqlString = "SELECT pwd from Customer where email='"+email+"'";
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sqlString);
            String pwd = null;
            while (rs.next()) {
                pwd = rs.getString("pwd");
            }
            //If data matches for the customer: 
            if (password.equals(pwd)) {
                userPrefs = customerLogin(con,email);
            }
            //Check if the details would match an employee's
            else
            {
                userPrefs = employeeLogin(con,email,password);
            }
            stmt.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserMapper.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Problem in authenticate. ex = "+ex);
        } 
        return userPrefs;
    }
    
    //Assigns a UserPrefs object when a customer signs in
    public UserPrefs customerLogin(Connection con, String email) {
        UserPrefs userPrefs = null;
        String sqlString = "select * from Customer where email=?;";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                userPrefs = new UserPrefs(3,
                        rs.getInt("customer_id"),
                        rs.getString("fname"),
                        rs.getString("lname"),
                rs.getString("username"),
                rs.getString("email"),
                rs.getInt("phone_no"),
                rs.getString("company_name"));
            }
            stmt.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(UserMapper.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Problem in customerLogin(). ex= "+ex);
        }
        return userPrefs;
    }
    //int accessLevel, int userID, String fname, String lname, String username, String email, int phoneNo

    //Assign a UserPrefs object if employee logged in successfuly
    private UserPrefs employeeLogin(Connection con, String email, String password) {
        UserPrefs userPrefs = null;
        String sqlString = "select * from Employee where email=?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            while (rs.next()) {
                String pwd = rs.getString("pwd");
                //If data matches, employee login is successful:
                if (password.equals(pwd)) {
                    userPrefs = new UserPrefs(2,
                            rs.getInt("emp_id"),
                            rs.getString("fname"),
                            rs.getString("lname"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getInt("phone_no"));
                }
               
                stmt.close();
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserMapper.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Problem in employeeLogin(). Ex= "+ex);
        } 
        return userPrefs;
    }
    
}
