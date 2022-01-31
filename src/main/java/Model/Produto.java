package Model;

import java.sql.Date;

public class Produto {
    private int id;
    private String nome;
    private Date dataCadastro;

    public Produto(){
        this.id = -1;
        this. nome = null;
        this.dataCadastro = null;
    }
    
    public Produto(int id, String nome, Date dataCadastro){
        this.id = id;
        this.nome = nome;
        this.dataCadastro = dataCadastro;
    }
    
    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return this.nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Date getDataCadastro() {
        return this.dataCadastro;
    }

    public void setDataCadastro(Date dataCadastro) {
        this.dataCadastro = dataCadastro;
    }
    
}
