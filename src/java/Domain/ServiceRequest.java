/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Domain;


public class ServiceRequest {
    private int srequest_id;
    private int building_id;
    private int employee_id;
    private String employee_name;
    private String requestDate;
    private String checkDate;    
    private int service_id;
    private String service_name;
    private String description;
    private String reportStatus;

    public ServiceRequest(int service_id,int building_id, int customerID, String description, String reportStatus) {
        this.building_id = building_id;
        this.service_id = service_id;
        this.description = description;
        this.reportStatus = reportStatus;
    }

    public ServiceRequest(int building_id, int employee_id, String employee_name, String requestDate, String checkDate, int service_id, String service_name, String description, String reportStatus, int srequest_id) {
        this.building_id = building_id;
        this.employee_id = employee_id;
        this.employee_name = employee_name;
        this.requestDate = requestDate;
        this.checkDate = checkDate;
        this.service_id = service_id;
        this.service_name = service_name;
        this.description = description;
        this.reportStatus = reportStatus;
        this.srequest_id = srequest_id;
    }
    
    public int getSrequest_id() {
        return srequest_id;
    }

    public int getBuilding_id() {
        return building_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public String getCheckDate() {
        return checkDate;
    }

    public int getService_id() {
        return service_id;
    }

    public String getDescription() {
        return description;
    }

    public String getReportStatus() {
        return reportStatus;
    }
    public String getService_name() {
        return service_name;
    }
    public String getEmployee_name() {
        return employee_name;
    }
    
}
