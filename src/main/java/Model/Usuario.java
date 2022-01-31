package Model;

import DAO.ConnectionFactory;
import DAO.UsuarioDAOException;
import java.sql.ResultSet;
import java.sql.Statement;

public class Usuario {
    private int matricula, numeroEndereco;
    private String nome, emailLogin, senhaLogin, emailCredenciais, senhaCredenciais, ruaEndereco, bairroEndereco, cepEndereco;
    private boolean supermercado, administrador;

    public Usuario() {
        this.matricula = -1;
        this.numeroEndereco = -1;
        this.nome = null;
        this.emailLogin = null;
        this.senhaLogin = null;
        this.emailCredenciais = null;
        this.senhaCredenciais = null;
        this.ruaEndereco = null;
        this.bairroEndereco = null;
        this.cepEndereco = null;
        this.supermercado = false;
        this.administrador = false;
    }
    
    public Usuario(int matricula, int numeroEndereco, String nome, String emailLogin, String senhaLogin, String emailCredencias, String senhaCredencias, String ruaEndereco, String bairroEndereco, String cepEndereco, boolean supermercado, boolean administrador) {
        this.matricula = matricula;
        this.numeroEndereco = numeroEndereco;
        this.nome = nome;
        this.emailLogin = emailLogin;
        this.senhaLogin = senhaLogin;
        this.emailCredenciais = emailCredencias;
        this.senhaCredenciais = senhaCredencias;
        this.ruaEndereco = ruaEndereco;
        this.bairroEndereco = bairroEndereco;
        this.cepEndereco = cepEndereco;
        this.supermercado = supermercado;
        this.administrador = administrador;
    }
 
    public int getMatricula() {
        return this.matricula;
    }

    public void setMatricula(int matricula) {
        this.matricula = matricula;
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

    public String getEmailLogin() {
        return this.emailLogin;
    }

    public void setEmailLogin(String emailLogin) {
        this.emailLogin = emailLogin;
    }

    public String getSenhaLogin() {
        return this.senhaLogin;
    }

    public void setSenhaLogin(String senhaLogin) {
        this.senhaLogin = senhaLogin;
    }

    public String getEmailCredencias() {
        return this.emailCredenciais;
    }

    public void setEmailCredenciais(String emailCredencias) {
        this.emailCredenciais = emailCredencias;
    }

    public String getSenhaCredencias() {
        return this.senhaCredenciais;
    }

    public void setSenhaCredenciais(String senhaCredencias) {
        this.senhaCredenciais = senhaCredencias;
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

    public boolean isSupermercado() {
        return this.supermercado;
    }

    public void setSupermercado(boolean supermercado) {
        this.supermercado = supermercado;
    }

    public boolean isAdministrador() {
        return this.administrador;
    }

    public void setAdministrador(boolean administrador) {
        this.administrador = administrador;
    }
    
    public boolean BuscaUser(String emailLogin, String senhaLogin) throws UsuarioDAOException{
        boolean verificaUser = false;
        try {
            Statement stm = ConnectionFactory.getConnection().createStatement();
            ResultSet rs = stm.executeQuery("SELECT * FROM usuario AS u WHERE u.email_user = MD5('" + emailLogin + "') AND u.senha_user = MD5('" + senhaLogin + "');");
            
            while(rs.next()){
                verificaUser = true;
                                 
                setMatricula(rs.getInt("matricula_user"));
                setNumeroEndereco(rs.getInt("numero_user"));
                setNome(rs.getString("nome_user"));
                setEmailLogin(rs.getString("email_user"));
                setSenhaLogin(rs.getString("senha_user"));
                setEmailCredenciais(rs.getString("email_credenciais_user"));
                setSenhaCredenciais(rs.getString("senha_credenciais_user"));
                setRuaEndereco(rs.getString("rua_avenida_user"));
                setBairroEndereco(rs.getString("bairro_user"));
                setCepEndereco(rs.getString("CEP_user"));
                setSupermercado(rs.getBoolean("supermercado_user"));
                setAdministrador(rs.getBoolean("administrador_user"));     
            }
            ConnectionFactory.closeConnection(rs, stm);
            
        } catch (Exception e){
            throw new UsuarioDAOException(e.getMessage());
        }
        
        return verificaUser;
    }

}
