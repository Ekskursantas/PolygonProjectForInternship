/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Domain;


public class Service {
    private int srequest_id;
    private int building_id;
    private int employee_id;
    private String requestDate;
    private String checkDate;
    private int service_id;
    private String description;
    private String reportStatus;

    
    
    public Service(int service_id,int building_id, String description, String reportStatus) {
        this.building_id = building_id;
        this.service_id = service_id;
        this.description = description;
        this.reportStatus = reportStatus;
    }

    public Service(int building_id, int employee_id, String requestDate, String checkDate, int service_id, String description, String reportStatus) {
        this.building_id = building_id;
        this.employee_id = employee_id;
        this.requestDate = requestDate;
        this.checkDate = checkDate;
        this.service_id = service_id;
        this.description = description;
        this.reportStatus = reportStatus;
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
    
}
