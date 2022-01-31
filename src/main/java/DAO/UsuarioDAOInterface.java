package DAO;

import Model.Usuario;

public interface UsuarioDAOInterface {
    public boolean cadastroUsuario(Usuario user) throws UsuarioDAOException;
    
}
