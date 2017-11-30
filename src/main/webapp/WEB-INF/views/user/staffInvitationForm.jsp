<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="modal-body">
	<style>
	.selected {
			width: 17px;
			height: 17px;
			background-color: rgb(255,178,38);
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
			float: right;
			vertical-align: middle;
			margin-top: 13px;
		}
		.unselected {
			width: 15px;
			height: 15px;
			background-color: #ffffff;
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
			float: right;
			vertical-align: middle;
		    border: 1.0px solid #999999; 
			margin-top: 13px;
		}
		.pl{margin-left:0.1rem;float: left;}
		.pr{float: right;}
		.user-list{width:auto;margin: 1rem 0.5rem;border-bottom: 1px solid #f5f5f5;}
		.check-label{display:inline-block;width:100%;height: 100%}
	</style>
	<form id="invitationSubForm" method="post" action="${ctx}/weixin/user/invitation/send" class="form-horizontal m-t">
		<!--   -->
		<input type="hidden" id="search_EQ_mobile" name="search_EQ_mobile" value="">
		<input type="hidden" id="search_LIKE_rname" name="search_LIKE_rname" value="">
		<input id="userIds" name="userIds" type="hidden" value="">
		<input id="flag" name="flag" type="hidden" value="${flag }">
		<input id="type" name="type" type="hidden" value="${type }">
		<input id="hgId" name="hgId" type="hidden" value="${hgId }">
		<input id="hotelId" name="hotelId" type="hidden" value="${hotelId }">
		<div class="form-group form-inline">
			<div class="col-sm-12" style="padding:0 15px;">
				  <div class="form-group" style="margin: 0;">
				   		<input type="text" class="form-control" id="input_search_val" name="input_search_val" placeholder="请输入姓名或手机号码">
				  </div>
				  <button type="button" id="btn_user_search" class="btn btn-primary" ><span class="glyphicon glyphicon-search"> </span> 查询</button>
			</div>
		</div>
		<div class="form-group form-inline" style="max-height: 500px;overflow: auto;">
			<div id="div_list_parent" class="content tran-list-ct" style="width:100%;margin-top: 0;">
				 <div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;margin: 5px;">
					A-G
				</div>
				 <div style="color: #019FEA;width:auto;margin: 16px 8px;border-bottom: 1px solid #f5f5f5;margin: 5px;">
					
						<label class="check-one-label" style="display:inline-block;width:100%;height: 100%" for="userId02">
						<div style="margin:0 10px;float: left;">
							<div style="padding-bottom: 5px;">张三</div>
							<div style="padding-bottom: 5px;">13632332694</div>
						</div>
						<i class="unselected"></i>
						<input  type="checkbox" name="userId" id="userId02" onchange="userChange();" value="tenpay" style="display:none;">
					</label>
				</div>  
		
			</div>
		</div>
		<div class="form-group form-inline">
			<label for="gid" class="col-sm-2 control-label">用户角色</label>
			<div class="col-sm-10">
				<select class="form-control" id="gid" name="gid" style="width: 200px;">
					<%-- <tags:dict sql="select id , name ,'' from hui_group where " selectedValue="${upUser.groupId}" addBefore=",请选择" showPleaseSelect="false" /> --%>
					<option value="">请选择</option>
					<c:forEach items="${groups}" var="g">
					<option value="${g.id}">${g.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal">
				<span class="glyphicon glyphicon-off"></span> 关闭
			</button>
			<button type="button" class="btn btn-primary" onclick="invitation();">
				<span class="glyphicon glyphicon-save"></span> 保存
			</button>
		</div>
	</form>
	
	<script>
common.ctx =  '${ctx}';

$(function(){
	 dict.init();
	
	 initUser();
	 
	 $('#btn_user_search').click(function(){
		 var tel = /^(13|15|18)\d{9}$/;
		 var numberReg = new RegExp("^[0-9]*$");
		 var searchVal = $('#input_search_val').val();
		 if(searchVal===""){
			 $('#search_EQ_mobile').val("");
			 $('#search_LIKE_rname').val("");
		 }
		 $('#invitationSubForm')[0].reset();
		 if(tel.test(searchVal)){
			 $('#search_EQ_mobile').val(searchVal);
		 }else{
			 $('#search_LIKE_rname').val(searchVal);
		 }
		 initUser();
		 
	});
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});
	
});

function initUser(){
	common.ajaxjson({
		url  : '${ctx}/weixin/user/invitation/users/list',
		type : 'post',
		data : {
			search_EQ_mobile : $('#search_EQ_mobile').val(),
			search_LIKE_rname : $('#search_LIKE_rname').val(),
			search_EQ_userType : 'CLIENT',
			sort : 'zimu',
			order : 'asc'
		},
		success : function(res){
			var html = new Array();
			var list = res.object.rows;
			var a = 0;
			var h = 0;
			var o = 0;
			var v = 0;
			for(var i in list){
				var str =$("#temp_script_user_administrator").text();
				if(a===0&&list[i].zimu<='G'){
					str='<div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">A-G</div>'+str;
					a = 1;
				}else if(h===0&&list[i].zimu>'G'&&list[i].zimu<'O'){
					str='<div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">H-N</div>'+str;
					h = 1;
				}else if(o===0&&list[i].zimu>='O'&&list[i].zimu<'V'){
					str='<div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">O-U</div>'+str;
					o = 1;
				}else if(v===0&&list[i].zimu>='V'){
					str='<div style="background: #f5f5f5;font-size: 16px;font-weight: bold;padding: 10px;">V-Z</div>'+str;
					v = 1;
				}
				str = str.replace('{{item.id}}',list[i].id).replace('{{item.rname}}',list[i].rname).replace('{{item.mobile}}',list[i].mobile).replace('{{item.id}}',list[i].id).replace('{{item.id}}',list[i].id);
				html.push(str);
			}
			$('#div_list_parent').html(html.join(''));
		}
	});
}
function userChange(){
	var userIds = new Array();
	$("input[name='userId']:checkbox").each(function(i){
	    if($(this).attr("checked")) {
	    	$(this).parent().find("i").removeClass("unselected");
	    	$(this).parent().find("i").addClass("selected");
	    	$(this).parent().find("div").css("color","#019FEA");
	    	userIds.push($(this).val());
	   }else{
		   $(this).parent().find("i").removeClass("selected");
		   $(this).parent().find("i").addClass("unselected");
		   $(this).parent().find("div").css("color","");
	   }
	});
	$("#userIds").val(userIds.join(","));
}
function invitation(){
	var userIds = $("#userIds").val();
	var gid = $("#gid").val();
	var hotelId = $("#hotelId").val();
	var flag = $("#flag").val();
	var hgId = $("#hgId").val();
	var type = $("#type").val();
	if(gid+""===""){
		swal('请先选择角色！','error');
		return;
	}
	if(userIds+""===""){
		swal('请先选择邀请用户！','error');
		return;
	}
	var url = '${ctx}/weixin/user/invitation/send';
	$.post(url,{userIds:userIds,gid:gid,hotelId:hotelId,hgId:hgId,type:type},function(res){
		if(res.statusCode=='200'){
			swal('发送邀请成功！','success');
			$('#close_btn').click();
			if(flag==''){
				invitation_search();
			}else{
			}
		}else{
			swal(res.message,'error');
		}
	},"JSON");
}
</script>

<script id="temp_script_user_administrator" type="text/html">
	<div class="user-list" style="">
			<label style="display:inline-block;width:100%;height: 100%" for="userId{{item.id}}">
				<div class="pl">
					<div style="padding-bottom: 5px;">{{item.rname}}</div>
					<div style="padding-bottom: 5px;">{{item.mobile}}</div>
				</div>
				<i class="unselected"></i>
				<input type="checkbox" name="userId" id="userId{{item.id}}" onchange="userChange();" value="{{item.id}}" style="display:none;">
			</label>
		<div style="clear:both"></div>
	</div>
</script>
</div>

