<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>留言管理</h3>
	<hr>
	<%-- <div class="form-group">
		<a href="${ctx}/base/uesr/message/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div> --%>
	<form class="form-inline" id="message_searchForm">
	  <div class="form-group">
	  		<c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelid" name="search_EQ_m.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<c:if test="${aUs.getCurrentUserType() eq 'PARTNER' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelid" name="search_EQ_m.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel WHERE company_id = ${aUs.getCurrentUserCompanyId() }"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<c:if test="${aUs.getHotelUserType() eq 'GROUP' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelid" name="search_EQ_m.hotel_id" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid = ${aUs.getCurrentUserhotelPId() }"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			<label for="msgType">留言类型</label>
	   		<select class="form-control"  id="msgType" name="search_EQ_m.msg_type">
				<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='MSGTYPE' "  showPleaseSelect="false" addBefore=",全部"/>
			</select>
			<label for="userName">会员账号</label>
	   		<input type="text" class="form-control" id="userName" name="search_LIKE_m.user_name" placeholder="模糊查询会员账号">
			<label for="msg">正文</label>
	   		<input type="text" class="form-control" id="msg" name="search_LIKE_m.msg" placeholder="模糊查询正文">
	   		<br>
	   		<br>
			<label for="msgDate">留言日期</label>
	   		<input type="text" class="form-control layer-date laydate-icon" id="smsgDate" name="search_GTE_m.msg_date" placeholder="请输入留言日期">
	   		~
	   		<input type="text" class="form-control layer-date laydate-icon" id="emsgDate" name="search_LTE_m.msg_date" placeholder="请输入留言日期">
		  <button type="button" class="btn btn-primary" onclick="message_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div>
	</form>
	<br>
	<table id="message_table" data-toggle="table" data-height="600" data-query-params="message_queryParams"
	data-pagination="true" data-url="${ctx}/base/uesr/message/list" data-data-type="json">
	    <thead>
	        <tr>
	        	<th data-field="hName">场地名称</th>
				<th data-field="msgType">留言类型</th>
				<th data-field="userName">会员账号</th>
				<th data-field="msg" data-formatter="fm_msg_content">留言</th>
				<th data-field="msgDate" data-formatter="fm_msg_msgDate">留言日期</th>
				<th data-formatter="fm_message_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_message_operate(value,row, index){
	return '<button qx="message:delete" type="button" onclick="message_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>'
	+'&nbsp;&nbsp;<button type="button" href="${ctx}/base/uesr/message/detail/'+row.id+'" target="dialog" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-eye-open"> </span> 详情</button>';
}

function message_del_fun(id){
	swal({
        title: "您确定要删除这条信息吗",
        text: "删除后将无法恢复，请谨慎操作！",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "删除",
        cancelButtonText: "取消",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post('${ctx}/base/uesr/message/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			message_search();
   	     		}else{
   	     			swal(res.message, "error");
   	     		}
   	     		parent.hide();
   	     	}, 'json');
		} else {
			swal("已取消", "您取消了删除操作！", "error")
		}
    });
}

function fm_msg_msgType(value,row, index){
	if(value=="FEEDBACK"){
		return "反馈";
	}else if(value=="ORDERCOMPLAINT"){
		return "订单投诉";
	}else if(value=="MESSAGE"){
		return "留言";
	}else if(value=="COMMENT"){
		return "评论";
	}else if(value=="CONSULT"){
		return "咨询";
	}else{
		return "其他";
	}
}
function fm_msg_content(value,row, index){
	return '<div style="white-space:nowrap;text-overflow:ellipsis;word-break:break-all;overflow:hidden;width:400px;">'+value+'</div>';
}
function fm_msg_msgDate(value,row, index){
	return new Date(value).formatDate("yyyy-MM-dd");
}

$(function(){
	common.pms.init();
	var smsgDate={elem:"#smsgDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
    laydate(smsgDate);
    var emsgDate={elem:"#emsgDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
    laydate(emsgDate);
    $("#message_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
    
    $(".selectpicker").selectpicker();
});
function message_queryParams(params){
	return $.extend({},params,util.serializeObject($('#message_searchForm')));
}

function message_search(){
	$("#message_table").bootstrapTable("refresh");
}

</script>