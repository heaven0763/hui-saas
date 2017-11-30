<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>申请记录</h3>
		<form class="form-inline" id="record_searchForm">
		   <div class="form-group">
				<input type="hidden" id="userId" value='${aUs.getCurrentUserId()}' name="userId"/>
				<%--
				<br>
		   		
				<label for="city">所属城市</label>
		   		<select class="form-control"  id="province" name="search_EQ_h.province" refval="value" reftext="text" 
					refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaclear();">
					<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' "  showPleaseSelect="false" addBefore=",全部" />
				</select>
				<select class="form-control"  id="city" name="search_EQ_h.city" refval="value" reftext="text" 
		     		refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#district" onchange="areaclear('city');">
		     		<option value="">全部</option>
				</select>
				<select class="form-control"  id="district" name="search_EQ_h.district" refval="value" reftext="text" 
					refurl="${ctx}/framework/dictionary/trslCombox?sql=SELECT id,district as name FROM hui_district where region_id in (select parent_id from hui_region where id={value})" refdata="region_id=:{value}" ref="#tradeArea">
					<option value="">全部</option>
				</select> 
		   		
				<label for="tradeArea">所属商圈</label>
				<select class="form-control"  id="tradeArea" name="search_EQ_h.trade_area" >
					<option value="">全部</option>
				</select> 
			  <button type="button" class="btn btn-primary" onclick="hotel_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>--%>
		  </div> 
		</form>
		<br>
	<table id="applyRecord_table" class="table-condensed" data-toggle="table" data-height="660" data-query-params="record_queryParams"
		data-pagination="true" data-url="${ctx}/base/hotel/record/recordList" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="hotelFaceImg">场地封面图片</th> -->
				<!-- <th data-field="pName">集团名称</th> -->
				<th data-field="hotelName">团队名称</th>
				<th data-field="applyDate">申请时间</th>
				<th data-field="checkDate">审核时间</th>
				<th data-field="state" data-formatter="fm_record_state">审核状态</th>
				<th data-formatter="fm_record_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_record_operate(value,row, index){
	if(row.state==0){
		return '<a href="javascript:;" onclick="cancle_apply_fun('+row.recordId+')" class="btn btn-primary btn-sm" title="撤销申请">撤销申请</a>'
	}
}

function fm_record_state(value,row, index){
	if(row.state=="0"){
		return '<span class="label label-danger">待审核</span>';
	}else if(row.state=="1"){
		return '<span class="label label-success">已加入</span>';
	}else if(row.state=="2"){
		return '<span class="label label-default">已撤回申请</span>';
	}else if(row.state=="3"){
		return '<span class="label label-default">已撤回申请</span>';
	}
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
   	     			record_search();
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

$(function(){
    common.pms.init();
	console.log(common.pms.permissions);
    $("#applyRecord_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	
});
function record_queryParams(params){
	return $.extend({},params,util.serializeObject($('#record_searchForm')));
}

function record_search(){
	$("#applyRecord_table").bootstrapTable("refresh");
}

</script>