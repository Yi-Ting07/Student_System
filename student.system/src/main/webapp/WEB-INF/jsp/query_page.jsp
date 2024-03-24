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
			
			.queryBlock{
				padding: 2rem;
				border: 3px solid #528B8B;
				background-color: #F0F8FF;
				border-radius: 5px;
			}
			.queryText{
				font-size:3rem;
			}
			
			.queryTh{
				background-color:#E0EEEE;
			}
			
			.queryTable{
				border-collapse: collapse;
				text-align:center;
				font-size: 2rem;
			}
			
			.resultTable{
				border-collapse: collapse;
				text-align:center;
				font-size: 2rem;
				width:100%;
			}
			
			.buttonBlock{
				margin: 2rem;
				text-align:center;
			}
			
			.queryButton{
				border-radius: 5px;
				width: 10rem;
  				height: 2.7rem;
  				font-size:1.7rem;
  				border:1px solid #2F4F4F;
			}
			
			.queryButton:hover, .deleteButton:hover{
				background-color:#528B8B;
				color: white;
				font-weight:bold;
			}
			
			.resultTh{
				width:8.5%;
			}
			
			.addAndLogout{
				font-size:2rem;
				border:0px;
				background-color:transparent;
			}
			
			.addAndLogout:hover{
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
				<button class="topButton" onclick="toClassPage(this.form)">管理班級</button>
				<label class="topButton">|</label>
				<button class="topButton" onclick="logout(this.form)">登出</button>
			</div>
			
			<div class="stuSystemBlock">
				<h1 class="title">學生管理系統</h1>
				
			</div>
			<br>
			<div style="padding:1rem; text-align:right;">
				<button class="addAndLogout" onclick="addStudent(this.form)">新增</button>
			</div>
			<div class="queryBlock" >
				<h3 class="queryText">學生查詢系統</h3>
				<p class="errorMsg">${error_msg}</p>
				<table border="1px solid" class="queryTable">
   					<tr class="batchQuery">
     					<th class="queryTh" width="10%">班&emsp;&emsp;級</th>
     					<td width="10%">班級</td>
     					<td width="10%">
      						<select name="query.scClassName" >
       							<option value="" label="---請選擇---" />
       							<c:forEach var="eachClassList" items="${allClassList}">
       								<option value="${eachClassList.scClassName}" label="${eachClassList.scClassName}"/>
       							</c:forEach>
      						</select> 班
     					</td>
     					
     					<td width="10%">老師</td>
     					<td width="10%">
      						<select name="query.scTeacher" >
       							<option value="" label="---請選擇---" />
       							<c:forEach var="eachClassList" items="${allClassList}">
       								<option value="${eachClassList.scTeacher}" label="${eachClassList.scTeacher}"/>
       							</c:forEach>
      						</select>
     					</td>
     				</tr>
     				
     				<tr class="batchQuery">
     					<th class="queryTh" width="10%">學&emsp;&emsp;生</th>
     					<td width="10%">姓名</td>
     					<td width="10%">
      						<input name="query.stuName"/>
     					</td>   
     	
     					<td width="10%">學號</td>
     					<td width="10%">
      						<input name="query.stuNo"/>
     					</td>
     					
     					<td width="10%">性別</td>
     					<td width="10%">
      						<input type="radio" name="query.stuGender" value="男"> 男
        					<input type="radio" name="query.stuGender" value="女"> 女
     					</td>
     				</tr>
     				<tr class="batchQuery">
     					<th class="queryTh" width="10%">管&ensp;理&ensp;員</th>
     					<td width="10%">建立人員</td>
     					<td width="10%">
      						<input name="query.createrName"/>
     					</td>   
     	
     					<td width="10%">更新人員</td>
     					<td width="10%">
      						<input name="query.updaterName"/>
     					</td>
     				</tr>
     			</table>
					<div class="buttonBlock">
     				<input type="button" class="queryButton" name="queryButton" value="查詢" onclick="toQuery(this.form);">
     				</div>
			</div>
			
			<div style="height:2rem"></div>
			
			<div class="queryBlock">
				<h3 class="queryText">學生清單</h3>
  				<input type="hidden" name="editStudentId" id="editStudentId"/>
  				<table border="1" class="resultTable">
   					<thead>
    					<tr>
     						<th width="5%">No.
     						<th class="resultTh">學號</th>
    						<th class="resultTh">姓名</th>
     						<th width="4%">性別</th>
     						<th class="resultTh">班級</th>
     						<th class="resultTh">老師</th>
     						<th class="resultTh">建立日期</th>
     						<th class="resultTh">建立人員</th>
     						<th class="resultTh">更新日期</th>
     						<th class="resultTh">更新人員</th>
     						<th width="4%">編輯</th>
     						<th width="4%">刪除<input type="checkbox" onclick="doCheckAllCheckboxes(this,'deleteStudentIds');" /></th>
    					</tr>
   					</thead>
   					<c:choose>
    					<c:when test="${empty stuQueryPageForm.stuSearchResultList}">
     						<tr>
            					<td colspan="12" align="center">
                					<div class="error">查無資料!</div>
               					</td>
           					</tr> 
    					</c:when>
    					<c:otherwise>
     						<c:forEach var="eachResult" varStatus="status" items="${stuQueryPageForm.stuSearchResultList}">
      							<tr>
         							<td align="center">${status.index+1}</td>
         							<td align="center">${eachResult.stuNo}</td>
         							<td align="center">${eachResult.stuName}</td>
         							<td align="center">${eachResult.stuGender}</td>
         							<td align="center">${eachResult.scClassName}</td>
         							<td align="center">${eachResult.scTeacher}</td>
         							<td align="center">
         								<fmt:formatDate value="${eachResult.stuCreateDate}" pattern="yyyy-MM-dd"/>
         							</td>
         							<td align="center">${eachResult.stuCreater}</td>
         							<td align="center">
         								<fmt:formatDate value="${eachResult.stuUpdateDate}" pattern="yyyy-MM-dd"/>
         							</td>
         							<td align="center">${eachResult.stuUpdater}</td>
         							<td>
         								<button class="editButton" name="editButton" onclick="editStudent(this.form, ${eachResult.stuId})">編輯</button>
         							</td>
         							<td align="center">
         								<input type="checkbox" name="deleteStudentIds" value="${eachResult.stuId}"/> 
         							</td>
      							</tr>
     						</c:forEach>
    					</c:otherwise>
   					</c:choose>
  				</table>
  				<div style="padding:1rem; text-align:right">
  					<input type="button" class="deleteButton" name="deleteButton" value="刪除" onclick="deleteStudent(this.form);">
  				</div>
 			</div>
			
		</form>
		
		<script>
			function toQuery(theForm){
				theForm.action="${pageContext.request.contextPath}/result_list"
				theForm.submit();
			}
			
			function addStudent(theForm){
				theForm.action="${pageContext.request.contextPath}/to_add_student"
				theForm.submit();
			}
			
			function editStudent(theForm, studentId){
				document.getElementById("editStudentId").value = studentId;
				theForm.action="${pageContext.request.contextPath}/to_edit_student"
				theForm.submit();
			}
			
			function deleteStudent(theForm){
				theForm.action="${pageContext.request.contextPath}/to_delete_student"
				theForm.submit();
			}
			
			function logout(theForm){
				theForm.action="${pageContext.request.contextPath}/logout"
				theForm.submit();
			}
			
			function toClassPage(theForm){
				theForm.action="${pageContext.request.contextPath}/class_page"
				theForm.submit();
			}
			
			function doCheckAllCheckboxes(checkBox,checkBoxsName){
				$("input[name='"+checkBoxsName+"']").prop("checked", checkBox.checked);
			}
		</script>
	</body>
</html>