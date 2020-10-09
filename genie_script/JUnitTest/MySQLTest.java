import Server.DataManager;
import org.junit.Before;
import org.junit.Test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MySQLTest {

    DataManager dataManager;
    Connection connection;
    Statement stm;
    @Before
    public void setUp() {
        dataManager = DataManager.getInstance();
        dataManager.ConnectionDB();
        connection = dataManager.getConnection();
        stm = dataManager.getStatement();
    }
    @Test
    public void selectData() {
        try {
            stm = connection.createStatement();
            int patientId = 5;
            String sql = "SELECT id FROM patient WHERE id = " + patientId;
            ResultSet resultSet = stm.executeQuery(sql);
            if(resultSet != null) {
                System.out.println("no such a id");
            }
            while(resultSet.next()) {
                int id = resultSet.getInt("id");
                System.out.println(id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void insertDate() {
        try {
            stm = connection.createStatement();
            String sql = "INSERT INTO patient (id, surname, firstname, dob, email, street, suburb, state) " +
                    "VALUE (1001,'Mack','Li','1968-10-23','mack@example.com','668 Swanston st' ,'Carlton' ,'VIC')";
            stm.executeUpdate(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
