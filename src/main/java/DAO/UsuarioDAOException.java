package DAO;

public class UsuarioDAOException extends Exception{
    
    public UsuarioDAOException(String message){
        super("ERRO...ERRO..." + message + "...ERRO...ERRO\n\n");
    }
    
}
