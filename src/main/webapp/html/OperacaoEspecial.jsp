
<%@page import="java.text.DecimalFormat"%>
<%@page import="Model.AlocacaoProdutoLista"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DAO.ConnectionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compare já - Filtragem</title>
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
                top: -100%;
                left: -37.5%;
                width: 60px;
                height: 60px; 
            }
            .flex{
                display: flex;
                flex-wrap: wrap;
                max-width: 1100px;
                margin-top: 90px;
                margin-left: 40px;
            }
            
            .flex > div{
                flex: 1 1 250px;
                margin: 50px;
            }
            
             .InputCreateList{
                background: rgb(240,240,240);
                width: 270px;
                height: 35px;
                padding: 0 0.5rem;
                margin-top: 0.5rem;
                margin-bottom: 1rem;
                color: rgb(50,50,50);
                outline: none;
                font-size: 0.8rem;
                border: 1px solid #040B18;
                border-radius: 8px;
            }
            
            .button{
                color: white;
                text-align: center;
                font-weight: 600;
                display: block;
                padding: 2px;
                cursor: pointer;
                background-color: #00AA55;
                border: 3px solid rgba(0, 0, 0, 0.12);
                border-radius: 4px;                
            }
            
            .button:hover{
                background-color: rgb(0, 150, 65);
            }
            
            .containerOpcoes{
                height: 80px;
                width: 700px;
                position: absolute;
                top: 120px;
                right: 12%;
            }
            
            .buttonLimpar{
                position: absolute; top: 120px; right: 1%;
            }
            .TotalPreco{
                width: 180px;
                height: 60px;
                position: fixed;
                bottom: 2%;
                right: 2%;
                border-radius: 5px;
                background-color: rgb(0, 155, 60);
                color: white;
                padding: 5px;
                text-align: center;
                vertical-align: middle;
            }
            
            table, th, td{
                font-family: 'Comic Sans MS' , Comic San;
                font-size: 18px;
                border-collapse: collapse;
            }
            
            th, td{
               padding: 5px 10px; 
            }
            
            th{
                background-color: #00AA55;
                color: white;
            }
            
            table tr:nth-child(odd){
                background-color: rgba(0, 175, 80, 0.05);
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
            request.setCharacterEncoding("utf-8");
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
                    <a href="Principal.jsp?acessoPermitido=true">Pesquisar</a>
                    <a href="Lista.jsp">Listas</a>
                    <a href="../index.jsp?Logout=true">Sair</a>
                </div>
            </div>
        </nav>
        <br>
        <section class="containerOpcoes">
            <form name="OperacoesEspeciais" style="margin-left: 10px;" method="post" action="OperacaoEspecial.jsp?IdList=<% out.print(request.getParameter("IdList")); %>">
                <div style="display: flex; justify-content: space-between; width: 640px;">
                    <div>
                        <label style="font-size: 20px; font-weight: 700;">Produto :</label><br>
                        <input class="InputCreateList" type="search" name="produtoPesq" placeholder="Pesquise o produto... " list="ProdutosList"><br>
                        <datalist id="ProdutosList">
                            <%
                                Statement stm = ConnectionFactory.getConnection().createStatement();
                                ResultSet rs = stm.executeQuery("SELECT * FROM alocacaoprodutolista AS apl INNER JOIN produto AS p ON p.id_produto = apl.id_produto_alocacaoProdutoMercado WHERE apl.id_lista = " + request.getParameter("IdList") + ";");
                                
                                while(rs.next()){
                                    %><option value="<% out.print(rs.getString("nome_produto")); %>" /><%
                                }
                                ConnectionFactory.closeConnection(rs, stm);
                            %>                            
                        </datalist>
                    </div>
                    <div>
                        <label style="font-size: 20px; font-weight: 700;">Mercado :</label><br>
                        <input class="InputCreateList" type="text" name="mercadoPesq" placeholder="Pesquise em um mercado... "  list="Mercados"><br>
                        <datalist id="Mercados">
                            <%
                                Statement stm2 = ConnectionFactory.getConnection().createStatement();
                                ResultSet rs2 = stm2.executeQuery("SELECT *FROM mercado;");
                                
                                while(rs2.next()){
                                    %><option value="<% out.print(rs2.getString("nome_mercado")); %>" /><%
                                }
                                ConnectionFactory.closeConnection(rs2, stm2);
                            %>                            
                        </datalist>
                    </div>
                    <div style="margin: 0px -15px 23px 0px;">
                        <input class="button" style="width: 70px; font-size: 18px;" type="submit" name="submitPesquisa" value="Filtrar"><br>
                    </div>              
                </div>
            </form>
        </section>      
        <section class="buttonLimpar">
             <div>
                <form name="LimparOpeacoesEspeciais" method="post" action="OperacaoEspecial.jsp?IdList=<% out.print(request.getParameter("IdList")); %>">
                    <input class="button" type="submit" style="width: 170px; font-size: 18px;" name="SubmitLimpar" value="Limpar Filtros">
                </form>    
            </div>
        </section>
        <%  
            
            if((request.getParameter("produtoPesq") != null) && (request.getParameter("mercadoPesq") != null)){
            
                if((request.getParameter("produtoPesq").length() > 0) && (request.getParameter("mercadoPesq").length() == 0)){
                %>
                    <section>
                        <nav style="margin-left: 10px; margin-top: 120px;">
                        <%
                            Statement stm4 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs4 = stm4.executeQuery("SELECT * FROM lista AS l WHERE L.id_lista = " + request.getParameter("IdList") + ";");

                            while(rs4.next()){
                                if(rs4.getString("nome_lista").length() > 30){
                                    %><p style="font-size: 24px; font-weight: 700;">Lista: <% out.print(rs4.getString("nome_lista").substring(0, 30) + "..."); %></p><%
                                }
                                else{
                                    %><p style="font-size: 24px; font-weight: 700;">Lista: <% out.print(rs4.getString("nome_lista")); %></p><%
                                }
                            }
                            ConnectionFactory.closeConnection(rs4, stm4);
                        %>
                        </nav>
                        <%
                            Statement stm5 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs5 = stm5.executeQuery("SELECT * FROM alocacaoprodutomercado AS apm INNER JOIN produto AS p ON p.id_produto = apm.Produto INNER JOIN mercado AS m ON m.id_mercado = apm.Mercado WHERE p.nome_produto LIKE '%" + request.getParameter("produtoPesq") + "%' ORDER BY apm.preco;");

                            int i = 0;
                            while(rs5.next()){
                                if(i == 0){
                                    %>
                                        <p style="font-size: 24px; margin: 55px 0px 40px 10px; font-weight: 700;">Resultados para o Produto: </p>
                                        <nav style="display: flex;">
                                            <nav>
                                                <div style="display: flex; max-width: 400px;  margin-top: 10px; margin-left: 40px;">                                        
                                                    <div class="containerProduto">
                                                        <center><div style="width: 150px; height: 150px; padding: 10px; border: 3px solid #D6D7D9; border-radius: 10px"><img src="../img/Produtos/<% out.print(rs5.getInt("id_produto")); %>.png" width="100%" /></div><center>
                                                        <div style="font-size: 18px; font-style: italic; color: black;"><p><% out.print(rs5.getString("nome_produto")); %></p></div>
                                                    </div> 
                                                </div>
                                           </nav>
                                           <nav>         
                                            <table border="1" style="margin: 10px 0px 0px 150px;">
                                                <tr>
                                                    <th>Data</th>
                                                    <th>Mercado</th>
                                                    <th>Preço</th>
                                                </tr>
                                    <%
                                }
                                %>
                                    <tr>
                                        <td><% out.print(rs5.getDate("data_cadastro_produto")); %></td>
                                        <td><a style="text-decoration: none; color: black;" href="<% out.print(rs5.getString("linkEnd_mercado")); %>"><% out.print(rs5.getString("nome_mercado"));%></a></td>
                                        <td>R$ <% out.print(rs5.getFloat("preco")); %></td>
                                     </tr>
                                    <%
                                i++;
                            }
                            ConnectionFactory.closeConnection(rs5, stm5);
                        
                            if(i != 0){
                            %>
                                        </table>
                                    </nav>
                                </nav>
                            </section>
                            <% 
                            }

                            if(i == 0){
                                %>
                                    <div>
                                        <br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">Produto não encontrado na lista. Refaça a filtragem!</p>     
                                    </div>
                                <%
                            }
                } 
                else if((request.getParameter("mercadoPesq").length() > 0) && (request.getParameter("produtoPesq").length() == 0)){
                %>
                    <section style="margin: 110px 0px 0px 10px;">
                        <%
                            Statement stm6 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs6 = stm6.executeQuery("SELECT * FROM lista AS l WHERE L.id_lista = " + request.getParameter("IdList") + ";");

                            while(rs6.next()){
                                if(rs6.getString("nome_lista").length() > 30){
                                    %><p style="font-size: 24px; font-weight: 700;">Lista: <% out.print(rs6.getString("nome_lista").substring(0, 30) + "..."); %></p><%
                                }
                                else{
                                    %><p style="font-size: 24px; font-weight: 700;">Lista: <% out.print(rs6.getString("nome_lista")); %><%
                                }
                            }

                            ConnectionFactory.closeConnection(rs6, stm6);
                      
                            Statement stm7 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs7 = stm7.executeQuery("SELECT * FROM alocacaoprodutolista AS apl INNER JOIN produto AS p ON p.id_produto = apl.id_produto_alocacaoProdutoMercado INNER JOIN alocacaoprodutomercado AS apm ON apm.Produto = p.id_produto INNER JOIN mercado AS m ON m.id_mercado = apm.Mercado WHERE apl.id_lista = " + request.getParameter("IdList") + " AND m.nome_mercado LIKE '%" + request.getParameter("mercadoPesq") + "%';");
                                                          
                            int i = 0;
                            float valorTotal = 0;
                            while(rs7.next()){
                                if(i == 0){
                                    %>
                                    <p style="font-size: 24px; margin: 55px 0px 40px 0px; font-weight: 700;">Resultados para o Mercado: </p>
                                    <nav style="display: flex;">
                                        <div class="containerProduto" style="margin-left: 25px;">
                                            <center><div style=" padding: 10px;"><a href="<% out.print(rs7.getString("linkEnd_mercado")); %>"><img src="../img/Produtos/<% out.print(rs7.getInt("id_mercado")); %>_1.png" width="60%" /></a></div><center>
                                            <div style="font-size: 18px; font-style: italic; color: black; padding: 10px;"><% out.print(rs7.getString("nome_mercado")); %></div>
                                        </div>
                                        
                                        <nav class="flex" style=" border-left: 5px solid #D6D7D9; border-radius: 2px; margin-top: 0px;">
                                    <%
                                }
                                valorTotal = valorTotal + rs7.getFloat("preco");
                                %>
                                    <div class="containerProduto" style="margin: 30px;">
                                        <center><span class="imgProd"><img src="../img/Produtos/<% out.print(rs7.getInt("id_produto")); %>.png" width="60%"></span></center>
                                        <span style="font-size: 18px; font-style: italic; color: black; padding: 10px;"><p><% out.print(rs7.getString("nome_produto")); %></p><p><font style=" font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;">R$ <% out.print(rs7.getString("preco")); %></font></p></span>
                                    </div>
                                <%
                                i++;
                            }
                            ConnectionFactory.closeConnection(rs7, stm7);
                        
                            if(i != 0){
                            %>
                                        </nav>
                                    </nav>
                                <div class="TotalPreco">
                                    <font style="font-style: italic; font-size: 21px; font-family: 'Comic Sans MS' , Comic San;"><b>Total a pagar</b></font><br>
                                    <font style="font-size: 21px; font-family: 'Marker Felt', fantasy; font-style: italic;"> R$ <% out.print(valorTotal); %></font>
                                </div>
                            <% 
                            }

                            if(i == 0){
                                %>
                                    <div>
                                        <br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">Mercado não encontrado na lista. Refaça a filtragem!</p>     
                                    </div>
                                <%
                            }    
                                %>
                    </section>
                <%
                }
                else if((request.getParameter("produtoPesq").length() > 0) && (request.getParameter("mercadoPesq").length() > 0)){
                %>
                    <section style="margin: 110px 0px 0px 10px;">
                        <%
                            Statement stm4 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs4 = stm4.executeQuery("SELECT * FROM lista AS l WHERE L.id_lista = " + request.getParameter("IdList") + ";");

                            while(rs4.next()){
                                if(rs4.getString("nome_lista").length() > 30){
                                    %><p style="font-size: 24px; font-weight: 700;">Lista: <% out.print(rs4.getString("nome_lista").substring(0, 30) + "..."); %></p><%
                                }
                                else{
                                    %><p style="font-size: 24px; font-weight: 700;">Lista: <% out.print(rs4.getString("nome_lista")); %><%
                                }
                            }

                            ConnectionFactory.closeConnection(rs4, stm4);
                      
                            Statement stm32 = ConnectionFactory.getConnection().createStatement();
                            ResultSet rs32 = stm32.executeQuery("SELECT * FROM alocacaoprodutomercado as apm INNER JOIN mercado AS m ON m.id_mercado = apm.Mercado INNER JOIN produto AS p ON p.id_produto = apm.Produto WHERE m.nome_mercado LIKE '%" + request.getParameter("mercadoPesq") + "%' AND p.nome_produto LIKE '%" + request.getParameter("produtoPesq") + "%';");
                                                          
                            int i = 0;
                            while(rs32.next()){
                                if(i == 0){
                                    %>
                                    <nav class="flex">
                                        <div class="containerProduto">
                                            <center><span class="imgProd"><img src="../img/Produtos/<% out.print(rs32.getInt("id_produto")); %>.png" width="60%"></span></center>
                                            <span style="font-size: 18px; font-style: italic; color: black; padding: 10px;"><p><% out.print(rs32.getString("nome_produto")); %></p><p><font style=" font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;">R$ <% out.print(rs32.getString("preco")); %></font></p></span>
                                            <span class="imgSup"><a href="<% out.print(rs32.getString("linkEnd_mercado")); %>"><img src="../img/Produtos/<% out.print(rs32.getInt("id_mercado")); %>_1.png" width="100%"></a></span>
                                        </div>
                                <%
                                }
                                i++;
                            }
                            ConnectionFactory.closeConnection(rs32, stm32);
                        
                            if(i != 0){
                            %>
                                </nav>
                            <% 
                            }

                            if(i == 0){
                                %>
                                    <div>
                                        <br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">Este produto não foi encontrado neste mercado!</p>     
                                    </div>
                                <%
                            }    
                                %>
                    </section>
                <%
                }
                else if((request.getParameter("produtoPesq").length() == 0) && (request.getParameter("mercadoPesq").length() == 0)){
                    %>
                        <section>
                            <%
                                Statement stm11 = ConnectionFactory.getConnection().createStatement();
                                ResultSet rs11 = stm11.executeQuery("SELECT * FROM alocacaoprodutolista AS apl INNER JOIN alocacaoprodutomercado AS apm ON apm.Produto = apl.id_produto_alocacaoProdutoMercado AND apm.Mercado = apl.id_mercado_alocacaoProdutoMercado INNER JOIN produto AS p ON p.id_produto = apl.id_produto_alocacaoProdutoMercado INNER JOIN mercado AS m ON m.id_mercado = apl.id_mercado_alocacaoProdutoMercado INNER JOIN lista AS l ON l.id_lista = apl.id_lista WHERE apl.id_lista = " + request.getParameter("IdList") + ";");

                                AlocacaoProdutoLista buscaValorTotal = new AlocacaoProdutoLista();
                                float valorTotal = buscaValorTotal.ReturnTotalList(Integer.parseInt(request.getParameter("IdList")));

                                int i=0;
                                while(rs11.next()){
                                    if(i == 0){
                                        %>
                                            <nav style="margin-left: 10px; margin-top: 110px;">
                                                <%
                                                    if(rs11.getString("nome_lista").length() > 30){
                                                        %><p style="font-size: 24px; font-weight: 700;">Lista:<% out.print(rs11.getString("nome_lista").substring(0, 30) + "..."); %></p><%
                                                    }
                                                    else{
                                                        %><p style="font-size: 24px; font-weight: 700;">Lista: <% out.print(rs11.getString("nome_lista")); %></p><%
                                                    }
                                                %>
                                            </nav>
                                            <br><br><br><br><p style="font-family: 'Comic Sans MS' , Comic San; font-size: 30px; color: red; text-align: center;">Por Favor, preencha ao menos um campo do formulário antes de filtrar!</p>  
                                            
                                        <%
                                        break;
                                    }
                                    i++;
                                }

                                ConnectionFactory.closeConnection(rs11, stm11);
                            %>
                        </section>
                    <%
                }
            }
            else{
                %>
                <section>
                    <%
                        Statement stm11 = ConnectionFactory.getConnection().createStatement();
                        ResultSet rs11 = stm11.executeQuery("SELECT * FROM alocacaoprodutolista AS apl INNER JOIN alocacaoprodutomercado AS apm ON apm.Produto = apl.id_produto_alocacaoProdutoMercado AND apm.Mercado = apl.id_mercado_alocacaoProdutoMercado INNER JOIN produto AS p ON p.id_produto = apl.id_produto_alocacaoProdutoMercado INNER JOIN mercado AS m ON m.id_mercado = apl.id_mercado_alocacaoProdutoMercado INNER JOIN lista AS l ON l.id_lista = apl.id_lista WHERE apl.id_lista = " + request.getParameter("IdList") + ";");

                        AlocacaoProdutoLista buscaValorTotal = new AlocacaoProdutoLista();
                        float valorTotal = buscaValorTotal.ReturnTotalList(Integer.parseInt(request.getParameter("IdList")));

                        int i=0;
                        while(rs11.next()){
                            if(i == 0){
                                %>
                                    <nav style="margin-left: 10px; margin-top: 110px;">
                                        <%
                                            if(rs11.getString("nome_lista").length() > 30){
                                                %><p style="font-size: 24px; font-weight: 700;">Lista:<% out.print(rs11.getString("nome_lista").substring(0, 30) + "..."); %></p><%
                                            }
                                            else{
                                                %><p style="font-size: 24px; font-weight: 700;">Lista: <% out.print(rs11.getString("nome_lista")); %></p><%
                                            }
                                        %>
                                    </nav>
                                    <nav class="flex">
                                <%
                            }
                            %>
                                <div class="containerProduto">
                                    <center><span class="imgProd"><img src="../img/Produtos/<% out.print(rs11.getInt("id_produto")); %>.png" width="60%"></span></center>
                                    <span style="font-size: 18px; font-style: italic; color: black; padding: 10px;"><p><% out.print(rs11.getString("nome_produto")); %></p><p><font style=" font-family: 'Marker Felt', fantasy; font-size: 25px; color: red;">R$ <% out.print(rs11.getString("preco")); %></font></p></span>
                                    <span class="imgSup"><a href="<% out.print(rs11.getString("linkEnd_mercado")); %>"><img src="../img/Produtos/<% out.print(rs11.getInt("id_mercado")); %>_1.png" width="100%"></a></span>
                                </div>
                            <%

                            i++;
                        }

                        ConnectionFactory.closeConnection(rs11, stm11);
                    %>
                    </nav>
                    <div class="TotalPreco">
                        <font style="font-style: italic; font-size: 21px; font-family: 'Comic Sans MS' , Comic San;"><b>Total a pagar</b></font><br>
                        <font style="font-size: 21px; font-family: 'Marker Felt', fantasy; font-style: italic;"> R$ <% out.print(new DecimalFormat("#,##0.00").format(valorTotal)); %></font>
                    </div>
                </section>
            <%
             }
        %>
    </body>
</html>
