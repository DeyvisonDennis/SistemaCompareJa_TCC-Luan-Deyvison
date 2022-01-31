
<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cadastro</title>
        <link rel="stylesheet" href="../css/styleCadastroPage.css">
    </head>
    <body>

        <%request.setCharacterEncoding("utf-8");%>
        
        <main>
            <h1>Criando Sua Conta</h1>
            <div class="social-media">
                <a href="#">
                    <img src="../img/google.png" alt="Google">
                </a>
                <a href="#">
                    <img src="../img/facebook.png" alt="Facebook">
                </a>
            </div>

            <div class="alternative">
                <span>OU</span>
            </div>

            <form method="post" action="../CadastroUserController">
                <label for="name">
                    <span>Nome</span>
                    <input type="text" id="name" name="name" required>
                    <span>Endereço</span>
                </label>

                <label for="cep">
                    <input type="text" id="cep" name="cep" placeholder="CEP" onblur="pesquisacep(this.value);" required/>
                </label>      

                <label for="rua">
                    <input type="text" id="rua" name="rua" placeholder="Rua" required>
                </label>      

                <label for="numero">
                    <input type="text" id="numero" name="numero" placeholder="Número" required>
                </label>    

                <label for="bairro">
                    <input type="text" id="bairro" name="bairro" placeholder="Bairro" required>
                </label>

                <label for="cidade">
                    <input type="text" id="cidade" name="cidade" placeholder="Cidade" value="Divinópolis">
                </label> 

                <label for="uf">
                    <input type="text" id="uf" name="uf" placeholder="UF" value="MG">
                </label>            

                <label for="email">
                    <span>E-mail</span>
                    <input type="email" id="email" name="email" required>
                </label>

                <label for="password">
                    <span>Senha</span>
                    <input type="password" id="password" name="password" required>
                </label>

                <input type="submit" value="Cadastrar" id="button">
            </form>
        </main>
        <section class="images">
            <div class="circle"></div>
        </section>
    </body>
</html>