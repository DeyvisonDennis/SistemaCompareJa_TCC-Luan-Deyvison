package Controller;

import DAO.UsuarioDAOImplements;
import Model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastroUserController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       try{
           request.setCharacterEncoding("utf-8");
           
           UsuarioDAOImplements dao = new UsuarioDAOImplements();
           Usuario user = new Usuario( -1, Integer.parseInt(request.getParameter("numero")), request.getParameter("name").toUpperCase(), request.getParameter("email").toLowerCase(), request.getParameter("password"), null, null, request.getParameter("rua"), request.getParameter("bairro"), request.getParameter("cep"), false, false);
           dao.cadastroUsuario(user);
           
           RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
           dispatcher.forward(request, response);
           
       }
       catch(Exception e){
           PrintWriter out = response.getWriter();
           out.print(e.getMessage());
       
       }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
