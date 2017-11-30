<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<style>
		.ts{border-left:none;border-bottom:1px solid #ffffff;padding:8px;}
	</style>
	<!-- <h3>档期管理</h3>
	<hr> 
	<div class="form-group">
		<a qx="schedulebooking:add" href="${ctx}/base/hotel/schedule/create" target="dialog" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
		<a qx="schedulebooking:add" href="${ctx}/base/hotel/schedule/batch/update" target="dialog" class="btn btn-primary" title="批量添加"><span class="glyphicon glyphicon-plus"> </span> 批量添加</a>
	</div>-->
	<br/>
	<form class="form-inline" id="hotelSchedule_searchForm">
	   <div class="form-group" style="padding: 0 10px">
					
			<c:if test="${aUs.getHotelUserType() eq 'HUI' }">
				<label for="city">城市</label>
				<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="area" name="search_EQ_city"  >
		     		<tags:dict sql="SELECT id id,region_name name FROM hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select>
		   		<label for="hotelId">场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" id="sch_hotelId" name="search_EQ_hotelId"  style="width: 180px;" onchange="getHallList();">
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="false" addBefore=",全部"/>
				</select> 
				<label for="splaceId">会场</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="splaceId" name="search_EQ_placeId" refval="value" reftext="text"  style="width: 180px;">
		   			<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL'" showPleaseSelect="false" addBefore=",全部"/>
				</select>
			</c:if>
			<c:if test="${aUs.getHotelUserType() eq 'GROUP' }">
				<label for="city">城市</label>
				<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10"   id="area" name="search_EQ_city"  >
		     		<tags:dict sql="SELECT id id,region_name name FROM hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
				</select>
		   		<label for="hotelId">场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10" id="sch_hotelId" name="search_EQ_hotelId"  style="width: 180px;" onchange="getHallList();">
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid=${aUs.getCurrentUserhotelPId() }"  showPleaseSelect="false" addBefore=",全部"/>
				</select> 
				<label for="splaceId">会场</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="200px" data-size="10"   id="splaceId" name="search_EQ_placeId" data-none-selected-text="请选择..."  style="width: 180px;">
				</select>
			</c:if>
			<c:if test="${aUs.getHotelUserType() eq 'HOTEL' }">
			
				<label for="splaceId">会场</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="splaceId" name="search_EQ_placeId" refval="value" reftext="text"  style="width: 180px;">
		   			<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL' and hotel_id=${aUs.getCurrentUserHotelId()}" showPleaseSelect="false" addBefore=",全部"/>
				</select>
			</c:if>
			
			<br>
			<br> 
			<label for="placeDate">场地日期</label>
	   		<input type="text" class="form-control layer-date laydate-icon" id="splaceDate" name="search_GTE_placeDate" placeholder="请输入场地日期" value="${_currDayOfMonth }">
	   		至
	   		<input type="text" class="form-control layer-date laydate-icon" id="eplaceDate" name="search_LTE_placeDate" placeholder="请输入场地日期" value="${_currDayOfMonth }">
	   		 <label for="state">场地状态</label>
	   		 <select class="form-control selectpicker" name="search_EQ_state"  data-width="auto" data-size="10">
	   		 	<option value="">请选择</option>
				<option value="0">未预定</option>
				<option value="1">有预定</option>
				<option value="2">已锁定</option>
			</select>
		  <button type="button" class="btn btn-primary" onclick="hotelSchedule_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	  </div> 
	</form>
	<br>
	<table id="hotelSchedule_table" data-toggle="table" data-height="600" data-query-params="hotelSchedule_queryParams"
		data-pagination="true" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="hotelName">所属场地</th> -->
				<!-- <th data-field="placeType">场地类型</th> -->
				<!-- <th data-field="placeId">场地编号</th> -->
				<th data-field="placeName">场地名称</th>
				<th data-field="placeDate">场地日期</th>
				<th data-field="placeSchedule">场地档期</th>
				<th data-field="state" data-formatter="fm_hotelSchedule_state">档期状态</th>
				<th data-formatter="fm_hotelSchedule_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function getHallList() {//获取下拉会场列表
	var hotelId = $("#sch_hotelId").val();
	var url ='${ctx}/framework/dictionary/trslCombox?sql=select id ,place_name name  from hui_hotel_place where place_type=\'HALL\' and hotel_id='+hotelId;
    $.ajax({
        url: url,
        type: "get",
        dataType: "json",
        success: function (data) {
        	var options = [];
        	options.push("<option value=''>请选择</option>");
            $.each(data, function (i) {
            	options.push("<option value=" + data[i].value + ">" + data[i].text + "</option>");
            });
            $('#splaceId').html(options.join(''));
            $('#splaceId').selectpicker('refresh');
        },
        error: function (data) {
            //alert("查询学校失败" + data);
        }
    })

}

/* function fm_hotelSchedule_operate(value,row, index){
	return '<a qx="schedulebooking:update" href="${ctx}/base/hotel/schedule/update/'+row.id+'" target="dialog" class="btn btn-primary btn-sm" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button qx="schedulebooking:delete" type="button" onclick="hotelSchedule_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
} */

function fm_hotelSchedule_operate(value,row, index){
	return '<a style="cursor: pointer;" onclick="hotelSchedule_display(this,\''+row.placeId+'\',\''+row.placeDate+'\')"><img src="${ctx}/public/default/img/down.png"></a>';
}
function hotelSchedule_display(self,placeId,placeDate){
	var $this = $(self); 
	
	$.post("${ctx}/base/hotel/schedule/detail/list",{placeId:placeId,placeDate:placeDate},function(res){
		var shtml = '<tr data-index="0"><td style="padding:0;background-color: #ddd;" colspan="5"><table class="schedule-detail">';
		if(res.statusCode==="200"){
			for(var k=0,len=res.object.length;k<len;k++){
				var obj = res.object[k];
				console.log(obj.id);
				var badge = "";
				if(obj.state=="0"){
					badge = '<span class="badge badge-primary" style="background-color:#019ce5;color:#ffffff;">未预定</span>';
				}else if(obj.state=="1"){
					badge = '<span class="badge badge-info" style="background-color:#f8ac59;color:#ffffff;">有预定</span>';
				}else{
					badge = '<span class="badge badge-success" style="background-color:#c8c8c8;color:#ffffff;">已锁定</span>';
				}
				if(k==0){
					shtml += '<tr><td class="ts" style="width:200px;">'+obj.placeName+'</td><td class="ts" style="width:263px;">'+obj.placeDate+'</td><td class="ts" style="width:202px;">'+obj.placeSchedule+'</td><td class="ts" style="width:202px;">'+badge+'</td><td class="ts" style="width:126px;"><a class="toggle" style="cursor: pointer;"><img src="${ctx}/public/default/img/up.png"></a></td></tr>';
				}else{
					shtml += '<tr><td class="ts">'+obj.placeName+'</td><td class="ts">'+obj.placeDate+'</td><td class="ts">'+obj.placeSchedule+'</td><td class="ts">'+badge+'</td><td class="ts"></td></tr>';
				}
			}
			
		}else{
			shtml += '<tr><td colspan="4" class="ts">没有档期</td><td class="ts" style="width:126px;"><a class="toggle" style="cursor: pointer;"><img src="${ctx}/public/default/img/up.png"></a></td></tr>';
		}
		shtml += '</table></td></tr>';
		var $shtml = $(shtml);
		var $parent =$this.parent().parent();
		$shtml.delegate('.toggle','click',function(){
			$shtml.remove();
			$parent.show();
		});
		$parent.after($shtml);
		$parent.hide();
	},"json");
	
	/* shtml += '<tr><td class="ts">紫荆花</td><td class="ts">2017-10-11</td><td class="ts">中午</td><td class="ts"><span class="badge badge-primary" style="background-color:#019ce5;color:#ffffff;">未预定</span></td><td class="ts"></td></tr>';
	shtml += '<tr><td class="ts">紫荆花</td><td class="ts">2017-10-11</td><td class="ts">下午</td><td class="ts"><span class="badge badge-primary" style="background-color:#019ce5;color:#ffffff;">未预定</span></td><td class="ts"></td></tr>';
	shtml += '<tr><td class="ts">紫荆花</td><td class="ts">2017-10-11</td><td class="ts">晚上</td><td class="ts"><span class="badge badge-primary" style="background-color:#019ce5;color:#ffffff;">未预定</span></td><td class="ts"></td></tr>';
	 */
}
function fm_hotelSchedule_state(value,row, index){
	if(row.state=="2" && row.num>=4){
		return '<span class="badge badge-success" style="background-color:#c8c8c8;color:#ffffff;">已锁定</span>';
	}else if(row.state=="2" && row.num<4){
		return '<span class="badge badge-info" style="background-color:#f8ac59;color:#ffffff;">有预定</span>';
	}else{
		return '<span class="badge badge-primary" style="background-color:#019ce5;color:#ffffff;">未预定</span>';
	}
}
function hotelSchedule_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/schedule/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
   	     			hotelSchedule_search();
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
	 var splaceDate={elem:"#splaceDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	 var eplaceDate={elem:"#eplaceDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	 laydate(splaceDate); 
	 laydate(eplaceDate);
	 
	 $("#hotelSchedule_table").bootstrapTable();
	 $('.selectpicker').selectpicker();
	 
	 $('#area').on('changed.bs.select', function (event, clickedIndex, newValue, oldValue) {
			var area = $('#area').val();
			
			var url ='${ctx}/framework/dictionary/trslCombox?sql=SELECT id,hotel_name as name FROM hui_hotel where 1=1';
			if(area){
				url +=' and city='+area;
			}

			var type= '${aUs.getHotelUserType()}';
			if(type==="GROUP"){
				var pid = "${aUs.getCurrentUserhotelPId() }";
				if(pid){
					url +=' and pid='+pid;
				}
			}
		    $.ajax({
		        url: url,
		        type: "get",
		        dataType: "json",
		        success: function (data) {
		        	var options = [];
		        	options.push("<option value=''>请选择</option>");
		            $.each(data, function (i) {
		            	options.push("<option value=" + data[i].value + ">" + data[i].text + "</option>");
		            });
		            $('#sch_hotelId').html(options.join(''));
		            $('#sch_hotelId').selectpicker('refresh');
		        },
		        error: function (data) {
		            //alert("查询学校失败" + data);
		        }
		    })

	});
});
function hotelSchedule_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotelSchedule_searchForm')));
}

function hotelSchedule_search(){
	var splaceDate = $("#splaceDate").val();
	var eplaceDate = $("#eplaceDate").val();
	if(splaceDate==""||splaceDate==null){
		swal("请先选择场地日期",'error');
		return;
	}
	if(eplaceDate==""||eplaceDate==null){
		swal("请先选择场地日期",'error');
		return;
	} 
	$("#hotelSchedule_table").bootstrapTable("refresh",{url:"${ctx}/base/hotel/schedule/list"});
}

</script>