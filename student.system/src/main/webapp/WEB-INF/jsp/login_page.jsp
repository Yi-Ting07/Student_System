<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>學生管理系統</title>
		
		<style>
						
			html {
            font-size: 10px;
        	}
        	
        	body{
  				background-color: #FFF8DC;
			}
        	
			.stuSystemBlock{
				background-color:#528B8B;
				height: 10rem;
				position:relative;   
  				margin: auto;
  				text-align:center;
  				color:white;
			}
			
			.title{
				line-height:10rem;
				font-size:6rem;
			}
			
			.loginBlock{
				padding: 2rem;
				border-top: 20px solid #528B8B;
				border-bottom:20px solid #528B8B;
				background-color: #F0F8FF;
				border-radius: 5px;
				width:20%;
				margin:0 auto;
				text-align:center;
  				
			}
			
			.loginText{
				font-size:4rem;
				color: #528B8B;
			}
			
			.loginTable{
				 border-collapse: collapse;
			}
			
			tr,td,th{
				border:1px solid;
			}
			
			input{
  				padding: 5px;
  				margin-bottom: 2rem;
 				border: none; 
  				border:solid 1px #ccc;
  				border-radius: 5px;
			}
			
			.loginButton{
				border-radius: 5px;
				width: 20rem;
  				height: 4rem;
  				font-size:2rem;
  				margin-bottom:1rem;
  				font-weight:bold;
  				border: 2px solid #528B8B;
  				color: #528B8B;
			}
			
			.loginButton:hover{
				background-color:#528B8B;
				color: white;
			}
			
			.createAccount{
				font-size:1.3rem;
				color:#6E7B8B;
				border:0px;
				background-color:transparent;
				margin:1rem;
			}
			.createAccount:hover{
				color:#528B8B;
				font-weight:bold;
				font-size:1.5rem;
			}
			
			.lable{
				font-size:2rem;
				color:#528B8B;
				font-weight:bold;
			}
			
			.errorMsg{
				font-size:1.5rem;
				color: red;
				font-weight:bold;
			}
			
		</style>
	</head>
	<body>
		<form method="post"
			action="${pageContext.request.contextPath}/loginSubmit">

			<div class="stuSystemBlock">
				<h1 class="title">學生管理系統</h1>
			</div>
			<div style="height:4rem"></div>
			<div class="loginBlock" >
				<h2 class="loginText">登入</h2>
				<p class="errorMsg">${error_msg}</p>
				<label class="lable">帳號:&emsp;</label>
				<input type="text" id="account" name="account" placeholder="請輸入帳號" >
				<br>
				<label class="lable">密碼:&emsp;</label>
				<input type="password" id="password" name="password" placeholder="請輸入密碼" >
				<br><br>
				<button class="loginButton" onclick="login(this.form)">登入</button>
				<br>
				<button class="createAccount" onclick="toCreateAccountPage(this.form)">註冊帳號</button>
			</div>
			
		</form>
		
		<script>
			function login(theForm){
				
				theForm.submit();
			}
			function toCreateAccountPage(theForm){
				theForm.action="${pageContext.request.contextPath}/toCreateAccountPage"
				theForm.submit();
			}
		</script>
	</body>
</html>