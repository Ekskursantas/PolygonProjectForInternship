/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataSource;

import Domain.Building;
import Domain.CityList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BuildingMapper {
//
//    private static Connection con;
//    private static BuildingMapper bm;
//
//    BuildingMapper() {
//        con = (Connection) DBConnector.getInstance().getConnection();
//
//    }
//
//    public static void main(String[] args) {
//        bm = new BuildingMapper();
//        List<Building> myBuildingList = bm.getMyBuildings(con, 1);
//        for (int i = 0; i < myBuildingList.size(); i++) {
//            System.out.println("Building: " + myBuildingList.get(i).getStreet());
//        }
//    }

    // Creates a new building in the database
    public boolean addBuilding(Connection con, Building building) {
        boolean result = false;
        String sqlString = "INSERT INTO Building (building_id,name,street,zip,size,year,buildingUse,condition_level,customer_id) "
                + "VALUES (?,?,?,?,?,?,?,?,?);";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setInt(1, building.getBuildingID());
            stmt.setString(2, building.getName());
            stmt.setString(3, building.getStreet());
            stmt.setInt(4, building.getZip());
            stmt.setInt(5, building.getSize());
            stmt.setInt(6, building.getYear());
            stmt.setString(7, building.getBuildingUse());
            stmt.setInt(8, building.getCondition());
            stmt.setInt(9, building.getCustomerID());
            stmt.execute();
            stmt.close();
            result = true;
        } catch (SQLException ex) {
            result = false;
            System.out.println("Exception in BuildingMapper. ex = " + ex);
        }
        return result;
    }

    // Creates a new room in the database for chosen building
    public boolean addRoom(Connection con, int b_id, int size) {
        boolean result = false;
        String sqlString = "INSERT INTO Room (building_id,size) "
                + "VALUES (?,?);";
        PreparedStatement stmt = null;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setInt(1, b_id);
            stmt.setInt(2, size);
            stmt.execute();
            stmt.close();
            result = true;
        } catch (SQLException ex) {
            result = false;
            System.out.println("Exception in BuildingMapper. ex = " + ex);
        }
        return result;
    }
    
    // Returns a list of all buildings
    public List<Building> getBuildings(Connection con) {
        ArrayList<Building> buildings = new ArrayList<>();
        String sql = "select * from Building "
                + "join City on Building.zip = City.zip";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Building tempBuild = new Building(
                        rs.getInt("building_id"),
                        rs.getInt("customer_id"),
                        rs.getString("name"),
                        rs.getString("street"),
                        rs.getInt("size"),
                        rs.getInt("condition_level"),
                        rs.getInt("zip"),
                        rs.getString("city"));
                buildings.add(tempBuild);

            }
        } catch (Exception e) {
            System.out.println("Problem in BuildingMapper ");
            System.out.println(e.getMessage());
            return null;
        }
        return buildings;
    }
    
    // Returns an individual building
    public Building getBuilding(Connection con, int building_id) {
        Building building = null;
        String sql = "select * from Building where building_id=?";
        PreparedStatement stmt;
        try {
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, building_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                building = new Building(rs.getInt("building_id"),
                        rs.getInt("customer_id"),
                        rs.getString("name"),
                        rs.getString("street"),
                        rs.getInt("size"),
                        rs.getInt("condition_level"),
                        rs.getInt("zip"));
            }
            stmt.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(BuildingMapper.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Problem in getBuilding. Exception = " + ex);
        }
        return building;
    }

    // Saves changes made for building in database
    boolean saveBuildingEdits(Connection con, Building tempBuilding) {
        boolean result = false;
        String sqlString = "UPDATE Building "
                + "SET `name`=?, "
                + "`street`=?, "
                + "`zip`=?,"
                + "`size`=?,"
                + "`condition_level`=?,"
                + "`parcel_no`=? "
                + "WHERE `building_id`=?;";
        PreparedStatement stmt;
        try {
            stmt = con.prepareStatement(sqlString);
            stmt.setString(1, tempBuilding.getName());
            stmt.setString(2, tempBuilding.getStreet());
            stmt.setInt(3, tempBuilding.getZip());
            stmt.setInt(4, tempBuilding.getSize());
            stmt.setInt(5, tempBuilding.getCondition());
            stmt.setInt(6, tempBuilding.getParcel_no());
            stmt.setInt(7, tempBuilding.getBuildingID());
            stmt.execute();
            stmt.close();
            result = true;
        } catch (SQLException ex) {
            Logger.getLogger(BuildingMapper.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Exception in updateBuilding(). Exception: " + ex);
            result = false;
        }
        return result;
    }

    // Returns a list of all cities with their zip codes
    public ArrayList<CityList> getCityList(Connection con) {
        ArrayList<CityList> cityList = new ArrayList();
        String sqlString = "select * from City";
        Statement stmt = null;
        try {
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sqlString);
            while (rs.next()) {
                cityList.add(new CityList(rs.getInt(1), rs.getString(2)));
            }

            stmt.close();
            rs.close();
        } catch (SQLException ex) {
            System.out.println("Error in getCityList() method; exception: " + ex);
        }
        return cityList;
    }

    // Returns a list of buildings for a single customer
    public List<Building> getMyBuildings(Connection con, int customerID) {
        ArrayList<Building> myBuildings = new ArrayList<>();
        String sql = "select * from Building where customer_id=?";
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, customerID);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Building tempBuild = new Building(
                        rs.getInt("building_id"),
                        rs.getString("name"),
                        rs.getString("street"),
                        rs.getInt("zip"),
                        rs.getInt("parcel_no"),
                        rs.getInt("size"),
                        rs.getInt("year"),
                        rs.getString("buildingUse"),
                        rs.getInt("condition_level"),
                        rs.getInt("customer_id"));
                myBuildings.add(tempBuild);
            }
            statement.close();
            rs.close();
        } catch (Exception e) {
            System.out.println("Problem in BuildingMapper, getMyBuildings().");
            System.out.println(e.getMessage());
            return null;
        }
        return myBuildings;
    }
}
