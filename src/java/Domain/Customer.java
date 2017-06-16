/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Domain;


public class Customer {
    private int customer_id;
    private String company_name;
    private String fname;
    private String lname;
    private String username;
    private String pwd;
    private String email;
    private String phone_no;

    // Constructors
    public Customer(String company_name, String fname, String lname) {
        this.company_name = company_name;
        this.fname = fname;
        this.lname = lname;
    }

    public Customer(int customer_id,String company_name, String fname, String lname, String username, String pwd, String email, String phone_no) {
        this.customer_id = customer_id;
        this.company_name = company_name;
        this.fname = fname;
        this.lname = lname;
        this.username = username;
        this.pwd = pwd;
        this.email = email;
        this.phone_no = phone_no;
    }
        public Customer(String company_name, String fname, String lname, String username, String pwd, String email, String phone_no) {
        this.company_name = company_name;
        this.fname = fname;
        this.lname = lname;
        this.username = username;
        this.pwd = pwd;
        this.email = email;
        this.phone_no = phone_no;
    }

    // Getters
    public int getCustomer_id() {
        return customer_id;
    }

    public String getCompany_name() {
        return company_name;
    }

 
    public String getFname() {
        return fname;
    }

    public String getLname() {
        return lname;
    }

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

    
    
}
