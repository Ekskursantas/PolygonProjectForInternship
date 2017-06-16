/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Domain;


public class CityList {
    private int zip;
    private String city;

    public CityList(int zip, String city) {
        this.zip = zip;
        this.city = city;
    }

    public int getZip() {
        return zip;
    }

    public String getCity() {
        return city;
    }
    
}
