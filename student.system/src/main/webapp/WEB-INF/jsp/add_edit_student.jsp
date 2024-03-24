<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Document</title>
		
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
			
			.addAndEditBlock{
				padding: 2rem;
				border: 3px solid #528B8B;
				background-color: #F0F8FF;
				border-radius: 5px;
				width:40%;
				margin:0 auto;
			}
			.addAndEdit{
				font-size:3rem;
			}
			
			table{
				border-collapse: collapse;
				text-align:center;
				font-size: 2rem;
				width:100%;
			}
			
			th,td{
				width:50%;
				height: 50px;
			}
			
			.textInput{
				height: 20px;
			}
			
			.buttonBlock{
				margin: 2rem;
				text-align:center;
			}
			
			.tableButton{
				border-radius: 5px;
				width: 10rem;
  				height: 2.5rem;
  				font-size:1.5rem;
  				border:1px solid #2F4F4F;
  				margin:1rem;
			}
			
			.tableButton:hover{
				background-color:#528B8B;
				color: white;
			}
			
			.backToQuery{
				font-size:2rem;
				border:0px;
				background-color:transparent;
			}
			
			.backToQuery:hover{
				color:#528B8B;
				font-weight:bold;
				font-size:2.1rem;
			}
			
			.topButtonBlock{
				height:22px;
				text-align:right;
			}
			
			.topButton{
				font-size:15px;
				border:0px;
				background-color:transparent;
				font-weight:bold;
			}
			
			.topButton:hover{
				color:#528B8B;
				font-weight:bolder;
				font-size:18px;
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
			action="${pageContext.request.contextPath}/add_student">

			<div class="topButtonBlock">
				<h2>${admin.adminName}，你好!&ensp;</h2>
				<button class="topButton" onclick="toClassPage(this.form)">管理班級</button>
				<label class="topButton">|</label>
				<button class="topButton" onclick="logout(this.form)">登出</button>
			</div>

			<div class="stuSystemBlock">
				<h1 class="title">學生管理系統</h1>
			</div>
			<div style="height:4rem"></div>
			<br>
<!-- 			<div class="backToQueryBlock" style="padding:1rem; text-align:right;"> -->
<!-- 				<button class="backToQuery" onclick="backToQueryPage(this.form)">返回查詢頁面</button> -->
<!-- 			</div> -->
			<div class="addAndEditBlock" >
				<h3 class="addAndEdit">${addAndEditStuTitle}</h3>
				<p class="errorMsg">${error_msg}</p>
				<input type="hidden" name="stuId" value="${toEditStuInfo.stuId}">
     			<table border="1px solid">
     				<tr>	
     					<th>學號</th>
     					<td>
      						<input class="textInput" name="stuNo" value="${toEditStuInfo.stuNo}"/>
     					</td>
     				</tr>
     				<tr>	
     					<th>姓名</th>
     					<td>
      						<input class="textInput"name="stuName" value="${toEditStuInfo.stuName}"/>
     					</td>
     				</tr>
     				<tr>
     					<th>性別</th>
     					<td>
      						<input type="radio" name="stuGender" value="男" ${toEditStuInfo.stuGender eq '男' ? 'checked' : ''}> 男
        					<input type="radio" name="stuGender" value="女" ${toEditStuInfo.stuGender eq '女' ? 'checked' : ''}> 女
     					</td>
     				</tr>
     				<tr>
     					<th>班級</th>
     					<td>
      						<select name="stuClass.scId">
       							<option value="" label="---請選擇---" />
       							<c:forEach var="eachClassList" items="${allClassList}">
       								<option value="${eachClassList.scId}"  ${toEditStuInfo.stuClass.scId eq eachClassList.scId ? 'selected' : ""} label="${eachClassList.scClassName} (${eachClassList.scTeacher})"/>
       							</c:forEach>
      						</select>
     					</td>
     				</tr>
     				
 
     			</table>
					<div class="buttonBlock">
						<button class="tableButton" onclick="backToQueryPage(this.form)">取消</button>
						<c:if test="${toEditStuInfo eq null}">
	     					<input type="button" class="tableButton" name="addButton" value="新增" onclick="add(this.form);">
	     				</c:if>
	     				<c:if test="${toEditStuInfo != null}">
	     					<input type="button" class="tableButton" name="editButton" value="確定" onclick="editStudent(this.form);">
	     				</c:if>
     				</div>
			</div>
		</form>
		
		<script>
			function backToQueryPage(theForm){
				theForm.action="${pageContext.request.contextPath}/query_page"
				theForm.submit();
			}
					
			function logout(theForm){
				theForm.action="${pageContext.request.contextPath}/logout"
				theForm.submit();
			}
			
			function add(theForm){
				theForm.submit();
			}
			
			function editStudent(theForm){
				theForm.action="${pageContext.request.contextPath}/edit_student"
				theForm.submit();
			}
			
			function toClassPage(theForm){
				theForm.action="${pageContext.request.contextPath}/class_page"
				theForm.submit();
			}
			

		</script>
	</body>
</html>