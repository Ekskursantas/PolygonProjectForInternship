/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Domain;


public class Employee {
    private String fname;
    private String lname;
    private int employee_id;
    private String username;
    private String pwd;
    private String email;
    private String phone_no;

    public String getUsername() {
        return username;
    }

    public String getPwd() {
        return pwd;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone_no() {
        return phone_no;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public Employee(String fname, String lname) {
        this.fname = fname;
        this.lname = lname;
    }

    public String getFname() {
        return fname;
    }

    public String getLname() {
        return lname;
    }

    public Employee(String fname, String lname, String username, String pwd, String email, String phone_no) {
        this.fname = fname;
        this.lname = lname;
        this.username = username;
        this.pwd = pwd;
        this.email = email;
        this.phone_no = phone_no;
    }
    
    
    public Employee(String fname, String lname, int employee_id, String username, String pwd, String email, String phone_no) {
        this.fname = fname;
        this.lname = lname;
        this.employee_id = employee_id;
        this.username = username;
        this.pwd = pwd;
        this.email = email;
        this.phone_no = phone_no;
    }

    
}
