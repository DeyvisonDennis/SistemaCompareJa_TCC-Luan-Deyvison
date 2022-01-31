package Model;

import DAO.ConnectionFactory;
import java.sql.ResultSet;
import java.sql.Statement;

public class AlocacaoProdutoMercado{
    
    private int produtoId, mercadoId;
    private float preco;
    
    public AlocacaoProdutoMercado(){
        this.produtoId = -1;
        this.mercadoId = -1;
        this.preco = -1;
    }

    public AlocacaoProdutoMercado(int produtoId, int mercadoId, float preco) {
        this.produtoId = produtoId;
        this.mercadoId = mercadoId;
        this.preco = preco;
    }

    public int getProdutoId() {
        return this.produtoId;
    }

    public void setProdutoId(int produtoId) {
        this.produtoId = produtoId;
    }

    public int getMercadoId() {
        return this.mercadoId;
    }

    public void setMercadoId(int mercadoId) {
        this.mercadoId = mercadoId;
    }

    public float getPreco() {
        return this.preco;
    }

    public void setPreco(float preco) {
        this.preco = preco;
    }
  
}
