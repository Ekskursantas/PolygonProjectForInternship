/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Domain;


public class CheckupReport {

    private int creport_id;
    private Building building;
    private Customer customer;
    private Employee employee;
    private String checkDate;
    private int condition_level;
    private String reportStatus;
    private String comments;
    private String roof;
    private String walls_outside;
    private String damaged;
    private String damage_when;
    private String damage_where;
    private String damage_what;
    private String damage_repaired;
    private String walls;
    private String ceiling;
    private String floor;
    private String windows_doors;
    private String moisture_scanning;
    private String moisture_measure;

    // Getters
    public String getRoof() {
        return roof;
    }

    public String getWalls_outside() {
        return walls_outside;
    }

    public String getWalls() {
        return walls;
    }

    public String getCeiling() {
        return ceiling;
    }

    public String getFloor() {
        return floor;
    }

    public String getWindows_doors() {
        return windows_doors;
    }

    public String getMoisture_scanning() {
        return moisture_scanning;
    }

    public String getMoisture_measure() {
        return moisture_measure;
    }

    public String getDamaged() {
        return damaged;
    }

    public String getDamage_when() {
        return damage_when;
    }

    public String getDamage_where() {
        return damage_where;
    }

    public String getDamage_what() {
        return damage_what;
    }

    public String getDamage_repaired() {
        return damage_repaired;
    }

    public Customer getCustomer() {
        return customer;
    }

    public Employee getEmployee() {
        return employee;
    }

    public int getCreport_id() {
        return creport_id;
    }

    public Building getBuilding() {
        return building;
    }

    public String getCheckDate() {
        return checkDate;
    }

    public int getCondition_level() {
        return condition_level;
    }

    public String getReportStatus() {
        return reportStatus;
    }

    public String getComments() {
        return comments;
    }
    
    // Constructors
    public CheckupReport(int creport_id, int condition_level, String comments, String roof, String walls_outside, String damaged, String damage_when, String damage_where, String damage_what, String damage_repaired, String walls, String ceiling, String floor, String windows_doors, String moisture_scanning, String moisture_measure) {
        this.creport_id = creport_id;
        this.condition_level = condition_level;
        this.comments = comments;
        this.roof = roof;
        this.walls_outside = walls_outside;
        this.damaged = damaged;
        this.damage_when = damage_when;
        this.damage_where = damage_where;
        this.damage_what = damage_what;
        this.damage_repaired = damage_repaired;
        this.walls = walls;
        this.ceiling = ceiling;
        this.floor = floor;
        this.windows_doors = windows_doors;
        this.moisture_scanning = moisture_scanning;
        this.moisture_measure = moisture_measure;
    }

    public CheckupReport(int creport_id, Building building, Customer customer, Employee employee, String checkDate, int condition_level, String reportStatus, String comments, String roof, String walls_outside, String damaged, String damage_when, String damage_where, String damage_what, String damage_repaired, String walls, String ceiling, String floor, String windows_doors, String moisture_scanning, String moisture_measure) {
        this.creport_id = creport_id;
        this.building = building;
        this.customer = customer;
        this.employee = employee;
        this.checkDate = checkDate;
        this.condition_level = condition_level;
        this.reportStatus = reportStatus;
        this.comments = comments;
        this.roof = roof;
        this.walls_outside = walls_outside;
        this.damaged = damaged;
        this.damage_when = damage_when;
        this.damage_where = damage_where;
        this.damage_what = damage_what;
        this.damage_repaired = damage_repaired;
        this.walls = walls;
        this.ceiling = ceiling;
        this.floor = floor;
        this.windows_doors = windows_doors;
        this.moisture_scanning = moisture_scanning;
        this.moisture_measure = moisture_measure;
    }
    
    public CheckupReport(int creport_id, Building building, Customer customer, Employee employee, String checkDate, int condition_level, String reportStatus, String comments) {
        this.creport_id = creport_id;
        this.building = building;
        this.customer = customer;
        this.employee = employee;
        this.checkDate = checkDate;
        this.condition_level = condition_level;
        this.reportStatus = reportStatus;
        this.comments = comments;

    }

    public CheckupReport(int creport_id, Building building, Customer customer, Employee employee, String reportStatus) {
        this.creport_id = creport_id;
        this.building = building;
        this.customer = customer;
        this.employee = employee;
        this.reportStatus = reportStatus;
    }
    
}
