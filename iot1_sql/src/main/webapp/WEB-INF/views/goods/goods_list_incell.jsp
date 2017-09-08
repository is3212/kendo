<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<c:url var="readUrl" value="/goods/list" />
<c:url var="createUrl" value="/goods/create" />
<c:url var="updateUrl" value="/goods/update" />
<c:url var="deleteUrl" value="/goods/delete" />
<c:url var="v_readUrl" value="/vendor/list" />
<c:url var="v_createUrl" value="/vendor/create" />
<c:url var="v_updateUrl" value="/vendor/update" />
<c:url var="v_deleteUrl" value="/vendor/delete" />
<c:url var="vendorComboUrl" value="/vendor/combo" />
<title>Insert title here</title>
</head>
<body>
	<script>
		$(document).ready(function() {
			if (!"${vendors}") {
				location.href = "${vendorComboUrl}";
			}
		})
	</script>
	<!--
<script>
function callback(result){
	alert(result.length);
	var resultStr="";
	resultStr+="<table border='1'>"
	resultStr+="<tr>";
	resultStr+="<td align='center'>상품번호</td>";
	resultStr+="<td align='center'>상품이름</td>";
	resultStr+="<td align='center'>상품설명</td>";
	resultStr+="<td align='center'>회사번호</td>";
	resultStr+="<td align='center'>상품날짜</td>";
	resultStr+="<td align='center'>상품시간</td>";
	resultStr+="</tr>";
	for(var i=0,max=result.length;i<max;i++){
		var results=result[i];
		resultStr+="<tr>";
		resultStr+="<td align='center'>" + results.giNum + "</td>";
		resultStr+="<td align='center'>" + results.giName + "</td>";
		resultStr+="<td align='center'>" + results.giDesc + "</td>";
		resultStr+="<td align='center'>" + results.viNum + "</td>";
		resultStr+="<td align='center'>" +results.giCredat + "</td>";
		resultStr+="<td align='center'>" + results.giCretim + "</td>";
		resultStr+="</tr>";
	}
	resultStr+="</table>";
	$("#r_div").html(resultStr);
}
$(document).ready(function(){
	$("input[type='button']").click(function(){
		var au= new AjaxUtil("goods/list");
		au.setCallbackSuccess(callback);
		au.send();
	})
})
</script>
<br><p/><br><p/><br><p/><br><p/>
<form action="${rootPath}/goods/list" method="post">
<input type="button" value="전송">
</form>
<div id="r_div">
</div>
 -->
	<br>
	<p />
	<br>
	<p />
	<br>
	<p />
	<kendo:grid title="그리드" name="vendor" pagaable="true" sortable="true"
		scrollable="true" height="450" navigatable="true">
		<kendo:grid-editable mode="incell" />
		<kendo:grid-toolbar>
			<kendo:grid-toolbarItem name="create" text="생성" />
			<kendo:grid-toolbarItem name="save" text="저장" />
		</kendo:grid-toolbar>
		<kendo:grid-columns>
			<kendo:grid-column title="회사번호" field="viNum" editable="false" />
			<kendo:grid-column title="회사이름" field="viName" />
			<kendo:grid-column title="회사설명" field="viDesc" />
			<kendo:grid-column title="회사주소" field="viAddress" />
			<kendo:grid-column title="회사 전화번호" field="viPhone" />
			<kendo:grid-column title="회사일자" field="viCredat"
				format="{0:yyyy-MM-dd}" />
			<kendo:grid-column title="회사시간" field="viCretim"
				format="{0:hh:ii:ss}" />
			<kendo:grid-column command="destroy" title="삭제" />
		</kendo:grid-columns>

		<kendo:dataSource pageSize="20" batch="true">
			<kendo:dataSource-transport>
				<kendo:dataSource-transport-read url="${v_readUrl }" dataType="json"
					type="POST" contentType="application/json" />
				<kendo:dataSource-transport-create url="${v_createUrl }"
					dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-update url="${v_updateUrl }"
					dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-destroy url="${v_deleteUrl }"
					dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-parameterMap>
					<script>
						function parameterMap(options, type) {
							if (type === "read") {
								return JSON.stringify(options);
							} else {
								return JSON.stringify(options.models);
							}
						}
					</script>
				</kendo:dataSource-transport-parameterMap>
			</kendo:dataSource-transport>

			<!-- 입력할 데이터의 각각의 구분값, 입력할 값 정의할때 -->
			<kendo:dataSource-schema>
				<kendo:dataSource-schema-model id="viNum">
					<kendo:dataSource-schema-model-fields>
						<kendo:dataSource-schema-model-field name="viName" type="String">
							<kendo:dataSource-schema-model-field-validation required="true" />
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viDesc" type="String">
							<kendo:dataSource-schema-model-field-validation required="true" />
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viAddress"
							type="String">
							<kendo:dataSource-schema-model-field-validation required="true"
								min="1" />
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viPhone" type="String">
							<kendo:dataSource-schema-model-field-validation required="true" />
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viCredat"
							editable="true" type="date">
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viCretim"
							editable="false">
						</kendo:dataSource-schema-model-field>
					</kendo:dataSource-schema-model-fields>
				</kendo:dataSource-schema-model>
			</kendo:dataSource-schema>
		</kendo:dataSource>
	</kendo:grid>
	<br>
	<p />
	<br>
	<p />
	<br>
	<p />
	<!-- column 정의 -->
	<kendo:grid title="그리드" name="grid" pageable="true" sortable="true"
		scrollable="true" height="450" navigatable="true">
		<kendo:grid-editable mode="incell" />
		<kendo:grid-toolbar>
			<kendo:grid-toolbarItem name="create" text="생성" />
			<kendo:grid-toolbarItem name="save" text="저장" />
		</kendo:grid-toolbar>
		<kendo:grid-columns>
			<kendo:grid-column title="제품번호" field="giNum" editable="false" />
			<kendo:grid-column title="제품이름" field="giName" />
			<kendo:grid-column title="제품설명" field="giDesc" />
			<kendo:grid-column title="회사번호" field="viNum">
				<kendo:grid-column-values value="${vendors}" />
			</kendo:grid-column>
			<kendo:grid-column title="생산일자" field="giCredat"
				format="{0:yyyy-MM-dd}" />
			<kendo:grid-column title="생산시간" field="giCretim"
				format="{0:hh:ii:ss}" />
			<kendo:grid-column command="destroy" title="삭제" />
		</kendo:grid-columns>

		<!-- 데이터 정의 -->
		<kendo:dataSource pageSize="20" batch="true">
			<kendo:dataSource-transport>
				<kendo:dataSource-transport-read url="${readUrl }" dataType="json"
					type="POST" contentType="application/json" />
				<kendo:dataSource-transport-create url="${createUrl }"
					dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-update url="${updateUrl }"
					dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-destroy url="${deleteUrl }"
					dataType="json" type="POST" contentType="application/json" />
				<kendo:dataSource-transport-parameterMap>
					<script>
						function parameterMap(options, type) {
							if (type === "read") {
								return JSON.stringify(options);
							} else {
								return JSON.stringify(options.models);
							}
						}
					</script>
				</kendo:dataSource-transport-parameterMap>
			</kendo:dataSource-transport>

			<!-- 입력할 데이터의 각각의 구분값, 입력할 값 정의할때 -->
			<kendo:dataSource-schema>
				<kendo:dataSource-schema-model id="giNum">
					<kendo:dataSource-schema-model-fields>
						<kendo:dataSource-schema-model-field name="giName" type="String">
							<kendo:dataSource-schema-model-field-validation required="true" />
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giDesc" type="String">
							<kendo:dataSource-schema-model-field-validation required="true" />
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="viNum" type="number">
							<kendo:dataSource-schema-model-field-validation required="true"
								min="1" />
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giCredat"
							editable="true" type="date">
						</kendo:dataSource-schema-model-field>
						<kendo:dataSource-schema-model-field name="giCretim"
							editable="false">
						</kendo:dataSource-schema-model-field>
					</kendo:dataSource-schema-model-fields>
				</kendo:dataSource-schema-model>
			</kendo:dataSource-schema>
		</kendo:dataSource>
	</kendo:grid>
</body>
</html>