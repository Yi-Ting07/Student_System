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
			
			.stuClassBlock{
				padding: 2rem;
				border: 3px solid #528B8B;
				background-color: #F0F8FF;
				border-radius: 5px;
			}
			.stuClassText{
				font-size:3rem;
			}
			
			.resultTable{
				border-collapse: collapse;
				text-align:center;
				font-size: 2rem;
				width:100%;
			}
			
			.deleteButton:hover{
				background-color:#528B8B;
				color: white;
				font-weight:bold;
			}
			
			.resultTh{
				width:8.5%;
			}
			
			.addButton{
				font-size:2rem;
				border:0px;
				background-color:transparent;
			}
			
			.addButton:hover{
				color:#528B8B;
				font-weight:bold;
				font-size:2.1rem;
			}
			
			.editButton{
				background-color:transparent;
				border:0px;
				font-size:1.7rem;
			}
			
			.editButton:hover{
				color:#528B8B;
				font-weight:bold;
				
			}
			
			.deleteButton{
				font-size:1.7rem;
				border-radius: 5px;
				border:1px solid #2F4F4F;
				margin:1rem 2rem 1rem 1rem;
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
						
		</style>
	</head>
	<body>
		<form method="post"
			action="${pageContext.request.contextPath}/result_list">
			
			<div class="topButtonBlock">
				<h2>${admin.adminName}，你好!&ensp;</h2>
				<button class="topButton" onclick="toStudentQueryPage(this.form)">管理學生</button>
				<label class="topButton">|</label>
				<button class="topButton" onclick="logout(this.form)">登出</button>
			</div>
			
			<div class="stuSystemBlock">
				<h1 class="title">學生管理系統</h1>
				
			</div>
			<br>
			<div style="padding:1rem; text-align:right;">
				<button class="addButton" onclick="addClass(this.form)">新增</button>
			</div>
			
			<div class="stuClassBlock">
				<h3 class="stuClassText">班級管理系統</h3>
  				<input type="hidden" name="editClassId" id="editClassId"/>
  				<table border="1" class="resultTable">
   					<thead>
    					<tr>
     						<th width="4%">No.
     						<th class="resultTh">班級</th>
     						<th class="resultTh">老師</th>
     						<th class="resultTh">建立日期</th>
     						<th class="resultTh">建立人員</th>
     						<th class="resultTh">更新日期</th>
     						<th class="resultTh">更新人員</th>
     						<th width="5%">編輯</th>
     						<th width="5%">刪除<input type="checkbox" onclick="doCheckAllCheckboxes(this,'deleteClassIds');" /></th>
    					</tr>
   					</thead>
   					<c:choose>
    					<c:when test="${empty allClassList}">
     						<tr>
            					<td colspan="12" align="center">
                					<div class="error">尚無班級資料!</div>
               					</td>
           					</tr> 
    					</c:when>
    					<c:otherwise>
     						<c:forEach var="eachClassList" varStatus="status" items="${allClassList}">
      							<tr>
         							<td align="center">${status.index+1}</td>
         							<td align="center">${eachClassList.scClassName}</td>
         							<td align="center">${eachClassList.scTeacher}</td>
         							<td align="center">
         								<fmt:formatDate value="${eachClassList.scCreateDate}" pattern="yyyy-MM-dd"/>
         							</td>
         							<td align="center">${eachClassList.classCreater.adminName}</td>
         							<td align="center">
         								<fmt:formatDate value="${eachClassList.scUpdateDate}" pattern="yyyy-MM-dd"/>
         							</td>
         							<td align="center">${eachClassList.classUpdater.adminName}</td>
         							<td>
         								<button class="editButton" name="editButton" onclick="toEditClass(this.form, ${eachClassList.scId})">編輯</button>
         							</td>
         							<td align="center">
         								<input type="checkbox" name="deleteClassIds" value="${eachClassList.scId}"/> 
         							</td>
      							</tr>
     						</c:forEach>
    					</c:otherwise>
   					</c:choose>
  				</table>
  				<div style="padding:1rem; text-align:right">
  					<input type="button" class="deleteButton" name="deleteButton" value="刪除" onclick="deleteClass(this.form);">
  				</div>
 			</div>
			
		</form>
		
		<script>
			function toStudentQueryPage(theForm){
				theForm.action="${pageContext.request.contextPath}/query_page"
				theForm.submit();
			}
			
			function addClass(theForm){
				theForm.action="${pageContext.request.contextPath}/to_add_class"
				theForm.submit();
			}
			
			function toEditClass(theForm, classId){
				document.getElementById("editClassId").value = classId;
				theForm.action="${pageContext.request.contextPath}/to_edit_class"
				theForm.submit();
			}
			
			function deleteClass(theForm){
				theForm.action="${pageContext.request.contextPath}/delete_class"
				theForm.submit();
			}
			
			function logout(theForm){
				theForm.action="${pageContext.request.contextPath}/logout"
				theForm.submit();
			}
			
			function doCheckAllCheckboxes(checkBox,checkBoxsName){
				$("input[name='"+checkBoxsName+"']").prop("checked", checkBox.checked);
			}
		</script>
	</body>
</html>