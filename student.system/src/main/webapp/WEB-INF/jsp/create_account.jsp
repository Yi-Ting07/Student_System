<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>學生管理系統</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		
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
			
			
			.signUpText{
				font-size:4rem;
				color:#528B8B;
			}
			
			input{
  				padding: 5px;
 				border: none; 
  				border:solid 1px #ccc;
  				border-radius: 5px;
  				height: 20px;
			}
			
			th,td{
				font-size:2rem;
				color:#528B8B;
				font-weight:bold;
				height: 50px;
			}
			
			td{
				text-align:left;
				padding-left:2rem;
			}
			
			th{
				text-align:right;
			}
			
			.errorMsg{
				font-size:1.5rem;
				color: red;
				font-weight:bold;
			}
			
			.signUpBlock{
				padding: 2rem;
				border-top: 20px solid #528B8B;
				background-color: #F0F8FF;
				border-radius: 5px;
				width:25%;
				margin:0 auto;
				text-align:center;
			}
			
			table{
				border-collapse: collapse;
				font-size: 2rem;
				width:100%;
			}
			
			.confirmButton{
				border-radius: 5px;
				width: 20rem;
  				height: 4rem;
  				font-size:2rem;
  				margin-bottom:1rem;
  				font-weight:bold;
  				border: 2px solid #528B8B;
  				color: #528B8B;
			}
			
			.confirmButton:hover{
				background-color:#528B8B;
				color: white;
			}
			
			.cancelButton{
				font-size:1.3rem;
				color:#6E7B8B;
				border:0px;
				background-color:transparent;
				margin:1rem;
			}
			.cancelButton:hover{
				color:#528B8B;
				font-weight:bold;
				font-size:1.5rem;
			}
			
			#checkAccountText,#checkpasswordText{
				font-size: 1rem;
				color: red;
			}
			
 			#checkAccountImg{ 
 				vertical-align:middle; 
 			} 
			
		</style>
	</head>
	<body>
		<form method="post"
			action="${pageContext.request.contextPath}/toCreateAccountPage">

			<div class="stuSystemBlock">
				<h1 class="title">學生管理系統</h1>
			</div>
			<div style="height:4rem"></div>
			<div class="signUpBlock" >
				<h2 class="signUpText">註冊帳號</h2>
				<p class="errorMsg">${error_msg}</p>
				<table border="0px">
					<tr>
						<th>姓&emsp;&emsp;名: </th>
						<td>
							<input type="text" id="adminName" name="adminName" value="${administrator.adminName}" placeholder="請輸入全名" required>
						</td>
					</tr>
					<tr>
						<th>性&emsp;&emsp;別: </th>
						<td>
							<input type="radio" name="adminGender" value="男" required ${administrator.adminGender eq '男' ? 'checked' : ''}> 男
			        		<input type="radio" name="adminGender" value="女" required ${administrator.adminGender eq '女' ? 'checked' : ''}> 女
	        			</td>
	        		</tr>
	        		<tr>
						<th>帳&emsp;&emsp;號: </th>
						<td>
							<input type="text" id="adminAccountNo" name="adminAccountNo" value="${administrator.adminAccountNo}" placeholder="請輸入帳號" required onblur="checkAccount(this)">
							<img id="checkAccountImg"><div id="checkAccountText"></div>
						</td>
					</tr>
					<tr>
						<th>密&emsp;&emsp;碼: </th>
						<td>
							<input type="password" id="adminPassword" name="adminPassword" value="${administrator.adminPassword}" placeholder="請輸入密碼" required onchange="checkPasswordFunc()">
						</td>
					</tr>
					<tr>
						<th class="lable">確認密碼: </th>
						<td>
							<input type="password" id="checkpassword" name="checkPassword" placeholder="請再輸入密碼" required oninput="checkPasswordFunc()">
							<div id="checkpasswordText"></div>
						</td>
					</tr>
				</table>
				<br><br>
				<input type="button" class="confirmButton" id="confirmButton" onclick="confirm(this.form)" value="註冊">
				<br>
				<button class="cancelButton" onclick="cancel(this.form)">取消註冊</button>
			</div>
			
		</form>
		
		<script>
			function cancel(theForm){
				theForm.action="${pageContext.request.contextPath}/login_page";
				theForm.submit();
			}
			function confirm(theForm){
				if($("#checkAccountText").text() == '此帳號可以使用' && $("#checkpasswordText").text() == ''){
					theForm.action="${pageContext.request.contextPath}/createAccount";
					theForm.submit();
				}else{
					alert('資料有誤，請輸入正確的資料!');
				}
			}
			function checkPasswordFunc(){
				var adminPassword = $("#adminPassword").val();
				var checkpassword = $("#checkpassword").val();
				if(adminPassword != checkpassword){
					$("#checkpasswordText").html("密碼與確認密碼不相同");
				}else{
					$("#checkpasswordText").html("");
				}
			}
			function checkAccount(input){
				$.ajax({
					type: "GET",
					url: "${pageContext.request.contextPath}/createAccount_checkAccount",
					data: {
						"account" : input.value
					},
					dataType: "json",
					success: function(data){
						$("#checkAccountImg").css("height", "32");
						$("#checkAccountImg").css("width", "25");
						if(data.result == '此帳號可以使用'){							
							$("#checkAccountText").html(data.result);
							$("#checkAccountText").css("color", "green");
							$("#checkAccountImg").prop("src","${pageContext.request.contextPath}/img/ok.png");
						}else{
							$("#checkAccountText").html(data.result);
							$("#checkAccountText").css("color", "red");
							$("#checkAccountImg").prop("src","${pageContext.request.contextPath}/img/no.png");
						}
					},
					error: function(e){
						alert("ajax 發生錯誤");
					}
				})
			}
		</script>
	</body>
</html>