<%@page import="Model.Usuario"%>
<%@page import="DAO.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="br">
    <head>
        <meta charset="utf-8">
        <title>Compare Já</title>
        <link rel="stylesheet" href="css/styleLogin_Page.css">
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
            background: url(img/LogoTipo.png) no-repeat center;
            background-size: cover;
            margin: 10px 10px;
        }

        .fundo{
                position: absolute;
                right: 0%;
                top: 0%;
                background: url(img/fundoLogin.png); 
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
        
        <%
            request.setCharacterEncoding("utf-8");
            
            if(request.getParameter("Logout") != null){
                session.removeAttribute("usuarioLogado");
                session.invalidate();
            }
        %>

        <div class="welcome">
            <div class="logo"></div>
            <h2 class="bemvindo">Bem Vindo!</h2>
        </div>
        <div class="fundo">
            <form method="post" action="html/Principal.jsp?login=true" class="Login">
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

                <div class="botao">
                    <button class="btn fas fa-arrow-right"></button><!--Fazer login-->
                </div>
                <a href="html/Cadastro.jsp">Criar Conta</a> <!--Criar conta-->
            </form>
        </div>
        <script>
            var fields = document.querySelectorAll(".input input");
            var btn = document.querySelector(".btn");

            document.querySelector(".show-password").addEventListener("click", function () {
                if (this.classList[2] == "fa-eye-slash") {
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
    </body>
</html>
