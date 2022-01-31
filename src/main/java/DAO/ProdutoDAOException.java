package DAO;

public class ProdutoDAOException extends Exception{
    
    public ProdutoDAOException(String message){
        super("ERRO...ERRO..." + message + "...ERRO...ERRO\n\n");
    }
    
}
