
<%@page import="java.text.DecimalFormat"%>
<%@page import="Model.AlocacaoProdutoMercado"%>
<%@page import="Model.Lista"%>
<%@page import="Model.AlocacaoProdutoLista"%>
<%@page import="Model.Usuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DAO.ConnectionFactory"%>
<%@page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <title>Compare já - Listas</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <style>
            body{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Ubuntu", sans-serif;
                min-height: 100vh;
            }

            .navbar{
                position: fixed;
                top: 0;
                background-color: #00AA55;
                width: 100%;
                height: 100px;
                z-index: 999;
                transition: .3s linear;
                border-bottom: 3px solid rgba(0, 0, 0, 0.12);
            }
            
            .inner-width{
                max-width: 1300px;
                padding: 0 20px;
                margin: auto;
            }
            
            .navbar .inner-width{
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            
            .logo{
                width: 315px;
                height: 100px;
                overflow: hidden;
                background: url(../img/LogoPrincipal.png) no-repeat center;
                background-size: contain; 
                
            }
            
            .menu-toggler{
                background: none;
                width: 45px;
                border: none;
                cursor: pointer;
                position: relative;
                outline: none;
                z-index: 999;
                display: none;
            }
            
            .menu-toggler span{
                display: block;
                height: 3px;
                background-color: white;
                margin: 6px 0;
                position: relative;
                transition: .3s linear;
                border-radius: 2px;
            }
            
            .navbar-menu a{
                text-decoration: none;
                color: white;
                font-size: 20px;
                font-weight: 600;
                margin: 30px;
                transition: .2s linear;
            }
            
            .navbar-menu a:hover{
                color: rgb(220, 220, 220);
            }
            
            .Container{
                width: 100%;
                height: calc(100% - 100px);
                display: flex;
                align-content: center;
                position: absolute;
                top: 100px;
            }
            
            .tableClass{
                margin: 20px 0px 0px 5px;
                width: 380px;
            }
            
            .bottom:hover{
                background-color: rgba(0, 0, 0, 0.12);
            }
            
            .containerProduto{
                max-width: 250px;
                max-height: 300px;
                display: flex;
                align-items: center;
                flex-direction: column;
            }
            
            .imgProd{
                width: 250px;
                height: 180px;
            }
            
            .ImgSup{
                position: relative;
                top: -94%;
                left: -37.5%;
                width: 60px;
                height: 60px; 
            }
            
            .buttonRemove{
                position: relative; 
                top: -310px;
                right: -90px;
            }
            
            .buttonRemove a{
                text-decoration: none;
            }
            
            .flex{
                display: flex;
                flex-wrap: wrap;
                max-width: 625px;
                margin: 0 auto;
                margin-top: 30px;
            }
            
            .flex > div{
                flex: 1 1 250px;
                margin: 30px;
            }
            
            .InputCreateList{
                background: rgb(240,240,240);
                width: 300px;
                height: 40px;
                padding: 0 0.5rem;
                margin-top: 1rem;
                margin-bottom: 1rem;
                color: rgb(50,50,50);
                outline: none;
                font-size: 1.5rem;
                border: 1px solid #040B18;
                border-radius: 8px;
            }
            
            .TotalPreco{
                width: 180px;
                height: 70px;
                position: absolute;
                bottom: 2%;
                right: 3%;
                border-radius: 5px;
                background-color: rgb(0, 155, 60);
                color: white;
                padding: 5px;
                text-align: center;
                vertical-align: middle;
            }
            
            @media screen and (max-width: 980px){
                .menu-toggler{
                    display: block;
                }
                
                .navbar-menu{
                    position: fixed;
                    height: 100vh;
                    width: 100%;
                    background-color: rgb(0, 165, 70);
                    border-left: 4px solid rgba(0, 0, 0, 0.12);
                    top: 0;
                    right: -100%;
                    max-width: 300px;
                    padding: 70px 40px;
                    transition: .3s linear;
                }
                
                .navbar-menu a{
                    display: block;
                    font-size: 20px;
                    margin: 30px 0;
                }
                
                .navbar-menu.active{
                    right: 0;
                }
                
                .menu-toggler.active span:nth-child(1){
                    transform: rotate(-45deg);
                    top: 4px;
                }
                
                .menu-toggler.active span:nth-child(2){
                    opacity: 0;
                }
                
                .menu-toggler.active span:nth-child(3){
                    transform: rotate(45deg);
                    bottom: 14px;
                }
            }
        </style>
        <script>
            
            $(document).ready(function(){
               $('.menu-toggler').click(function(){
                   $(this).toggleClass("active");
                   $(".navbar-menu").toggleClass("active");
               });
            });
            
        </script>
    </head>
    <body>
        <%
            request.setCharacterEncoding("utf-8");
        
            Usuario usuarioLogado = (Usuario)session.getAttribute("usuarioLogado");
            
        %>
        
        <nav class="navbar">
            <div class="inner-width">
                <a class="logo" href="Principal.jsp?acessoPermitido=true"></a>
                <button class="menu-toggler">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
                <div class="navbar-menu">
                    <a href="Principal.jsp?acessoPermitido=true" >Pesquisar</a>
                    <a href="Lista.jsp">Listas</a>
                    <a href="../index.jsp?Logout=true">Sair</a>
                </div>
            </div>
        </nav>
        
        <section class="Container">
            <div style="width: 35%; height: 100%; overflow-x: hidden; overflow-y: scroll;">
             
            <%
                boolean verificaList = false;
                
                if(request.getParameter("submitList") != null){
                    if((request.getParameter("criarLista") != null) && (request.getParameter("criar") != null)){
                        Lista newList = new Lista();
                        newList.CreateList(request.getParameter("criar").toString(), Integer.parseInt(request.getParameter("criarLista")));
                    }
                }
                
                if(request.getParameter("removerLista") != null){
                    Lista removeList = new Lista();
                    removeList.RemoveList(Integer.parseInt(request.getParameter("removerLista")));
                }
                
                if((request.getParameter("addProdutoNO") != null) && (request.getParameter("addProdMercadoNO") != null)){
            %>                                   
                    <table class="tableClass">
                        <tr style="background-color: #00AA55; color: white; margin-bottom: 10px;">
                            <td class="bottom" colspan="3" align="center" style="font-size: 20px; font-family: 'Comic Sans MS' , Comic San;"><a style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);" href="Lista.jsp?criarLista=<% out.print(usuarioLogado.getMatricula()); %>">Criar Nova Lista </a></td>
                        </tr>

                    <%
                        Statement stm4 = ConnectionFactory.getConnection().createStatement();
                        ResultSet rs4 = stm4.executeQuery("SELECT * FROM lista AS l WHERE l.id_usuario_lista = " + usuarioLogado.getMatricula() + ";");

                        while(rs4.next()){
                            verificaList = true;  
                            %>
                                <tr style="font-family: 'Comic Sans MS' , Comic San; font-weight: 700;">
                                    <td style="padding: 5px; font-size: 10px; " width="20%"><a style=" display: block; text-decoration: none; color: black; " href="Lista.jsp?addProduto=<% out.print(request.getParameter("addProdutoNO")); %>&addProdList=<% out.print(rs4.getInt("id_lista")); %>&addProdMercado=<% out.print(request.getParameter("addProdMercadoNO")); %>"><% out.print(rs4.getDate("data_criacao_lista")); %></a></td>
                                    <%
                                        if(rs4.getString("nome_lista").length() >= 20){
                                            %><td style="padding: 5px;" width="60%"><a style=" display: block; text-decoration: none; color: black; " href="Lista.jsp?addProduto=<% out.print(request.getParameter("addProdutoNO")); %>&addProdList=<% out.print(rs4.getInt("id_lista")); %>&addProdMercado=<% out.print(request.getParameter("addProdMercadoNO")); %>"><% out.print(rs4.getString("nome_lista").substring(0, 20) + "..."); %></a></td><%
                                        }
                                        else{
                                            %><td style="padding: 5px;" width="60%"><a style=" display: block; text-decoration: none; color: black; " href="Lista.jsp?addProduto=<% out.print(request.getParameter("addProdutoNO")); %>&addProdList=<% out.print(rs4.getInt("id_lista")); %>&addProdMercado=<% out.print(request.getParameter("addProdMercadoNO")); %>"><% out.print(rs4.getString("nome_lista")); %></a></td><%
                                        }
                                    %>
                                    <td style="padding: 5px; font-size: 18px; " width="10%" align="center"><a style=" display: block; text-decoration: none; color: black; " href="Lista.jsp?addProduto=<% out.print(request.getParameter("addProdutoNO")); %>&addProdList=<% out.print(rs4.getInt("id_lista")); %>&addProdMercado=<% out.print(request.getParameter("addProdMercadoNO")); %>"><i style="font-weight: 700;" class="material-icons">add_shopping_cart</i></i></a></td>
                                </tr>
                            <%
                        }

                        ConnectionFactory.closeConnection(rs4, stm4);
                }
                else{
                %>
                    <table class="tableClass">
                        <tr style="background-color: #00AA55; color: white; margin-bottom: 10px;">
                            <td class="bottom" colspan="4" align="center" style="font-size: 20px; font-family: 'Comic Sans MS' , Comic San;"><a style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);" href="Lista.jsp?criarLista=<% out.print(usuarioLogado.getMatricula()); %>">Criar Nova Lista </a></td>
                        </tr>

                        <%
                            Statement stm4 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs4 = stm4.executeQuery("SELECT * FROM lista AS l WHERE l.id_usuario_lista = " + usuarioLogado.getMatricula() + ";");
                        
                        while(rs4.next()){
                            verificaList = true;
                            %>
                                <tr style="font-family: 'Comic Sans MS' , Comic San; font-weight: 700;">
                                     <td style="padding: 5px; font-size: 10px; " width="20%"><% out.print(rs4.getDate("data_criacao_lista")); %></td>
                                     <%
                                         if(rs4.getString("nome_lista").length() >= 20){
                                             %><td style="padding: 5px;" width="60%"><% out.print(rs4.getString("nome_lista").substring(0, 20) + "..."); %></td><%
                                         }
                                         else{
                                             %><td style="padding: 5px;" width="60%"><% out.print(rs4.getString("nome_lista")); %></td><%
                                         }
                                     %>
                                     <td style="padding: 5px;" width="10%" align="center"><a style=" display: block; text-decoration: none; color: black; " href="Lista.jsp?visualizarLista=<% out.print(rs4.getInt("id_lista")); %>"><i class="material-icons" style="font-size: 26px">pageview</i></i></a></td>
                                     <td style="padding: 5px;" width="10%" align="center"><a style=" display: block; text-decoration: none; color: black; " href="Lista.jsp?removerLista=<% out.print(rs4.getInt("id_lista")); %>"><i class="fas fa-calendar-times" style="font-size: 21px"></i></a></td>
                                </tr>
                            <%
                        }
                        ConnectionFactory.closeConnection(rs4, stm4);
                    }
                   %>
                </table>
            </div>
            
            <%
                if((verificaList == false) && (request.getParameter("criarLista") == null) && (request.getParameter("removerLista") == null)){
                    %>
                        <div style=" width: 65%; height: 100%;">
                            <br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">Você não possuí nenhuma lista! Que tal criar uma? </p>     
                        </div>
                    <%
                }

                if(request.getParameter("submitList") != null){
                    if((request.getParameter("criarLista") != null) && (request.getParameter("criar") != null)){
                        Statement stm9 = ConnectionFactory.getConnection().createStatement();
                        ResultSet rs9 = stm9.executeQuery("SELECT * FROM lista AS l WHERE l.id_usuario_lista = " + usuarioLogado.getMatricula() + ";");
                        
                        int guardaId =0;
                        while(rs9.next()){
                            guardaId = rs9.getInt("id_lista");
                        }
                        ConnectionFactory.closeConnection(rs9, stm9);

                        Statement stm8 = ConnectionFactory.getConnection().createStatement();
                        ResultSet rs8 = stm8.executeQuery("SELECT * FROM lista AS l WHERE l.id_usuario_lista = " + usuarioLogado.getMatricula() + ";");
                        
                        while(rs8.next()){
                            if(guardaId == rs8.getInt("id_lista")){
                                %>
                                <div style=" width: 65%; height:  100%; overflow-x: hidden; overflow-y: scroll;">
                                    <div style="display: flex; justify-content: space-between; padding: 5px; margin-top: 15px; font-family: 'Comic Sans MS' , Comic San; padding-right: 10px; margin-bottom: 15px;">
                                        <%
                                            if(rs8.getString("nome_lista").length() >= 20){
                                                %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs8.getString("nome_lista").substring(0, 20) + "..."); %></div><%
                                            }
                                            else{
                                                %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs8.getString("nome_lista")); %></div><%
                                            }
                                        %>
                                        <div style="background-color: #00AA55; color: white; font-size: 16px;"><a href="Principal.jsp?acessoPermitido=true&addProdList=<% out.print(rs8.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">add_shopping_cart</i> Adicionar Produto <i style="font-size: 18px;" class="material-icons">add_shopping_cart</i></a></div>
                                    </div>
                                    <div>
                                        <br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">A lista está vazia! que tal adicionar alguns produtos?</p>     
                                    </div>
                                </div>
                                <%
                            }
                        }
                        ConnectionFactory.closeConnection(rs8, stm8);
                    }
                }
                else if(request.getParameter("removerLista") != null){
                    %>
                    <div style=" width: 65%; height:  100%; overflow-x: hidden; overflow-y: scroll;">
                        <div>
                            <br><br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">Lista removida com sucesso!</p>     
                        </div>
                    </div>
                    <%
                }
                else if(request.getParameter("criarLista") != null){
                    %>
                        <div style=" width: 65%; height: 100%; margin-top: 25px; margin-left: 30px;">
                            <form method="post" action="Lista.jsp?criarLista=<% out.print(request.getParameter("criarLista")); %>">
                                <label style="font-size: 24px; font-weight: 700;">Qual o nome da Lista?</label><br>
                                <input class="InputCreateList" type="text" name="criar" placeholder="Digite o nome da Lista... " required><br>
                                <button name="submitList" style="color: white; display: block; padding: 2px; cursor: pointer; background-color: #00AA55; font-size: 16px; border: 3px solid rgba(0, 0, 0, 0.12); border-radius: 4px; width: 60px;">Criar</button>
                            </form>
                        </div>
                    <%
                }
                else if((request.getParameter("addProdList") != null) && (request.getParameter("addProduto") != null) && (request.getParameter("addProdMercado") != null)){
                    AlocacaoProdutoLista alocacaoProdList = new AlocacaoProdutoLista(Integer.parseInt(request.getParameter("addProdList")), Integer.parseInt(request.getParameter("addProduto")), Integer.parseInt(request.getParameter("addProdMercado")));
                    boolean add = alocacaoProdList.addProdutoNaLista();
                    float valorTotalProdutos = alocacaoProdList.ReturnTotalList(Integer.parseInt(request.getParameter("addProdList")));
                    
                    %>
                        <div style=" width: 65%; height:  100%; overflow-x: hidden; overflow-y: scroll;">
                            
                            <%  
                                Statement stm6 = ConnectionFactory.getConnection().createStatement();
                                ResultSet rs6 = stm6.executeQuery("SELECT apl.id_lista, l.nome_lista, p.id_produto, p.nome_produto, p.data_cadastro_produto, apm.preco, m.id_mercado, m.nome_mercado, m.linkEnd_mercado FROM alocacaoprodutolista AS apl INNER JOIN alocacaoprodutomercado AS apm ON apl.id_produto_alocacaoProdutoMercado = apm.Produto AND apl.id_mercado_alocacaoProdutoMercado = apm.Mercado INNER JOIN produto AS p ON p.id_produto = apm.Produto INNER JOIN mercado AS m ON m.id_mercado = apm.Mercado INNER JOIN lista AS l ON l.id_lista = apl.id_lista WHERE apl.id_lista = " + Integer.parseInt(request.getParameter("addProdList")) + " ORDER BY p.data_cadastro_produto ASC;");
                                
                                int i=0;
                                while(rs6.next()){
                                    if(i == 0){
                                        %>  
                                            <div style="display: flex; justify-content: space-between; padding: 5px; margin-top: 15px; font-family: 'Comic Sans MS' , Comic San; padding-right: 10px; margin-bottom: 15px;">
                                                <%
                                                    if(rs6.getString("nome_lista").length() >= 20) {
                                                        %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs6.getString("nome_lista").substring(0, 20) + "..."); %></div><%
                                                    }
                                                    else{
                                                        %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs6.getString("nome_lista")); %></div><%
                                                    }
                                                %>
                                                <div style="display: flex; justify-content: space-between;">
                                                    <div style="background-color: #00AA55; color: white; font-size: 16px; margin-right: 5px;"><a href="OperacaoEspecial.jsp?IdList=<% out.print(rs6.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">access_time</i> Filtragem Avançada <i style="font-size: 18px;" class="material-icons">access_time</i></a></div>
                                                    <div style="background-color: #00AA55; color: white; font-size: 16px;"><a href="Principal.jsp?acessoPermitido=true&addProdList=<% out.print(rs6.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">add_shopping_cart</i> Adicionar Produto <i style="font-size: 18px;" class="material-icons">add_shopping_cart</i></a></div>
                                                </div>
                                            </div>
                                            <nav class="flex">
                                        <%
                                    }
                                    %>
                                        <div class="containerProduto">
                                            <center><span class="imgProd"><img src="../img/Produtos/<% out.print(rs6.getInt("id_produto")); %>.png" width="60%"></span></center>
                                            <span style="font-size: 18px; font-style: italic; color: black; padding: 10px;"><p><% out.print(rs6.getString("nome_produto")); %></p><p><font style=" font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;">R$ <% out.print(rs6.getString("preco")); %></font></p></span>
                                            <span class="imgSup"><a href="<% out.print(rs6.getString("linkEnd_mercado")); %>"><img src="../img/Produtos/<% out.print(rs6.getInt("id_mercado")); %>_1.png" width="100%" /></a></span>
                                            <span class="buttonRemove"><a href="Lista.jsp?removeProdList=<% out.print(rs6.getInt("id_lista")); %>&removeProduto=<% out.print(rs6.getInt("id_produto")); %>&removeProdMercado=<% out.print(rs6.getInt("id_mercado")); %>"><i style="font-size: 25px; display: block; color: black;" class="material-icons">remove_shopping_cart</i></a></span>
                                        </div>
                                    <%
                                    i++;
                                }

                                ConnectionFactory.closeConnection(rs6, stm6);

                                %>  
                            </div>
                            <div class="TotalPreco">
                                <font style="font-style: italic; font-size: 21px; font-family: 'Comic Sans MS' , Comic San;">Total a pagar</font><br>
                                <font style="font-size: 21px; font-family: 'Marker Felt', fantasy; font-style: italic;"> R$ <% out.print( new DecimalFormat("#,##0.00").format(valorTotalProdutos)); %></font>
                               </div>
                        </div>
                    <%
                    
                }
                else if((request.getParameter("addProdutoNO") != null) && (request.getParameter("addProdMercadoNO") != null) && (verificaList == true)){
                    %>
                        <div style=" width: 65%; height: 100%;">
                            <br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">Por favor, selecione a lista!</p>     
                        </div>
                    <%
                }
                else if(request.getParameter("visualizarLista") != null){
                    AlocacaoProdutoLista buscaValorTotal = new AlocacaoProdutoLista();
                    float valorTotalList = buscaValorTotal.ReturnTotalList(Integer.parseInt(request.getParameter("visualizarLista")));
                    %>
                        <div style=" width: 65%; height:  100%; overflow-x: hidden; overflow-y: scroll; margin-left: 3px;">
                            
                            <%  
                                Statement stm5 = ConnectionFactory.getConnection().createStatement();
                                ResultSet rs5 = stm5.executeQuery("SELECT apl.id_lista, l.nome_lista, p.id_produto, p.nome_produto, p.data_cadastro_produto, apm.preco, m.id_mercado, m.nome_mercado, m.linkEnd_mercado FROM alocacaoprodutolista AS apl INNER JOIN alocacaoprodutomercado AS apm ON apl.id_produto_alocacaoProdutoMercado = apm.Produto AND apl.id_mercado_alocacaoProdutoMercado = apm.Mercado INNER JOIN produto AS p ON p.id_produto = apm.Produto INNER JOIN mercado AS m ON m.id_mercado = apm.Mercado INNER JOIN lista AS l ON l.id_lista = apl.id_lista WHERE apl.id_lista = " + Integer.parseInt(request.getParameter("visualizarLista")) + " ORDER BY p.data_cadastro_produto ASC;");
                                
                                int i=0;
                                while(rs5.next()){
                                    if(i == 0){
                                        %>  
                                            <div style="display: flex; justify-content: space-between; padding: 5px; margin-top: 15px; font-family: 'Comic Sans MS' , Comic San; padding-right: 10px; margin-bottom: 15px;">
                                                <%
                                                    if(rs5.getString("nome_lista").length() >= 20) {
                                                        %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs5.getString("nome_lista").substring(0, 20) + "..."); %></div><%
                                                    }
                                                    else{
                                                        %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs5.getString("nome_lista")); %></div><%
                                                    }
                                                %>
                                                <div style="display: flex; justify-content: space-between;">
                                                    <div style="background-color: #00AA55; color: white; font-size: 16px; margin-right: 5px;"><a href="OperacaoEspecial.jsp?IdList=<% out.print(rs5.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">access_time</i> Filtragem Avançada <i style="font-size: 18px;" class="material-icons">access_time</i></a></div>
                                                    <div style="background-color: #00AA55; color: white; font-size: 16px;"><a href="Principal.jsp?acessoPermitido=true&addProdList=<% out.print(rs5.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">add_shopping_cart</i> Adicionar Produto <i style="font-size: 18px;" class="material-icons">add_shopping_cart</i></a></div>
                                                </div>
                                            </div>
                                            <nav class="flex">
                                        <%
                                    }
                                    %>
                                        <div class="containerProduto">
                                            <center><span class="imgProd"><img src="../img/Produtos/<% out.print(rs5.getInt("id_produto")); %>.png" width="60%"></span></center>
                                            <span style="font-size: 18px; font-style: italic; color: black; padding: 10px;"><p><% out.print(rs5.getString("nome_produto")); %></p><p><font style=" font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;">R$ <% out.print(rs5.getString("preco")); %></font></p></span>
                                            <span class="imgSup"><a href="<% out.print(rs5.getString("linkEnd_mercado")); %>"><img src="../img/Produtos/<% out.print(rs5.getInt("id_mercado")); %>_1.png" width="100%" /></a></span>
                                            <span class="buttonRemove"><a href="Lista.jsp?removeProdList=<% out.print(rs5.getInt("id_lista")); %>&removeProduto=<% out.print(rs5.getInt("id_produto")); %>&removeProdMercado=<% out.print(rs5.getInt("id_mercado")); %>"><i style="font-size: 25px; display: block; color: black;" class="material-icons">remove_shopping_cart</i></a></span>
                                        </div>
                                    <%
                                    i++;
                                }

                                ConnectionFactory.closeConnection(rs5, stm5);
                                
                                if(i != 0){
                                    %>
                                        </nav>
                                        </div>
                                        <div class="TotalPreco">
                                            <font style="font-style: italic; font-size: 21px; font-family: 'Comic Sans MS' , Comic San;">Total a pagar</font><br>
                                            <font style="font-size: 21px; font-family: 'Marker Felt', fantasy; font-style: italic;"> R$ <% out.print(new DecimalFormat("#,##0.00").format(valorTotalList)); %></font>
                                        </div>
                                    <%
                                }

                                if(i == 0){
                                    Statement stm10 = ConnectionFactory.getConnection().createStatement();
                                    ResultSet rs10 = stm10.executeQuery("SELECT * FROM lista WHERE id_lista= " + Integer.parseInt(request.getParameter("visualizarLista")) + ";");

                                    while(rs10.next()){
                                     %>
                                        <div style="display: flex; justify-content: space-between; padding: 5px; margin-top: 15px; font-family: 'Comic Sans MS' , Comic San; padding-right: 10px; margin-bottom: 15px;">
                                            <%
                                            if(rs10.getString("nome_lista").length() >= 20) {
                                                %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs10.getString("nome_lista").substring(0, 20) + "..."); %></div><%
                                            }
                                            else{
                                               %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs10.getString("nome_lista")); %></div><% 
                                            }
                                            %>
                                            <div style="background-color: #00AA55; color: white; font-size: 16px;"><a href="Principal.jsp?acessoPermitido=true&addProdList=<% out.print(rs10.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">add_shopping_cart</i> Adicionar Produto <i style="font-size: 18px;" class="material-icons">add_shopping_cart</i></a></div>
                                        </div>
                                        <div>
                                            <br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">A lista está vazia! que tal adicionar alguns produtos?</p>     
                                        </div>
                                    <%
                                    }
                                    ConnectionFactory.closeConnection(rs10, stm10);
                                }
                }
                else if((request.getParameter("removeProdList") != null) && (request.getParameter("removeProduto") != null)  && (request.getParameter("removeProdMercado") != null)){
                    AlocacaoProdutoLista alocacaoListProd = new AlocacaoProdutoLista(Integer.parseInt(request.getParameter("removeProdList")), Integer.parseInt(request.getParameter("removeProduto")), Integer.parseInt(request.getParameter("removeProdMercado")));
                    boolean remove = alocacaoListProd.removeProdutoNaLista();
                    float valorTotal = alocacaoListProd.ReturnTotalList(Integer.parseInt(request.getParameter("removeProdList")));
                    %>
                        <div style=" width: 65%; height:  100%; overflow-x: hidden; overflow-y: scroll; margin-left: 3px;">
                            
                            <%  
                                Statement stm7 = ConnectionFactory.getConnection().createStatement();
                                ResultSet rs7 = stm7.executeQuery("SELECT apl.id_lista, l.nome_lista, p.id_produto, p.nome_produto, p.data_cadastro_produto, apm.preco, m.id_mercado, m.nome_mercado, m.linkEnd_mercado FROM alocacaoprodutolista AS apl INNER JOIN alocacaoprodutomercado AS apm ON apl.id_produto_alocacaoProdutoMercado = apm.Produto AND apl.id_mercado_alocacaoProdutoMercado = apm.Mercado INNER JOIN produto AS p ON p.id_produto = apm.Produto INNER JOIN mercado AS m ON m.id_mercado = apm.Mercado INNER JOIN lista AS l ON l.id_lista = apl.id_lista WHERE apl.id_lista = " + Integer.parseInt(request.getParameter("removeProdList")) + " ORDER BY p.data_cadastro_produto ASC;");
                                
                                int i=0;
                                while(rs7.next()){
                                    if(i == 0){
                                    %>  
                                            <div style="display: flex; justify-content: space-between; padding: 5px; margin-top: 15px; font-family: 'Comic Sans MS' , Comic San; padding-right: 10px; margin-bottom: 15px;">
                                                <%
                                                    if(rs7.getString("nome_lista").length() >= 20){
                                                %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs7.getString("nome_lista").substring(0, 20) + "..."); %></div><%
                                                    }
                                                    else{
                                                        %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs7.getString("nome_lista")); %></div><%
                                                    }
                                                
                                                %>
                                                <div style="display: flex; justify-content: space-between;">
                                                    <div style="background-color: #00AA55; color: white; font-size: 16px; margin-right: 5px;"><a href="OperacaoEspecial.jsp?IdList=<% out.print(rs7.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">access_time</i> Filtragem Avançada <i style="font-size: 18px;" class="material-icons">access_time</i></a></div>
                                                    <div style="background-color: #00AA55; color: white; font-size: 16px;"><a href="Principal.jsp?acessoPermitido=true&addProdList=<% out.print(rs7.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">add_shopping_cart</i> Adicionar Produto <i style="font-size: 18px;" class="material-icons">add_shopping_cart</i></a></div>
                                                </div>
                                            </div>
                                            <nav class="flex">
                                        <%
                                    }
                                    %>
                                        <div class="containerProduto">
                                            <center><span class="imgProd"><img src="../img/Produtos/<% out.print(rs7.getInt("id_produto")); %>.png" width="60%"></span></center>
                                            <span style="font-size: 18px; font-style: italic; color: black; padding: 10px;"><p><% out.print(rs7.getString("nome_produto")); %></p><p><font style=" font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;">R$ <% out.print(rs7.getString("preco")); %></font></p></span>
                                            <span class="imgSup"><a href="<% out.print(rs7.getString("linkEnd_mercado")); %>"><img src="../img/Produtos/<% out.print(rs7.getInt("id_mercado")); %>_1.png" width="100%" /></a></span>
                                            <span class="buttonRemove"><a href="Lista.jsp?removeProdList=<% out.print(rs7.getInt("id_lista")); %>&removeProduto=<% out.print(rs7.getInt("id_produto")); %>&removeProdMercado=<% out.print(rs7.getInt("id_mercado")); %>"><i style="font-size: 25px; display: block; color: black;" class="material-icons">remove_shopping_cart</i></a></span>
                                        </div>
                                    <%
                                    i++;
                                }

                                ConnectionFactory.closeConnection(rs7, stm7);
                                
                                if(i != 0){
                                    %>
                                        </nav>
                                        </div>
                                        <div class="TotalPreco">
                                            <font style="font-style: italic; font-size: 21px; font-family: 'Comic Sans MS' , Comic San;">Total a pagar</font><br>
                                            <font style="font-size: 21px; font-family: 'Marker Felt', fantasy; font-style: italic;"> R$ <% out.print(new DecimalFormat("#,##0.00").format(valorTotal)); %></font>
                                        </div>
                                    <%
                                }

                                if(i == 0){
                                    Statement stm10 = ConnectionFactory.getConnection().createStatement();
                                    ResultSet rs10 = stm10.executeQuery("SELECT * FROM lista WHERE id_lista= " + Integer.parseInt(request.getParameter("removeProdList")) + ";");

                                    while(rs10.next()){
                                    %>
                                         <div style="display: flex; justify-content: space-between; padding: 5px; margin-top: 15px; font-family: 'Comic Sans MS' , Comic San; padding-right: 10px; margin-bottom: 15px;">
                                            <%
                                             if(rs10.getString("nome_lista").length() >= 20){
                                                 %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs10.getString("nome_lista").substring(0, 20) + "..."); %></div><%
                                            }
                                            else{
                                                 %><div style="font-size: 24px; font-weight: 700;"><% out.print(rs10.getString("nome_lista")); %></div><%
                                            }
                                            %>
                                            <div style="background-color: #00AA55; color: white; font-size: 16px;"><a href="Principal.jsp?acessoPermitido=true&addProdList=<% out.print(rs10.getString("id_lista")); %>" class="bottom" style="text-decoration: none; color: white; display: block; padding: 5px; border: 3px solid rgba(0, 0, 0, 0.12);"><i style="font-size: 18px;" class="material-icons">add_shopping_cart</i> Adicionar Produto <i style="font-size: 18px;" class="material-icons">add_shopping_cart</i></a></div>
                                        </div>
                                        <div>
                                            <br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">A lista está vazia! que tal adicionar alguns produtos?</p>     
                                        </div>

                                    <%
                                    }
                                    ConnectionFactory.closeConnection(rs10, stm10);
                                }
                }
            %>                           
        </section>
        
    </body>
</html>
