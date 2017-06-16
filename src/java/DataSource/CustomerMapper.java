/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataSource;

import Domain.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class CustomerMapper {
    
    // Creates a new customer in the database
    public boolean createCustomer(Customer c, Connection con) throws SQLException{
    boolean result = false;
        String sql = "INSERT INTO Customer (company_name, fname, lname, username, pwd, email, phone_no) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement statement = con.prepareStatement(sql);
        try  {
            statement.setString(1, c.getCompany_name());
            statement.setString(2, c.getFname());
            statement.setString(3, c.getLname());
            statement.setString(4, c.getUsername());
            statement.setString(5, c.getPwd());
            statement.setString(6, c.getEmail());
            statement.setString(7, c.getPhone_no());

            statement.execute();
            statement.close();
            result = true;
        } catch (SQLException e) {
            result = false;
            System.out.println("Problem in CustomerMapper "+ e);

        }
        return result;
    }
    
    // Shows a list of all customers.
    public List<Customer> viewAllCustomers(Connection con){
        ArrayList<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM Customer";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                    // Create customer object
                    Customer c = new Customer(
                    rs.getInt("customer_id"),
                    rs.getString("company_name"),
                    rs.getString("fname"),
                    rs.getString("lname"),
                    rs.getString("username"),
                    rs.getString("pwd"),
                    rs.getString("email"),
                    rs.getString("phone_no")
                    );
                    // Add customer to list
                    customers.add(c);
                }
            
            return customers;
        } catch (Exception e) {
            System.out.println("Problem in CustomerMapper ");
            System.out.println(e.getMessage());
            return null;
        }
        
    }
}
