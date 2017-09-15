<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@page session="false" %>
<c:set var="dbTreeJsp" value="/WEB-INF/views/db/db_treeview.jsp" />
<c:set var="tableInfoJsp" value="/WEB-INF/views/db/table_info.jsp" />
<c:set var="tabJsp" value="/WEB-INF/views/db/tab.jsp" />
<c:url var="tableInfoUrl" value="/db/table/info" />

<title>IOT SQL</title>
</head>
<script>
var treeview;

function onBound(){
	if(!treeview){
	treeview = $('#treeview').data('kendoTreeView');
	}
}
	
	$(document).ready(function(){
		var cnt=0;
	$("#query").keydown(function(e){           //브라우저가 e한테 주는것
		var keyCode=e.keyCode || e.which;         //key코드 입력 방식 운영 체제마다 달라서 or로
		if(keyCode==120){             //f9
			cnt++;
		console.log(cnt);
			var sql;
			var sqls;
			if(e.ctrlKey&&keyCode==120&&e.shiftKey){
				sql=this.value;
				var cursor=this.selectionStart;
				var startSql=sql.substr(0,cursor);
				var startSap=startSql.lastIndexOf(";")
				startSql=startSql.substr(startSap+1);
				var endSql=sql.substr(cursor);
				var endSap=endSql.indexOf(";");
				if(endSap==-1){
					endSap=sql.length;
				}
				endSql=endSql.substr(0,endSap);
				sql=startSql+endSql;
			}else if(e.ctrlKey&&keyCode==120){
				sql=this.value.substr(this.selectionStart,this.selectionEnd - this.selectionStart);
			}else if(keyCode==120){
				sql=this.value;
			}
			if(sql){
				sql=sql.trim();
				sqls=sql.split(";");
				if(sqls.length==1){
					var au=new AjaxUtil("db/run/sql");
					var param={};
					param["sql"]=sql;
					au.param=JSON.stringify(param);
					au.setCallbackSuccess(callbackSql);
					au.send();
					return;
				}else if(sqls){
					return;
				}
			}
		}
	});
});

function callbackSql(result){
	var key = result.key;
	var obj=result[key];
	var error_msg=result.error;  //로그 에러메세지 
	if(obj){                                              //컨트롤러의  runSql 성공하면
		var gridData= obj.list;          //runSql의 list 값을 불러온다
		var resultMsg=result.msg; //runSql의 성공메세지를 불러온다
		var sql_Result=obj.row;      //sql이 insert,update,delete일때 로우 갯수 불러온다  
		var gridMsg="";                      //로그 메세지 초기화
		
		if(sql_Result==null){             //insert,update,delete일때의 로우 갯수가 없을때, 즉 select만
			gridMsg = $("#msgGrid").append(resultMsg+ "</br>");   //셀렉트일때만의 코딩성공 메세지 출력
		}else if(sql_Result!=null && sql_Result==1){  //insert,update,delete일때의 로우 갯수와 코딩이 성공적일때
		 gridMsg=$("#msgGrid").append("업데이트 행 갯수 : " + sql_Result + "</br>");  //행 갯수 출력
		 gridMsg = $("#msgGrid").append(resultMsg+ "</br>");       //코딩 성공 출력
		}else if(sql_Result!=null && sql_Result==0){       //insert,update,delete일때의 로우 갯수가 존재하고  코딩이 실패일때
			alert("sql 코딩 오류");   //오류 팝업 출력
			gridMsg = $("#msgGrid").append("sql 코딩 오류</br>");   //오류 출력
		}

	try{
		$('#resultGrid').kendoGrid('destroy').empty();    //성공된 쿼리를 실행할때마다 그리드값 바꾸기 위해서 지운다.
	}catch(e){
		
	}
	var grid = $("#resultGrid").kendoGrid({   //밑에 middle-pane kendo grid에 list를 삽입
		dataSource : {
			data : gridData,   //위에 gridData를 데이터로 사용
			pageSize : 5        //5개씩 출력
		},
		editable:false,
		sortable:true,
		pageable:true
	});
	}else{   //runSql이 실패했을때
		if(grid){   //첫 코딩이 성공하고, 그리드가 생성되었을때
		$('#resultGrid').kendoGrid('destroy').empty();   //그리드 삭제, 코딩이 실패했으므로 처음 성공된 그리드를 지우기위해
		}
		alert("쿼리 코딩 에러");    //에러 팝업 출력
		gridMsg = $("#msgGrid").append(error_msg+ "</br>");   //컨트롤러에서 선언된 쿼리 에러 메세지 출력
	}
}

function toolbarEvent(e){
	if($("#btnConnect").text()=="접속해제"){
		treeview.dataSource.read();
		$("#btnConnect").text("접속");
		return;
	}
	var data = treeview.dataItem(window.selectedNode);
	if(data && data.diNum){
		//$('#treeview>.k-group>.k-item>.k-group').remove();
		//treeview.dataSource.read();
		var au = new AjaxUtil("db/connecte");
		var param = {};
		param["diNum"] = data.diNum;
		au.param = JSON.stringify(param);
		au.setCallbackSuccess(callbackForTreeItem);
		au.send();
	}else{
		alert("접속하실 데이터베이스를 선택해주세요");
	}
}
function treeSelect(){
	window.selectedNode = treeview.select();
	var data = treeview.dataItem(window.selectedNode);
	if(data.database && !data.hasChildren){
		var au = new AjaxUtil("db/table/list");
		var param = {};
		param["database"] = data.database;
		au.param = JSON.stringify(param);
		au.setCallbackSuccess(callbackForTreeItem2);
		au.send();
}else if(data.tableName){
	var ki=new KendoItem(treeview, $("#tableInfoGrid"),"${tableInfoUrl}","tableName");
	ki.send();
}
}
	function callbackForTreeItem(result){
		if(result.error){
			alert(result.error);
			return;
		}
		for(var i=0, max=result.databaseList.length;i<max;i++){
			var database = result.databaseList[i];
			treeview.append({
				database: database.database
	        }, treeview.select());
		}
		$("#btnConnect").text("접속해제");
	}
	
	function callbackForTreeItem2(result){
		if(result.error){
			alert(result.error);
			return;
		}
		for(var i=0, max=result.tableList.length;i<max;i++){
			var table = result.tableList[i];
			treeview.append({
				tableName: table.tableName
	        }, treeview.select());
		}
	}

</script>
<body>
<c:import url="${menuUrl}"/>
	<kendo:splitter name="vertical" orientation="vertical">
		<kendo:splitter-panes>
			<kendo:splitter-pane id="top-pane" collapsible="false">
				<kendo:splitter-pane-content>
					<kendo:splitter name="horizontal"
						style="height: 100%; width: 100%;">
						<kendo:splitter-panes>
							<kendo:splitter-pane id="left-pane" collapsible="true"
								size="220px">
								<kendo:splitter-pane-content>
									<div class="pane-content">
									<c:import url="${dbTreeJsp}"/>
									</div>
								</kendo:splitter-pane-content>
							</kendo:splitter-pane>
							<kendo:splitter-pane id="center-pane" collapsible="false">
								<kendo:splitter-pane-content>
									<kendo:splitter name="vertical1" orientation="vertical"
										style="height: 100%; width: 100%;">
										<kendo:splitter-panes>
											<kendo:splitter-pane id="top-pane" collapsible="false">
												<div class="pane-content">
													<c:import url="${tabJsp}"/>
												</div>
											</kendo:splitter-pane>
											<kendo:splitter-pane id="middle-pane" collapsible="true">
												<div class="pane-content">
													<div id="resultGrid" style="width:100%;"></div>
												</div>
											</kendo:splitter-pane>

										</kendo:splitter-panes>
									</kendo:splitter>
								</kendo:splitter-pane-content>
							</kendo:splitter-pane>
						</kendo:splitter-panes>
					</kendo:splitter>
				</kendo:splitter-pane-content>
			</kendo:splitter-pane>
			<kendo:splitter-pane id="middle-pane" collapsible="false"
				size="100px">
				<kendo:splitter-pane-content>
					<div class="pane-content">
						<div id="msgGrid" style="width:100%;"></div>
					</div>
				</kendo:splitter-pane-content>
			</kendo:splitter-pane>
			<kendo:splitter-pane id="bottom-pane" collapsible="false"
				resizable="false" size="20px" scrollable="false">
				<kendo:splitter-pane-content>
					<b>MySql Tool For Web</b>
				</kendo:splitter-pane-content>
			</kendo:splitter-pane>
		</kendo:splitter-panes>
	</kendo:splitter>

	<style>
#vertical {
	height: 580px;
	margin: 0 auto;
}

#middle-pane {
	color: #000;
	background-color: #fff;
}

#bottom-pane {
	color: #000;
	background-color: #fff;
}

#left-pane, #center-pane, #right-pane {
	color: #000;
	background-color: #fff;
}

.pane-content {
	padding: 0 10px;
}

#toolbar {
	border-width: 0 0 1px;
}

.user-image {
	margin: 0 .5em;
}

#example {
	height: 500px;
}

#example .box p {
	padding-bottom: 5px;
}

#content .demo-section {
	margin: 0;
	padding: 10px;
	border-width: 0 0 1px 0;
}

#content .demo-section label {
	display: inline-block;
	width: 40px;
	text-align: right;
	line-height: 2.5em;
	vertical-align: middle;
}

#content .demo-section input {
	width: 80%;
}
    a[class='k-link'], tr{ 
		text-align: center;
		color:blue;
	}
</style>
</body>
</html>