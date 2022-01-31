package DAO;

import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class ConnectionFactory {
    public static Connection con;
    
    public static Connection getConnection(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/comparejá?user=root&password=123456&autoReconnect=true&userSSL=false");
            
        }
        catch(Exception e){
            out.println("ERRO...ERRO...Open connction BD...ERRO...ERRO\n\n" + e.getMessage());
        }
        
        return con;
    }
    
    public static void closeConnection(){
        try{
            con.close();
        }
        catch(Exception e){
            out.println("ERRO...ERRO...Close connection BD...ERRO...ERRO\n\n" + e.getMessage());
        }
    }
    
    public static void closeConnection(PreparedStatement pstm){
        try{
            pstm.close();
            con.close();
        }
        catch(Exception e){
            out.println("ERRO...ERRO...Close connection BD...ERRO...ERRO\n\n" + e.getMessage());
        }
    }
    
    public static void closeConnection(Statement stm){
        try{
            stm.close();
            con.close();
        }
        catch(Exception e){
            out.println("ERRO...ERRO...Close(stm) connection BD...ERRO...ERRO\n\n" + e.getMessage());
        }
    }
   
    public static void closeConnection(ResultSet rs, Statement stm){
        try{
            rs.close();
            stm.close();
            con.close();
        }
        catch(Exception e){
            out.println("ERRO...ERRO...Close connection BD...ERRO...ERRO\n\n" + e.getMessage());
        }
    }
    
    public static void closeConnection(ResultSet rs, PreparedStatement pstm){
        try{
            rs.close();
            pstm.close();
            con.close();
        }
        catch(Exception e){
            out.println("ERRO...ERRO...Close connection BD...ERRO...ERRO\n\n" + e.getMessage());
        }
    }
}
