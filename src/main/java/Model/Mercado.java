package Model;

public class Mercado {
    private int id, numeroEndereco;
    private String nome, ruaEndereco, bairroEndereco, cepEndereco, linkEndereco;
    
    public Mercado(){
        this.id = -1 ;
        this.numeroEndereco = -1;
        this.nome = null;
        this.ruaEndereco = null;
        this.bairroEndereco = null;
        this.cepEndereco = null;
        this.linkEndereco = null;
    }
        
    public Mercado(int id, int numeroEndereco, String nome, String ruaEndereco, String bairroEndereco, String cepEndereco, String linkEndereco ){
        this.id = id ;
        this.numeroEndereco = numeroEndereco;
        this.nome = nome;
        this.ruaEndereco = ruaEndereco;
        this.bairroEndereco = bairroEndereco;
        this.cepEndereco = cepEndereco;
        this.linkEndereco = linkEndereco;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumeroEndereco() {
        return this.numeroEndereco;
    }

    public void setNumeroEndereco(int numeroEndereco) {
        this.numeroEndereco = numeroEndereco;
    }

    public String getNome() {
        return this.nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getRuaEndereco() {
        return this.ruaEndereco;
    }

    public void setRuaEndereco(String ruaEndereco) {
        this.ruaEndereco = ruaEndereco;
    }

    public String getBairroEndereco() {
        return this.bairroEndereco;
    }

    public void setBairroEndereco(String bairroEndereco) {
        this.bairroEndereco = bairroEndereco;
    }
    
    public String getCepEndereco() {
        return this.cepEndereco;
    }

    public void setCepEndereco(String cepEndereco) {
        this.cepEndereco = cepEndereco;
    }

    public String getLinkEndereco() {
        return this.linkEndereco;
    }

    public void setLinkEndereco(String linkEndereco) {
        this.linkEndereco = linkEndereco;
    }
    
}