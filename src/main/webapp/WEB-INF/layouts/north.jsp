<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
	    $('a.forward').click(function() {
	        location.href = $(this)[0].href;
	        return false;
	    });
	    
	});
	
	var logoutFun = function() {
	    $("#logout").click();
	};
	var indexFun = function(){
		 mainTab.open({url:'${ctx}/portal/index',title:'首页',closable:false});
	}
	var showMyInfoFun = function(id) {
		var url =  '${ctx}/account/user/personInfo?id='+id;
		 $('#myInfoDialog').dialog({
			width:360,
			height:320,
			title : '我的信息',
			href : url,
	        buttons: [{
	            text: '修改',
	            handler: function() {
	                	var f = $('.panel').find('#userInfoForm');
	                	if(f.form('validate')){
		                	try{
		                	    var data = f.serialize();
		                	    $.ajax({
		                			type: "post",
		                			url: "${ctx}/account/user/savePersonInfo",
		                			data:data,
		                			success: function(result){
		                				if(result.success){
		                					 $('#myInfoDialog').dialog('close');
		                					parent.$.messager.alert('提示', result.msg, 'info');
		                				}else{
		                					 parent.$.messager.alert('提示', result.msg, 'info');
		                				}
		                			},
		                			error: function(){
		                			}
		                		});//end ajax
		                	}catch(err){
		                		alert(err);
		                	}
		                }//end validate  
				 }
	        },
	        {
	            text: '取消',
	            handler: function() {
	            	 $('#myInfoDialog').dialog('close');
	            }
	        }
	        ]
		}).dialog('open');
	  
	};
	function openPwdDlg(id){
		var url = '${ctx}/account/user/personPwdForm?dialog=dialog&id='+id;
		parent.$.modalDialog({
			title : '修改密码',
			iconCls: 'ext-icon-lock_edit',
			width : 550,
			height : 320,
			href : url,
			 buttons: [{
		            text: '修改',
		            handler: function() {
		                	var f = $('.panel').find('#personPwdForm');
		            		if(f.form('validate')){
		                    	try{
		                    	   	var data = f.serialize(); 
		                    	    $.ajax({
		                    			type: "post",
		                    			url: f.attr("action"),
		                    			data:f.serializeArray(),
		                    			success: function(result){
		                    				var obj = eval('('+result+')');
		                    				if(obj.statusCode =='200'){
			                					parent.$.modalDialog.handler.dialog('close');
			                					parent.$.messager.alert('提示', obj.message, 'info');
			                				}else{
			                					 parent.$.messager.alert('提示', obj.message, 'info');
			                				}
		                    			},
		                    			error: function(){
		                    			}
		                    		});//end ajax
		                    	}catch(err){
		                    		parent.$.messager.alert('提示', err, 'info');
		                    	}
		                    }//end validate 
					 }
		        },
		        {
		            text: '取消',
		            handler: function() {
		            	$('#userId').val('${aUs.getCurrentUserId()}');
		            	parent.$.modalDialog.handler.dialog('close');
		            }
		        }]
		
			}).dialog("open");
	}; 
</script>
<div id="sessionInfoDiv" class="logo" style="height: 80px;width: 50%">
	<%-- ${cityName}${districtName}${systemName} --%>
</div>
<div class="logo1" style="height: 80px;width: 420px;position: absolute;  right: 0;  top: 0; ">

<div style="position: absolute; right: 10px; top: 5px;" >
	<c:if test="${!empty aUs.getCurrentUser()}">
		<span style="font-weight: bolder;">用户名称：${aUs.getCurrentUserLoginName()} &nbsp;&nbsp;</span>
		<!-- |&nbsp;&nbsp;所在单位：：${dSv.trsltDictForDynamic('select unitname from acct_department where unitcode = ?',aUs.getCurrentUserDeptcode())} -->
	</c:if>
</div>
<div style="position: absolute; right: 0px; bottom: 5px;">
	<a href="${ctx}/main"  class="easyui-linkbutton">首页</a>
	<!-- <a href="javascript:void(0);" class="easyui-menubutton"
		data-options="menu:'#layout_north_pfMenu',iconCls:'ext-icon-rainbow',plain:false">更换皮肤</a> -->
	<a href="javascript:void(0);" class="easyui-menubutton"
		data-options="menu:'#layout_north_kzmbMenu',iconCls:'ext-icon-cog',plain:false">控制面板</a>
	<a href="javascript:void(0);" class="easyui-menubutton"
		data-options="menu:'#layout_north_zxMenu',iconCls:'ext-icon-disconnect',plain:false">注销</a>
</div>
</div>
<div id="layout_north_pfMenu" style="width: 150px; display: none;">
	<div onclick="changeTheme('default');" title="default">默认</div>
	<div onclick="changeTheme('gray');" title="gray">灰色</div>
	<div onclick="changeTheme('green');" title="green">绿色</div>
	<div onclick="changeTheme('black');" title="green">black</div>
	<div onclick="changeTheme('bootstrap');" title="bootstrap">bootstrap</div>
	<div onclick="changeTheme('orange');" title="green">orange</div>
	<div onclick="changeTheme('pink');" title="green">pink</div>
	<div onclick="changeTheme('cupertino');" title="cupertino">cupertino</div>
	<div onclick="changeTheme('sunny');" title="sunny">sunny</div>
	<div onclick="changeTheme('pepper-grinder');" title="pepper-grinder">pepper-grinder</div>
	<div onclick="changeTheme('metro');" title="green">metro</div>
	<div onclick="changeTheme('metro-blue');" title="metro-blue">metro-blue</div>
	<div onclick="changeTheme('metro-gray');" title="metro-gray">metro-gray</div>
	<div onclick="changeTheme('metro-green');" title="metro-green">metro-green</div>
	<div onclick="changeTheme('metro-orange');" title="metro-orange">metro-orange</div>
	<div onclick="changeTheme('metro-red');" title="metro-red">metro-red</div>
</div>
<div id="layout_north_kzmbMenu" style="width: 120px; display: none;">
	<div data-options="iconCls:'ext-icon-user_edit'" onclick="openPwdDlg(${aUs.getCurrentUserId()})">修改密码</div>
	<div data-options="iconCls:'ext-icon-user'"
		onclick='showMyInfoFun(<shiro:principal property="id"/>);'>我的信息</div>
</div>
<div id="layout_north_zxMenu" style="width: 100px; display: none;">
	<!-- <div data-options="iconCls:'ext-icon-lock'" onclick="lockWindowFun();">锁定窗口</div>
	<div class="menu-sep"></div> -->
	<div data-options="iconCls:'ext-icon-door_out'" onclick="logoutFun();">退出系统</div>
	<!-- <div class="menu-sep"></div> -->
	<a id="logout" class="forward" href="${ctx }/logout"
		style="display: none" hidden="true">退出系统</a>
</div>
<div id="myInfoDialog" title="我的信息"  >

</div>