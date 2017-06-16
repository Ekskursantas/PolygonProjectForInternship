/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Domain;


public class ServiceList {
    private int service_id;
    private String service_name;

    public ServiceList(int service_id, String service_name) {
        this.service_id = service_id;
        this.service_name = service_name;
    }

    public int getService_id() {
        return service_id;
    }

    public String getService_name() {
        return service_name;
    }
}
