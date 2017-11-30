<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>加入团队</h3>
	<form class="form-inline" id="hotel_searchForm">
		  <div class="form-group">
		       <br>
		      <label for="hotelName">团队名称</label>
		      <input type="text" class="form-control" id="hotelName" name="hotelName" placeholder="请输入团队名称">
		   	  <input type="hidden" id="referer" value='0' name="referer"/>
				
			  <button type="button" class="btn btn-primary" onclick="hotel_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
		  </div>
		</form>
		<br>
	<table id="hotel_table" class="table-condensed" data-toggle="table" data-height="660" data-query-params="hotel_queryParams"
		data-pagination="true" data-url="" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="pName">集团名称</th> -->
				<th data-field="name">团队名称</th>
				<th data-field="desction" data-formatter="fm_hotel_ddff">团队介绍</th>
				<th data-formatter="fm_hotel_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_hotel_operate(value,row, index){
	console.log('${aUs.getCurrentUserType()}');
	/* if(row.hotelName=="会掌柜"){
		//会掌柜 特殊处理
		if(row.state=="1"&&'${aUs.getCurrentUserType()}'=="CLIENT"){
			return '<a href="javascript:;" onclick="cancle_apply_fun('+row.id+')" class="label label-danger" title="撤销">撤销</a>'
		}else if(row.applyState=="1"){
			return '<span class="btn-success btn-sm" title="已加入">已加入</span>'
		}else if('${aUs.getCurrentUserType()}'=="CLIENT"){
			return '<a href="javascript:;" onclick="hotel_del_fun('+row.id+',\''+row.type+'\')" class="btn btn-primary btn-sm" title="申请加入">申请加入</a>'
		}
	}else{ */
		console.log(row.applyState=='1'&&row.userId=='${aUs.getCurrentUserId()}'&&'${aUs.getCurrentUserType()}'=="CLIENT");
		if(row.joinState=='1'&&row.userId=='${aUs.getCurrentUserId()}'){
			return '<span class="btn-success btn-sm" title="已加入">已加入</span>'
		}else if(row.applyState=='1'&&row.userId=='${aUs.getCurrentUserId()}'&&'${aUs.getCurrentUserType()}'=="CLIENT"){
			return '<a href="javascript:;" onclick="cancle_apply_fun('+row.recordId+')" class="label label-danger" title="撤销">撤销</a>'
		}else if(row.applyState=='0'&&'${aUs.getCurrentUserType()}'=="CLIENT"){
			return '<a href="javascript:;" onclick="hotel_del_fun('+row.id+',\''+row.type+'\')" class="btn btn-primary btn-sm" title="申请加入">申请加入</a>'
		}else{
			return "";
		}
	//}
	
}
function fm_hotel_ddff(value,row, index){
	if(value){
		return '<div style="white-space:nowrap;text-overflow:ellipsis;word-break:break-all;overflow:hidden;width:500px;">'+value+'</div>';
	}else{
		return '';
	}
}
function hotel_del_fun(id,type){
	swal({
        title: "您确定要申请加入吗",
        text: "稍后会有人员进行审核！",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post('${ctx}/base/hotel/record/saveRecord', {hotelId:id,userId:'${aUs.getCurrentUserId()}',type:type}, function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您的申请已提交！", "success");
   	     			hotel_search();
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

function cancle_apply_fun(id){
	swal({
        title: "您确定要撤销该申请吗",
        text: "请谨慎操作！",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post('${ctx}/base/hotel/record/cancle', {id:id}, function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已成功撤销申请！", "success");
   	     			hotel_search();
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

function fm_hotel_region(value,row, index){
	var str = "";
	if(row.provinceText){
		str+=row.provinceText;
	}
	if(row.cityText){
		str+=row.cityText;
	}
	if(row.districtText){
		str+=row.districtText;
	}
	return str;
}
$(function(){
    common.pms.init();
	console.log(common.pms.permissions);
    $("#hotel_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	
});
function hotel_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotel_searchForm')));
}

function hotel_search(){
	var hotelName = $("#hotelName").val();
	if(!hotelName){
		swal("提示", "请输入团队名称再查询！", "error")
		return;
	}
	$("#hotel_table").bootstrapTable("refresh",{url:'${ctx}/base/hotel/applyHotelList'});
}

</script>