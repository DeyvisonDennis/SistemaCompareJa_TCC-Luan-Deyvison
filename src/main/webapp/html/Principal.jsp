
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="Model.*"%>
<%@page import="Model.AlocacaoProdutoMercado"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DAO.ConnectionFactory"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<html>
        
        <%
            request.setCharacterEncoding("utf-8");
            
            Usuario UserLogado = new Usuario();
            boolean VerificaLogin = UserLogado.BuscaUser(request.getParameter("email"), request.getParameter("senha"));  
            
            if(request.getParameter("login") != null){
                session.setAttribute("usuarioLogado", UserLogado);
            }
            
            if(VerificaLogin == true || request.getParameter("acessoPermitido") != null){
                %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compare já - Pesquisar Produto</title>
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
            
            .pesquisar{
                height: 100vh;
                min-height: 500px;
                background: url(../img/principalFundo.png) no-repeat center;
                background-size: cover;
                background-attachment: fixed;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .pesquisar div{
                width: 400px;
                height: 40px;
                background-color: white;
                border-radius: 10px;
                border: 2px solid darkgrey; 
            }

            .pesquisar input[type="search"]{
                width: 350px;
                height: 40px;    
                -webkit-appearance: none;
                -moz-appearance: none;
                -o-appearance: nonne;
                border-radius: 4px;
                margin-right: 5px;
                cursor: pointer;
            }

            #txtPesquisa{
                outline: 0;
                padding: 20px 10px;
                padding-left: 15px;
                float:left;
                box-shadow: 0 0 0 0;
                background-color:transparent;
                font-size:18px;
                border: 0 none;
                height: 25px;
                width: 350px;
            }

            .pesquisar button{
                background-color:transparent;
                border:none;
                height:40px;
                width:40px;
                cursor: pointer;
            }

            i{
                color: rgb(160, 160, 160);
                font-size: 20px;
                font-weight: 700;
            }

            .TitleAndPesquisa{
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 100%;
                height: 60px;
                margin-top: 110px;
            }

            .TitleAndPesquisa div{
                width: 400px;
                height: 40px;
                background-color: white;
                border-radius: 10px;
                border: 2px solid darkgrey;
                margin-right: 24px;
                margin-top: 10px;
            }

            .TitleAndPesquisa button{
                background-color:transparent;
                border:none;
                height:40px;
                width:40px;
                cursor: pointer;
            }

            .Title{
                font-size: 20px;
                font-weight: 600;
                margin-left: 24px; 

            }

            .NameMercado{
                font-size: 20px;
                text-transform: uppercase ;
                font-style: italic;
                font-family: "Times New Roman", sans;
                color: #00AA55;
                padding: 20px;
            }

            .flex{
                display: flex;
                flex-wrap: wrap;
                max-width: 60%;
                margin: 0 auto; 
            }

            .flex > div{
                flex: 1 1 200px;
                margin-left: 10px;
            }

            .locale{
                position: absolute;
                top: 10px;
                left: 10px;
            }

            .locale i{
                font-size: 25px;
                color: #D6D7D9;
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
                <%
                    if(request.getParameter("SubmitProd") == null){
                %>
                        <section class="pesquisar">
                            <%
                                if(request.getParameter("addProdList") == null){
                                    %>
                                        <form name="Pesquisa" action="Principal.jsp?acessoPermitido=true" method="post">
                                    <%
                                }
                                else if(request.getParameter("addProdList") != null){
                                    %>
                                        <form name="Pesquisa" action="Principal.jsp?acessoPermitido=true&addProdList=<% out.print(request.getParameter("addProdList")); %>" method="post">
                                    <%
                                }
                            %>
                            
                                <div>
                                    <input type="search" id="txtPesquisa" name="nameProd" placeholder="Pesquisar..." list="PesquisaProduto">
                                    <datalist id="PesquisaProduto">

                                    <%
                                        Statement stm = ConnectionFactory.getConnection().createStatement();
                                        ResultSet rs = stm.executeQuery("SELECT p.id_produto, p.nome_produto FROM produto AS p;");

                                        while(rs.next()){

                                           %>

                                           <option value="<% out.print(rs.getString("nome_produto")); %>" />

                                           <%

                                        }
                                        ConnectionFactory.closeConnection(rs, stm);
                                    %>

                                    </datalist>
                                    <button type="submit" name="SubmitProd" value="SubmitProd"><center><i class='fas fa-search'></i></center></button>
                                </div>
                            </form>
                        </section> 

                <%
                    }
                    else if(request.getParameter("SubmitProd") != null){
                %>
                        <section class="TitleAndPesquisa">
                            <%
                            if(request.getParameter("nameProd").length() > 50){
                                %><nav class="Title">Resultados para <% out.print(request.getParameter("nameProd").substring(0,50) + "..."); %></nav><%
                            }
                            else{
                                %><nav class="Title">Resultados para <% out.print(request.getParameter("nameProd")); %></nav><%
                            }
                            %>
                            
                            <nav>
                                
                                <%
                                    if(request.getParameter("addProdList") == null){
                                        %>
                                            <form name="Pesquisa" action="Principal.jsp?acessoPermitido=true" method="post">
                                        <%
                                    }
                                    else if(request.getParameter("addProdList") != null){
                                        %>
                                            <form name="Pesquisa" action="Principal.jsp?acessoPermitido=true&addProdList=<% out.print(request.getParameter("addProdList")); %>" method="post">
                                        <%
                                    }
                                %>
                                
                                    <div>
                                        <input type="search" id="txtPesquisa" name="nameProd" placeholder="Pesquisar..." list="PesquisaProduto">
                                        <datalist id="PesquisaProduto">

                                        <%
                                            Statement stm = ConnectionFactory.getConnection().createStatement();
                                            ResultSet rs = stm.executeQuery("SELECT p.id_produto, p.nome_produto FROM produto AS p;");

                                            while(rs.next()){

                                               %>

                                               <option value="<% out.print(rs.getString("nome_produto")); %>" />

                                               <%

                                            }
                                            ConnectionFactory.closeConnection(rs, stm);
                                        %>

                                        </datalist>
                                        <button type="submit" name="SubmitProd" value="SubmitProd"><center><i class='fas fa-search'></i></center></button>
                                    </div>
                                </form>
                            </nav>                
                        </section>        

                        <%
                            Statement stm2 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs2 = stm2.executeQuery("SELECT * FROM alocacaoprodutomercado AS a INNER JOIN mercado AS m ON a.Mercado = m.id_mercado INNER JOIN produto AS p ON a.Produto = p.id_produto WHERE p.nome_produto LIKE '%" + request.getParameter("nameProd") + "%' ORDER BY a.preco ASC;");

                            ArrayList<AlocacaoProdutoMercado> ListAlocacao = new ArrayList();
                            ArrayList<Mercado> ListMercado = new ArrayList();
                            ArrayList<Produto> ListProduto = new ArrayList();

                            ArrayList<Integer> ListVerificaMercado = new ArrayList();
                            ArrayList<Integer> ListVerificaProduto = new ArrayList();
                            ListVerificaMercado.add(0);
                            ListVerificaProduto.add(0);

                            boolean selectReturn = false;
                            
                            while(rs2.next()){
                                selectReturn = true;
                                
                                AlocacaoProdutoMercado alocacao = new AlocacaoProdutoMercado(rs2.getInt("Produto"), rs2.getInt("Mercado"), rs2.getFloat("preco"));
                                ListAlocacao.add(alocacao);

                                Mercado mercado = new Mercado(rs2.getInt("id_mercado"), rs2.getInt("numero_mercado"), rs2.getString("nome_mercado"), rs2.getString("rua_avenida_mercado"), rs2.getString("bairro_mercado"), rs2.getString("CEP_mercado"), rs2.getString("linkEnd_mercado"));
                                boolean verificaMercado = false;
                                for(int i=0;i<ListVerificaMercado.size();i++){
                                    if(mercado.getId() == ListVerificaMercado.get(i)){
                                        verificaMercado = true;
                                    }
                                }
                                if(!verificaMercado){
                                    ListMercado.add(mercado);
                                    ListVerificaMercado.add(mercado.getId());
                                }

                                Date data = rs2.getDate("data_cadastro_produto");
                                Produto produto = new Produto(rs2.getInt("id_produto"), rs2.getString("nome_produto"), data);

                                boolean verificaProduto = false;
                                for(int i=0;i<ListVerificaProduto.size();i++){
                                    if(produto.getId() == ListVerificaProduto.get(i)){
                                        verificaProduto = true;
                                    }
                                }
                                if(!verificaProduto){
                                    ListProduto.add(produto);
                                    ListVerificaProduto.add(produto.getId());
                                }
                            }

                            ConnectionFactory.closeConnection(rs2, stm2);

                            Statement stm3 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs3 = stm3.executeQuery("SELECT * FROM alocacaoprodutomercado AS a INNER JOIN mercado AS m ON a.Mercado = m.id_mercado INNER JOIN produto AS p ON a.Produto = p.id_produto WHERE p.nome_produto LIKE '%" + request.getParameter("nameProd") + "%' ORDER BY a.Mercado ASC, a.preco ASC;");

                            ArrayList<Integer> ListProdBarato = new ArrayList();
                            int numMercado = 1;
                            
                            while(rs3.next()){
                                if(rs3.getInt("Mercado") == numMercado){
                                    ListProdBarato.add(rs3.getInt("Produto"));
                                    numMercado++;
                                }
                            }

                            ConnectionFactory.closeConnection(rs3, stm3);

                            if(!selectReturn){  
                                %>
                                    <br><br><br><p style="font-size: 30px; color: red; text-align: center;">Produto não encontrado! Por Favor, digite novamente.</p>
                                <%
                            }
                            else{
                                for(int j=0;j<ListMercado.size();j++){
                                    boolean JaFoi = false;
                                    ArrayList<Integer> VerificaProduto = new ArrayList();
                                    VerificaProduto.add(-1);
                                    Mercado mercadoPesq = ListMercado.get(j);
                                    %>
                                        <div class="NameMercado">
                                            <a href="<% out.print(mercadoPesq.getLinkEndereco()); %>" style=" text-decoration: none; color: #00AA55;"><i class='fas fa-cart-arrow-down' style=" font-size: 25px; color: #00AA55;"></i> <b><% out.print(mercadoPesq.getNome()); %></b></a>
                                        </div>
                                        <section class="flex">
                                    <%
                                    for(int i=0;i<ListAlocacao.size();i++){

                                        AlocacaoProdutoMercado alocacaoPesq = ListAlocacao.get(i);
                                        if(alocacaoPesq.getMercadoId() == mercadoPesq.getId()){
                                            for(int k=0;k<ListProduto.size();k++){
                                                Produto produtoPesq = ListProduto.get(k);
                                                boolean verificaProd = false;
                                                for(int f=0;f<VerificaProduto.size();f++){
                                                    int x = VerificaProduto.get(f);
                                                    if(produtoPesq.getId() == x){
                                                        verificaProd = true;
                                                        break;
                                                    }
                                                }
                                                VerificaProduto.add(produtoPesq.getId());
                                                if((!verificaProd) && (alocacaoPesq.getProdutoId() == produtoPesq.getId())){
                                                    boolean ProdutoBarato = false;  

                                                    for(int c=0;c<ListProdBarato.size();c++){
                                                        int Produto = ListProdBarato.get(c);

                                                        if(Produto == produtoPesq.getId()){
                                                            ProdutoBarato = true;
                                                            break;
                                                        }
                                                    }

                                                    if(!ProdutoBarato){

                                                        %>

                                                            <div style="max-width: 200px; margin: 20px; position: relative;">
                                                                <div style=" border: solid 3px #D6D7D9; border-radius: 10px; padding: 20px; max-width: 190px;  height: 210px; background-size: cover;">
                                                                    <img src="../img/Produtos/<% out.print(produtoPesq.getId()); %>.png" width="100%" height="100%" />
                                                                </div>

                                                                <%
                                                                    if(request.getParameter("addProdList") == null){
                                                                        %>
                                                                            <div class="locale"> 
                                                                                <a href="Lista.jsp?addProdutoNO=<% out.print(produtoPesq.getId()); %>&addProdMercadoNO=<% out.print(mercadoPesq.getId()); %>"><i class="material-icons">add_box</i></a>
                                                                            </div>
                                                                        <%
                                                                    }
                                                                    else if(request.getParameter("addProdList") != null){
                                                                        %>
                                                                            <div class="locale"> 
                                                                                <a href="Lista.jsp?addProduto=<% out.print(produtoPesq.getId()); %>&addProdList=<% out.print(request.getParameter("addProdList")); %>&addProdMercado=<% out.print(mercadoPesq.getId()); %>"><i class="material-icons">add_box</i></a>
                                                                            </div>
                                                                        <%
                                                                    }
                                                                %>

                                                                <div style=" padding: 5px;">
                                                                    <br><p style="font-size: 15px; font-style: italic; color: black; width: 180px;"><% out.print(produtoPesq.getDataCadastro()); %></p>
                                                                    <p style="font-size: 15px; font-style: italic; color: black; width: 180px;"> <b><% out.print(produtoPesq.getNome()); %></b></p>
                                                                    <p style="font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;"> <b>R$ <% out.print(alocacaoPesq.getPreco()); %></b></p>
                                                                </div>
                                                            </div>

                                                        <%
                                                    }
                                                    else if(JaFoi != true){
                                                        JaFoi=true;
                                                            %>

                                                            <div style="max-width: 200px; margin: 20px; position: relative;">
                                                                <div style=" border: solid 3px #D6D7D9; border-radius: 10px; padding: 20px; max-width: 190px;  height: 210px; background-size: cover;">
                                                                    <img src="../img/Produtos/<% out.print(produtoPesq.getId()); %>.png" width="100%" height="100%" />
                                                                </div>

                                                                <%
                                                                    if(request.getParameter("addProdList") == null){
                                                                        %>
                                                                            <div class="locale"> 
                                                                                <a href="Lista.jsp?addProdutoNO=<% out.print(produtoPesq.getId()); %>&addProdMercadoNO=<% out.print(mercadoPesq.getId()); %>"><i class="material-icons">add_box</i></a>
                                                                            </div>
                                                                        <%
                                                                    }
                                                                    else if(request.getParameter("addProdList") != null){
                                                                        %>
                                                                            <div class="locale"> 
                                                                                <a href="Lista.jsp?addProduto=<% out.print(produtoPesq.getId()); %>&addProdList=<% out.print(request.getParameter("addProdList")); %>&addProdMercado=<% out.print(mercadoPesq.getId()); %>"><i class="material-icons">add_box</i></a>
                                                                            </div>
                                                                        <%
                                                                    }
                                                                %>

                                                                <div style=" padding: 5px;">
                                                                    <br><p style="font-size: 15px; font-style: italic; color: black; width: 180px;"><% out.print(produtoPesq.getDataCadastro()); %></p>
                                                                    <p style="font-size: 15px; font-style: italic; color: black; width: 180px;"> <b><% out.print(produtoPesq.getNome()); %></b></p>
                                                                    <p style="font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;"> <b>R$ <% out.print(alocacaoPesq.getPreco()); %></b></p>
                                                                </div>
                                                            </div>

                                                        <%
                                                    }else{
                                                        %>

                                                            <div style="max-width: 200px; margin: 20px; position: relative;">
                                                                <div style=" border: solid 3px #D6D7D9; border-radius: 10px; padding: 20px; max-width: 190px;  height: 210px; background-size: cover;">
                                                                    <img src="../img/Produtos/<% out.print(produtoPesq.getId()); %>.png" width="100%" height="100%" />
                                                                </div>

                                                                <%
                                                                    if(request.getParameter("addProdList") == null){
                                                                        %>
                                                                            <div class="locale"> 
                                                                                <a href="Lista.jsp?addProdutoNO=<% out.print(produtoPesq.getId()); %>&addProdMercadoNO=<% out.print(mercadoPesq.getId()); %>"><i class="material-icons">add_box</i></a>
                                                                            </div>
                                                                        <%
                                                                    }
                                                                    else if(request.getParameter("addProdList") != null){
                                                                        %>
                                                                            <div class="locale"> 
                                                                                <a href="Lista.jsp?addProduto=<% out.print(produtoPesq.getId()); %>&addProdList=<% out.print(request.getParameter("addProdList")); %>&addProdMercado=<% out.print(mercadoPesq.getId()); %>"><i class="material-icons">add_box</i></a>
                                                                            </div>
                                                                        <%
                                                                    }
                                                                %>

                                                                <div style=" padding: 5px;">
                                                                    <br><p style="font-size: 15px; font-style: italic; color: black; width: 180px;"><% out.print(produtoPesq.getDataCadastro()); %></p>
                                                                    <p style="font-size: 15px; font-style: italic; color: black; width: 180px;"> <b><% out.print(produtoPesq.getNome()); %></b></p>
                                                                    <p style="font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;"> <b>R$ <% out.print(alocacaoPesq.getPreco()); %></b></p>
                                                                </div>
                                                            </div>

                                                        <%

                                                    }

                                                    break;
                                                }
                                            }
                                        }
                                    }

                                    %>  
                                                </section>
                                    <%

                            }
                        } 
                    }
                }
                else if(VerificaLogin == false){
                    %>
    <head>
        <meta charset="utf-8">
        <title>Compare Já</title>
        <link href="../css/styleLogin_Page.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <style>
         *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Ubuntu", sans-serif;
        }

        body{
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        .welcome{
            width: 35%;
            height: 100vh;
            background-color: #00AA55;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border-right: 4px solid rgba(0, 0, 0, 0.12);
        }

        .bemvindo{
            margin-top: 20px;
            font-size: 40px;
        }

        .logo{
            width: 373px;
            height: 372px;
            background: url(../img/LogoTipo.png) no-repeat center;
            background-size: cover;
            margin: 10px 10px;
        }

        .fundo{
                position: absolute;
                right: 0%;
                top: 0%;
                background: url(../img/fundoLogin.png); 
                background-size: cover;
                display: flex;
                min-height: 100vh;
                align-items: center;
                justify-content: center;
                width: 65%;
        }	

        .Login{
                width: calc(100% - 20px);
                max-width: 500px;
                background-color: white;
                padding: 20px 40px;
                border-radius: 4px;
        }

        .Login h1{
                text-align: center;
                margin: 35px 0;
                font-size: 36px;
                color: rgb(50, 50, 50);
        }

        .input{
                margin-bottom: 12px;
                position: relative;
        }

        .input input{
                width: 100%;
                height: 70px;
                border:  none;
                border-radius: 4px;
                background-color: rgb(240, 240, 240);
                color: rgb(30, 30, 30);
                font-size: 20px;

                padding: 14px 60px 0 10px;
        }

        .tituloInput{
                text-transform: uppercase;
                font-size: 14px;
                font-weight: 700;
                position: absolute;
                line-height: 70px;
                top: 0;
                left: 20px;
                color: rgb(190, 190, 190);
                user-select: none;
                pointer-events: none;
        }

        .show-password{
                position: absolute;
                top: 38%;
                right:22px;
                color: rgb(190, 190, 190);
                font-size: 22px;
                cursor: pointer;
        }

        .input input:focus ~ .tituloInput,
        .input input:valid ~ .tituloInput{
                left: 10px;
                top: -16px;
        }

        .checkbox{
                display: flex;
                align-items: center;
                position: relative;
                font-size: 18px;
                font-weight: 500;
                color: rgb(30, 30, 30);
                margin: 20px 0;
        }

        .checkbox input{
                width: 24px;
                height: 24px;
                -webkit-appearance: none;
                background-color: rgb(240, 240, 240);
                border-radius: 4px;
                margin-right: 10px;
                cursor: pointer;
        }

        .checkbox .fa-check{
                position: absolute;
                color: white;
                font-size: 14px;
                white: 24px;
                text-align: center;
                user-select: none;
                pointer-events: none;
                margin-left: 5px;
                opacity: 0.9;
        }


        .checkbox input:checked{
                background-color: #00AA55;
        }

        .checkbox input:checked + .fa-check{
                opacity: 1;
        }

        .botao{
                display: block;
                width: 100px;
                height: 100px;
                background-color: #00AA55;
                color: white;
                margin: 40px auto;
                border: none;
                border-radius: 30px;
                font-size: 40px;
                cursor: pointer;
                transition: .3s linear;
                }

        .botao:hover{
                opacity: .85;
        }

        .btn{
                display: block;
                width: 100px;
                height: 100px;
                background-color: #00AA55;
                color: white;
                border: none;
                border-radius: 30px;
                font-size: 40px;
                cursor: pointer;
                transition: .3s linear;
        }

        .btn:hover{
                opacity: .85;
        }

        .Login a{
                display: block;
                text-align: center;
                font-weight: 600;
                text-decoration: none;
                color: rgb(50, 50, 50);
                text-transform: uppercase;
                transition: 1.2s linear;
        }

        .Login a:hover{
                color: rgb(10, 10, 10);
        }

        @media screen and (max-width: 760px){
            .welcome{
                flex-direction: row;
                width: 100%;
                height: 100px;
                border-right: none;
                border-bottom: 3px solid rgba(0, 0, 0, 0.12);
            }

            .fundo{
                width: 100%;
                min-height: calc(100vh - 100px);
                position: static;
            }

            .logo{
                background: url(img/LogoPrincipal.png);
                width: 315px;
                height: 80px;
                overflow: hidden;
            }

            .bemvindo{
                display: none;
            }

            .Login{
                max-width: 400px;
                margin: 20px 0;

            }

            .Login h1{
                margin: 15px 0;
                font-size: 30px;
            }

            .input input{
                height: 60px;
                font-size: 16px;
            }
            .tituloInput{
                font-size: 13px;
                line-height: 60px;
            }

            .show-password{
                top: 36%;
                right:22px;
                font-size: 18px;
            }

            .input input:focus ~ .tituloInput,
            .input input:valid ~ .tituloInput{
                left: 10px;
                top: -12px;
            }

            .checkbox{
                font-size: 16px;
                margin: 16px 0;
            }

            .checkbox input{
                width: 18px;
                height: 18px;
            }

            .checkbox .fa-check{
                font-size: 10px;
                margin-left: 4px;
                opacity: 0.9;
            }

            .botao{
                width: 75px;
                height: 75px;	
                margin: 20px auto;
                border-radius: 20px;
                font-size: 30px;
            }

            .btn{
                width: 75px;
                height: 75px;
                border-radius: 20px;
                font-size: 30px;
            }

            .Login a{
                font-size: 14px;
            }
        }
 
        </style>
    </head>
    <body>
        
        <%request.setCharacterEncoding("utf-8");%>

        <div class="welcome">
            <div class="logo"></div>
            <h2 class="bemvindo">Bem Vindo!</h2>
        </div>
        <div class="fundo">
            <form method="post" action="Principal.jsp?login=true" class="Login">
                <h1>Entrar</h1>

                <div class="input">
                    <input type="text" name="email" required>
                    <div class="tituloInput">E-mail</div>
                </div>

                <div class="input">
                    <input type="password" name="senha" required>
                    <div class="tituloInput">Senha</div>
                    <div class="show-password fas fa-eye-slash"></div>
                </div>

                <div class="checkbox">
                    <input type="checkbox" name="lembraLogin">
                    <div class="fas fa-check"></div>
                    Salvar usuário
                </div>
                
                <div style="font-size: 15px; color: red; padding: 5px;">
                    <span>Usuário e/ou senha inválido!</span>
                </div>

                <div class="botao">
                    <button class="btn fas fa-arrow-right"></button><!--Fazer login-->
                </div>
                <a href="Cadastro.jsp">Criar Conta</a> <!--Criar conta-->
            </form>
        </div>
        <script>
            var fields = document.querySelectorAll(".input input");
            var btn = document.querySelector(".btn");

            document.querySelector(".show-password").addEventListener("click", function () {
                if (this.classList[2] === "fa-eye-slash") {
                    this.classList.remove("fa-eye-slash");
                    this.classList.add("fa-eye");
                    fields[1].type = "text";
                } else {
                    this.classList.remove("fa-eye");
                    this.classList.add("fa-eye-slash");
                    fields[1].type = "password";
                }
            });
        </script>                                
                                        
                    <%
                }
                %>
    </body>
</html>
