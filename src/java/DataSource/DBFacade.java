/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataSource;

import Domain.Building;
import Domain.CheckupReport;
import Domain.CityList;
import Domain.Customer;
import Domain.Employee;
import Domain.ServiceRequest;
import Domain.ServiceList;
import Domain.UserPrefs;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class DBFacade {
    
    private Connection con;
    
    //add mappers here as private objects
    private BuildingMapper bm;
    private CustomerMapper customerMap;
    private EmployeeMapper employeeMap;
    private CheckupReportMapper creportmap;
    private ServiceMapper serviceMapper;
    private UserMapper userMapper;
    
    //Singleton start
    private static DBFacade instance;
    
    private DBFacade () {
        con = DBConnector.getInstance().getConnection();
        bm = new BuildingMapper();
        customerMap = new CustomerMapper();
        creportmap = new CheckupReportMapper();
        serviceMapper = new ServiceMapper();
        userMapper = new UserMapper();
        employeeMap = new EmployeeMapper();
        //assign the mappers with a new object 
    }
    
    public static DBFacade getInstance() {
        if (instance == null) {
            instance = new DBFacade();
        }
        return instance;
    }
    //Singleton end
    
    public boolean createCustomer(Customer c) throws SQLException{
        return customerMap.createCustomer(c, con);
    }
    public boolean createEmployee(Employee e) throws SQLException{
        return employeeMap.createEmployee(e, con);
    }

    public boolean addBuilding(Building building) {
        return bm.addBuilding(con, building);
    }
    public boolean addRoom(int b_id, int size) {
        return bm.addRoom(con, b_id, size);
    }
    public boolean createCheckupReport(int building_id) {
        return creportmap.createCheckupReport(building_id, con);
    }
    public boolean updateCheckupReport(CheckupReport checkuprreport) {
        return creportmap.updateCheckupReport(checkuprreport, con);
    }
    public boolean assignEmployee(int creport_id, int employee_id) {
        return creportmap.assignEmployee(creport_id, employee_id, con);
    }
    public List<Customer> showCustomers() 
    {
	return customerMap.viewAllCustomers(con);
    }
    public List<Employee> showEmployees() 
    {
	return employeeMap.viewAllEmployees(con);
    }
    public List<CheckupReport> showPendingCheckupReports() 
    {
	return creportmap.getPendingReports(con);
    }
    public List<CheckupReport> showActiveCheckupReports() 
    {
	return creportmap.getActiveReports(con);
    }
    public List<CheckupReport> showDoneCheckupReports() 
    {
	return creportmap.getDoneReports(con);
    }
    
    public List<Building> showBuildings() 
    {
	return bm.getBuildings(con);
    }
    
    public CheckupReport getReportByID(int id) 
    {
	return creportmap.getReportByID(id, con);
    }
    public ArrayList<ServiceList> getAllServices() {
        return serviceMapper.getServiceList(con);
    }
    
    public ArrayList<CityList> getCities() {
        return bm.getCityList(con);
    }
    
    public boolean saveServiceRequest(ServiceRequest s) {
        boolean result = serviceMapper.saveServiceRequest(con, s);
        return result;
    }

    public List<ServiceRequest> showPendingServiceRequests() {
        return serviceMapper.showPendingServiceRequests(con);
    }
    public boolean takeServiceRequest(int srequest_id, int employee_id) {
        return serviceMapper.takeServiceRequest(con, srequest_id, employee_id);
    }
    
    public Building getBuilding(int building_id) {
        return bm.getBuilding(con, building_id);
    }

    public boolean saveBuildingEdits(Building tempBuilding) {
        return bm.saveBuildingEdits(con, tempBuilding);
    }

    public UserPrefs authenticate(String email, String password) {
        return userMapper.authenticate(con,email,password);
    }

    public List<Building> getMyBuildings(int customerID) {
        return bm.getMyBuildings(con,customerID);
    }
    public List<CheckupReport> getMyReports(int employeeID) {
        return creportmap.getMyReports(employeeID, con);
    }
    public String getServiceName(int id) {
        return serviceMapper.getServiceName(con, id);
    }
}
