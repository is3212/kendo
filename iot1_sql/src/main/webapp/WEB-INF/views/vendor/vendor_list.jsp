<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<title>Insert title here</title>
</head>
<body>
<script>
function callback(result){
	alert(result.length);
	var resultStr="";
	resultStr+="<table border='1'>";
	resultStr+="<tr>";
	resultStr+="<td align='center'>회사번호</td>";
	resultStr+="<td align='center'>회사이름</td>";
	resultStr+="<td align='center'>회사설명</td>";
	resultStr+="<td align='center'>회사주소</td>";
	resultStr+="<td align='center'>회사번호</td>";
	resultStr+="<td align='center'>회사날짜</td>";
	resultStr+="<td align='center'>회사시간</td>";
	resultStr+="</tr>";
	for(var i=0, max=result.length;i<max;i++){
		var results=result[i];
		resultStr+="<tr>";
		resultStr+="<td align='center'>" + results.viNum + "</td>";
		resultStr+="<td align='center'>" + results.viName + "</td>";
		resultStr+="<td align='center'>" + results.viDesc + "</td>";
		resultStr+="<td align='center'>" + results.viAddress + "</td>";
		resultStr+="<td align='center'>" +results.viPhone + "</td>";
		resultStr+="<td align='center'>" + results.viCredat + "</td>";
		resultStr+="<td align='center'>" + results.viCretim + "</td>";
		resultStr+="</tr>";
	}
	results+="</table>";
	$("#r_div").html(resultStr);
}
$(document).ready(function(){
	$("input[type='button']").click(function(){
		var au=new AjaxUtil("vendor/list");
		au.setCallbackSuccess(callback);
		au.send();
	})
})
</script>
<br><p/><br><p/><br><p/><br><p/>
<form action="${rootPath}/vendor/list" method="post">
<input type="button" value="전송">
</form>
<div id="r_div">
</div>
</body>
</html>