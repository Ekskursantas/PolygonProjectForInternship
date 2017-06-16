/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package JUnitTesting;

import DataSource.DBFacade;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author edipetres
 */
public class CheckupReportTester {
    
    public CheckupReportTester() {
        
    }
    
    @Before
    public void setUp() {
    }
    
    @Test
    public void showCheckupReportTester() {
        DBFacade dbf = DBFacade.getInstance();
        assertTrue("empty",!dbf.showActiveCheckupReports().isEmpty());
        assertTrue("null",dbf.showActiveCheckupReports() != null);
    }
    
}
