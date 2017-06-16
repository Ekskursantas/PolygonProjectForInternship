/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Domain;


public class Building {

    private int buildingID;
    private int customerID;
    private String name;
    private String address;
    private String street;
    private int size;
    private int condition;
    private String lastCheckUp;
    private int zip;
    private int parcel_no;
    private int year;
    private String buildingUse;
    private String city;

    //We are going to need one constructor only. Please use the upper one with 10 parameteres
    public Building(int building_id, String name, String street, int zip, int parcel_no,
            int size, int year, String buildingUse, int condition_level, int customer_id) {

        this.buildingID = building_id;
        this.name = name;
        this.street = street;
        this.zip = zip;
        this.parcel_no = parcel_no;
        this.size = size;
        this.year = year;
        this.buildingUse = buildingUse;
        this.condition = condition_level;
        this.customerID = customer_id;
    }

    //Try to avoid using the constructors below. They are not deleted for possible usage somewhere.
    public Building(String name, String street, int size, int zip, int year, String buildingUse, String city) {
        this.name = name;
        this.street = street;
        this.size = size;
        this.zip = zip;
        this.year = year;
        this.buildingUse = buildingUse;
        this.city = city;
    }

    public Building(String street, int size, int zip) {
        this.street = street;
        this.size = size;
        this.zip = zip;
    }

    public Building(String street, int size, int zip, String city) {
        this.street = street;
        this.size = size;
        this.zip = zip;
        this.city = city;
    }

    public Building(String name, String street, int size, int zip) {
        this.name = name;
        this.street = street;
        this.size = size;
        this.zip = zip;
    }

    public Building(int buildingID, String street, int size, int zip) {
        this.buildingID = buildingID;
        this.street = street;
        this.size = size;
        this.zip = zip;
    }

    public Building(int customerID, String name, String street, int size, int zip) {
        this.customerID = customerID;
        this.name = name;
        this.street = street;
        this.size = size;
        this.zip = zip;
    }

    public Building(int buildingID, String name, String street, int zip, int size, int condition, int parcel_no) {
        this.buildingID = buildingID;
        this.name = name;
        this.street = street;
        this.size = size;
        this.condition = condition;
        this.zip = zip;
        this.parcel_no = parcel_no;
    }

    public Building(int buildingID, int customerID, String name, String street, int size, int condition, int zip) {
        this.buildingID = buildingID;
        this.customerID = customerID;
        this.name = name;
        this.street = street;
        this.size = size;
        this.condition = condition;
        //this.lastCheckUp = lastCheckUp;
        this.zip = zip;
    }

    public int getBuildingID() {
        return buildingID;
    }

    public String getStreet() {
        return street;
    }

    public int getCustomerID() {
        return customerID;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public int getSize() {
        return size;
    }

    public int getCondition() {
        return condition;
    }

    public String getLastCheckUp() {
        return lastCheckUp;
    }

    public int getZip() {
        return zip;
    }

    public int getParcel_no() {
        return parcel_no;
    }

    public Building(int buildingID, int customerID, String name, String street, int size, int condition, int zip, String city) {
        this.buildingID = buildingID;
        this.customerID = customerID;
        this.name = name;
        this.street = street;
        this.size = size;
        this.condition = condition;
        //this.lastCheckUp = lastCheckUp;
        this.zip = zip;
        this.city = city;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getBuildingUse() {
        return buildingUse;
    }

    public void setBuildingUse(String buildingUse) {
        this.buildingUse = buildingUse;
    }

}
