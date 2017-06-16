/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package JUnitTesting;

import DataSource.BuildingMapper;
import DataSource.DBConnector;
import Domain.Building;
import com.mysql.jdbc.Connection;
import java.util.List;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author edipetres
 */
public class BuildingMapperTester {
    
    public BuildingMapperTester() {
       
    }
    
    @Before
    public void setUp() {
        
    }
    
   
    @Test
    public void getAllBuildings() {
        final Connection con = (Connection) DBConnector.getInstance().getConnection();
        BuildingMapper buildingMapper = new BuildingMapper();
        List<Building> allBuildings = buildingMapper.getBuildings(con);
        assertTrue(!allBuildings.isEmpty());
    }
    @Test
    public void getBuildingsByID() {
        final Connection con = (Connection) DBConnector.getInstance().getConnection();
        BuildingMapper buildingMapper = new BuildingMapper();
        List<Building> myBuildings =  buildingMapper.getMyBuildings(con, 1);
        assertTrue(!myBuildings.isEmpty());
    }
    
}
