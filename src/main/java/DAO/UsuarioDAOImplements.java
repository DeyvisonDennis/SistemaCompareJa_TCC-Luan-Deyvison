package DAO;

import Model.Usuario;
import java.sql.PreparedStatement;

public class UsuarioDAOImplements implements UsuarioDAOInterface {
     
     @Override
     public boolean cadastroUsuario(Usuario user) throws UsuarioDAOException {
       boolean boolReturn = false;
        
       try{
           PreparedStatement pstm = ConnectionFactory.getConnection().prepareStatement("INSERT INTO usuario(nome_user, email_user, senha_user, email_credenciais_user, senha_credenciais_user, rua_avenida_user, numero_user, bairro_user, CEP_user) VALUES (?, MD5(?), MD5(?), ?, ?, ?, ?, ?, ?);");
           pstm.setString(1, user.getNome());
           pstm.setString(2, user.getEmailLogin());
           pstm.setString(3, user.getSenhaLogin());
           pstm.setString(4, user.getEmailCredencias());
           pstm.setString(5, user.getSenhaCredencias());
           pstm.setString(6, user.getRuaEndereco());
           pstm.setInt(7, user.getNumeroEndereco());
           pstm.setString(8, user.getBairroEndereco());
           pstm.setString(9, user.getCepEndereco());
           
           boolReturn = pstm.execute();
           
           ConnectionFactory.closeConnection(pstm);
           
       }
       catch(Exception e){
           throw new UsuarioDAOException(e.getMessage());
       }
       
       return boolReturn;
    }
}
