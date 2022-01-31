package Model;

import DAO.ConnectionFactory;
import DAO.ListaDAOException;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class Lista {
    
    private int id, id_usuario;
    private String nome;
    private Date data_criacao;

    public Lista() {
        this.id = -1;
        this.id_usuario = -1;
        this.nome = null;
        this.data_criacao = null;
    }
    
    public Lista(int id, int id_usuario, String nome, Date data_criacao) {
        this.id = id;
        this.id_usuario = id_usuario;
        this.nome = nome;
        this.data_criacao = data_criacao;
    }
    
    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_usuario() {
        return this.id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getNome() {
        return this.nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Date getData_criacao() {
        return this.data_criacao;
    }

    public void setData_criacao(Date data_criacao) {
        this.data_criacao = data_criacao;
    }
    
    public boolean CreateList(String nameList, int idUser) throws ListaDAOException{
        boolean boolReturn = false;
        
        try{
            PreparedStatement pstm = ConnectionFactory.getConnection().prepareStatement("INSERT INTO lista(nome_lista, id_usuario_lista, data_criacao_lista) VALUES (?, ?, NOW());");
            pstm.setString(1, nameList);
            pstm.setInt(2, idUser);
            
            boolReturn = pstm.execute();
            ConnectionFactory.closeConnection(pstm);
        }
        catch(Exception e){
           throw new ListaDAOException(e.getMessage());
        }
        
        return boolReturn;
    }
    
    public boolean RemoveList(int idList) throws ListaDAOException{
       boolean boolReturn = false;
        
        try{
            Statement stm =ConnectionFactory.getConnection().createStatement();
            ResultSet rs = stm.executeQuery("SELECT * FROM alocacaoprodutolista WHERE id_lista =" + idList + ";");
            
            boolean estaVinculado = false;
            
            while(rs.next()){
                estaVinculado = true;
            }
            
            ConnectionFactory.closeConnection(rs, stm);
            
            if(!estaVinculado){
                PreparedStatement pstm = ConnectionFactory.getConnection().prepareStatement("DELETE FROM lista WHERE id_lista=?;");
                pstm.setInt(1, idList);

                boolReturn = pstm.execute();
                ConnectionFactory.closeConnection(pstm);
            }
            else{
                PreparedStatement pstm = ConnectionFactory.getConnection().prepareStatement("DELETE FROM alocacaoprodutolista WHERE id_lista=?;");
                pstm.setInt(1, idList);

                boolReturn = pstm.execute();
                ConnectionFactory.closeConnection(pstm);
                
                PreparedStatement pstm2 = ConnectionFactory.getConnection().prepareStatement("DELETE FROM lista WHERE id_lista=?;");
                pstm2.setInt(1, idList);

                boolReturn = pstm2.execute();
                ConnectionFactory.closeConnection(pstm2);
            }
        }
        catch(Exception e){
           throw new ListaDAOException(e.getMessage());
        }
        
        return boolReturn; 
    }
}
