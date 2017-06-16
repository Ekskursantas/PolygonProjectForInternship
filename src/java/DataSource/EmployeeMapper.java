/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataSource;

import Domain.Employee;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class EmployeeMapper {
    
    // Returns a list of all employees
    public List<Employee> viewAllEmployees(Connection con){
        ArrayList<Employee> employees = new ArrayList<>();
        String sql = "SELECT * FROM Employee";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                    // Create employee object
                    Employee e = new Employee(
                    rs.getString("fname"),
                    rs.getString("lname"),
                    rs.getInt("emp_id"),
                    rs.getString("username"),
                    rs.getString("pwd"),
                    rs.getString("email"),
                    rs.getString("phone_no")
                    );
                    // Add employee to list
                    employees.add(e);
                }
            
            return employees;
        } catch (Exception e) {
            System.out.println("Problem in EmployeeMapper ");
            System.out.println(e.getMessage());
            return null;
        }
        
    }
    
    // Creates a new employee in the database
    public boolean createEmployee(Employee e, Connection con) throws SQLException{
    boolean result = false;
        String sql = "INSERT INTO Employee (fname, lname, username, pwd, email, phone_no) VALUES (?,?,?,?,?,?)";
        PreparedStatement statement = con.prepareStatement(sql);
        try  {
            statement.setString(1, e.getFname());
            statement.setString(2, e.getLname());
            statement.setString(3, e.getUsername());
            statement.setString(4, e.getPwd());
            statement.setString(5, e.getEmail());
            statement.setString(6, e.getPhone_no());


            statement.execute();
            statement.close();
            result = true;
        } catch (SQLException ex) {
            result = false;
            System.out.println("Problem in CustomerMapper "+ ex);

        }
        return result;
    }
}
