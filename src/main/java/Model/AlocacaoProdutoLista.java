package Model;

import DAO.AlocacaoProdutoListaDAOException;
import DAO.ConnectionFactory;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class AlocacaoProdutoLista {
    
    private int id_lista, id_produto, id_mercado;

    public AlocacaoProdutoLista(){
        this.id_lista = -1;
        this.id_produto = -1;
        this.id_mercado = -1;
    }
    
    public AlocacaoProdutoLista(int id_lista, int id_produto, int id_mercado) {
         this.id_lista = id_lista;
         this.id_produto = id_produto;
         this.id_mercado = id_mercado;
    }

    public int getId_lista() {
        return this.id_lista;
    }

    public void setId_lista(int id_lista) {
        this.id_lista = id_lista;
    }

    public int getId_produto() {
        return this.id_produto;
    }

    public void setId_produto(int id_produto) {
        this.id_produto = id_produto;
    }

    public int getId_mercado() {
        return this.id_mercado;
    }

    public void setId_mercado(int id_mercado) {
        this.id_mercado = id_mercado;
    }
    
    public boolean addProdutoNaLista() throws AlocacaoProdutoListaDAOException{
        boolean boolReturn = false;
        
        try{
            PreparedStatement pstm = ConnectionFactory.getConnection().prepareStatement("INSERT INTO alocacaoprodutolista VALUES (?, ?, ?);");
            pstm.setInt(1, id_lista);
            pstm.setInt(2, id_produto);
            pstm.setInt(3, id_mercado);
            
            boolReturn = pstm.execute();
            ConnectionFactory.closeConnection(pstm);
        }
        catch(Exception e){
            throw new AlocacaoProdutoListaDAOException(e.getMessage());
        }
        
        return boolReturn;
    }
    
    public boolean removeProdutoNaLista() throws AlocacaoProdutoListaDAOException{
        boolean boolReturn = false;
        
        try{
            PreparedStatement pstm = ConnectionFactory.getConnection().prepareStatement("DELETE FROM alocacaoprodutolista WHERE id_lista=? AND id_produto_alocacaoProdutoMercado=? AND id_mercado_alocacaoProdutoMercado=?;");
            pstm.setInt(1, id_lista);
            pstm.setInt(2, id_produto);
            pstm.setInt(3, id_mercado);
            
            boolReturn = pstm.execute();
            ConnectionFactory.closeConnection(pstm);
        }
        catch(Exception e){
            throw new AlocacaoProdutoListaDAOException(e.getMessage());
        }
        
        return boolReturn;
    }
    
     public float ReturnTotalList(int idList) throws AlocacaoProdutoListaDAOException{
        float returnTotal = 0;
        
        try{
            Statement stm = ConnectionFactory.getConnection().createStatement();
            ResultSet rs = stm.executeQuery("SELECT apl.id_lista, apl.id_produto_alocacaoProdutoMercado, apl.id_mercado_alocacaoProdutoMercado, apm.preco FROM alocacaoprodutolista AS apl INNER JOIN alocacaoprodutomercado as apm ON apm.Produto = apl.id_produto_alocacaoProdutoMercado AND apm.Mercado = apl.id_mercado_alocacaoProdutoMercado WHERE apl.id_lista = " + idList + ";");
            
            while(rs.next()){
                returnTotal = returnTotal + rs.getFloat("preco");
            }
            
            ConnectionFactory.closeConnection(rs, stm);
        }
        catch(Exception e){
            throw new AlocacaoProdutoListaDAOException(e.getMessage());
        }
        
        return returnTotal;
        
    }
    
    public float ReturnTotalList(int idList, int idMercado) throws AlocacaoProdutoListaDAOException{
        float returnTotal = 0;
        
        try{
            
        }
        catch(Exception e){
            throw new AlocacaoProdutoListaDAOException(e.getMessage());
        }
        
        return returnTotal;
        
    }
    
}
