<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>

<div class="wrapper wrapper-content">
	<h3>档期查阅</h3>
	<hr>
	<form class="form-inline" id="scheduleBooking_searchForm">
  	<div class="form-group">
  		<!-- <span class="label label-success" style="font-size: 16px;padding: 5px 10px;">会掌柜</span>
  		<span class="label label-warning" style="font-size: 16px;padding: 5px;">场地</span> -->
  		<!-- <lable class="btn btn-primary"></span> -->
  		<!-- <label class="label label-warning label-large">场地自有客户</label> -->
  		<!-- <span class="btn btn-success">拓源公关</span> -->
  		
  		 <c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
	  		<label for="city">所属城市</label>
	   		<select class="form-control"  id="province" name="search_EQ_hotel.province" refval="value" reftext="text" 
				refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaclear();">
				<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' "  showPleaseSelect="false" addBefore=",全部" />
			</select>
			<select class="form-control"  id="city" name="search_EQ_hotel.city"  onchange="getschoolList();">
	     		<option value="">全部</option>
			</select>
	   		<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="search_EQ_h.hotel_id" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="true"/>
			</select> 
			<button type="button" class="btn btn-primary" onclick="scheduleBooking_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
		</c:if>
		<c:if test="${aUs.getCurrentUserType() eq 'PARTNER' }">
  			<label for="city">所属城市</label>
	   		<select class="form-control"  id="province" name="search_EQ_hotel.province" refval="value" reftext="text" 
				refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaclear();">
				<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' "  showPleaseSelect="false" addBefore=",全部" />
			</select>
			<select class="form-control"  id="city" name="search_EQ_hotel.city" refval="value" reftext="text" >
	     		<option value="">全部</option>
			</select>
			<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" id="hotelId" name="search_EQ_h.hotel_id" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}"  showPleaseSelect="true"/>
			</select> 
		  <button type="button" class="btn btn-primary" onclick="scheduleBooking_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
		</c:if>
		 <c:if test="${aUs.getHotelUserType() eq 'GROUP'}">
			<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelId" name="search_EQ_h.hotel_id" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid = ${aUs.getCurrentUserhotelPId()}"  showPleaseSelect="true" />
			</select> 
				<label for="placeId">会场名称</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="dsplaceId" name="search_EQ_h.id" refval="value" reftext="text"  style="width: 180px;">
	   		<%-- 	<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL' and hotel_id=${aUs.getCurrentUserHotelId()}" showPleaseSelect="false" addBefore=",全部"/>
			 --%></select>
			<button type="button" class="btn btn-primary" onclick="scheduleBooking_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
			 <!-- <button type="button" class="btn btn-primary" onclick="scheduleBooking_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button> -->
		 </c:if>
		  <c:if test="${aUs.getHotelUserType() eq 'HOTEL'}">
		  	<label for="placeId">会场名称</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="dsplaceId" name="search_EQ_h.id" refval="value" reftext="text"  style="width: 180px;">
	   			<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where place_type='HALL' and hotel_id=${aUs.getCurrentUserHotelId()}" showPleaseSelect="false" addBefore=",全部"/>
			</select>
			<button type="button" class="btn btn-primary" onclick="scheduleBooking_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
		  </c:if>
		  <button type="button" class="btn btn-primary" href="${ctx}/base/hotel/schedule/index" width="1000" target="dialog"><span class="glyphicon glyphicon-search"> </span> 快速查阅</button>
	  </div> 
	</form>
	<h3 id="hotelName">${aUs.getHotelUserType() eq 'HOTEL'?hotel.hotelName:"" }</h3><!--  -->
	<table id="scheduleBooking_table" data-toggle="table" data-height="660" data-query-params="scheduleBooking_queryParams"
	data-pagination="true"  data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="placeName">会场名称</th>
				<th data-field="description" data-formatter="fm_scheduleBooking_desc">场地概要</th>
				<th data-field="action" data-formatter="fm_scheduleBooking_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
$(function(){
	$("#scheduleBooking_table").bootstrapTable();
	 <c:if test="${aUs.getCurrentUserType() eq 'HOTEL'}">
	 scheduleBooking_search()
	 </c:if>
	$('.selectpicker').selectpicker();
	$('#hotelId').on('changed.bs.select', function (event, clickedIndex, newValue, oldValue) {
		var title = $('button[data-id="hotelId"]').find('.filter-option').text();
		console.log(title);
		if(title==='请选择...'){
			$("#hotelName").text('');
		}else{
			$("#hotelName").text(title);
			getMHallList();
		}
		
		
	});
});
function getMHallList(){//获取下拉会场列表
	var hotelId = $("#hotelId").val();
	if(hotelId){
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
	            $('#dsplaceId').html(options.join(''));
	            $('#dsplaceId').selectpicker('refresh');
	        },
	        error: function (data) {
	            //alert("查询学校失败" + data);
	        }
	    })
	}else{
		var options = [];
		 $('#dsplaceId').html(options.join(''));
         $('#dsplaceId').selectpicker('refresh');
	}
	
	scheduleBooking_search();
}
function getschoolList() {//获取下拉学校列表
	var city = $("#city").val();
	var url ='${ctx}/framework/dictionary/trslCombox?sql=SELECT id,hotel_name as name FROM hui_hotel where city='+city;
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
            $('#hotelId').html(options.join(''));
            $('#hotelId').selectpicker('refresh');
        },
        error: function (data) {
            //alert("查询学校失败" + data);
        }
    });            

}
function scheduleBooking_queryParams(params){
	return $.extend({},params,util.serializeObject($('#scheduleBooking_searchForm')));
}
function scheduleBooking_search(){
	var hotelId = $("#hotelId").val();
	 <c:if test="${aUs.getCurrentUserType() eq 'HUI'}">
		if(hotelId==""||hotelId==null){
			swal("请先选择场地",'error');
			return;
		}
	</c:if>
	var url="${ctx}/base/hotel/hall/list";
	$("#scheduleBooking_table").bootstrapTable("refresh",{url:url});
	
}
function fm_scheduleBooking_state(value,row, index){
	var state = "";
	if(value==='1'){
		state = "已预订";
	}else if(value==='2'){
		state = "已交订金";
	}else{
		state = "未预订";
	}
	var htm = '';
	if(row.clientId===0 || row.clientId==null){
		htm = '<span class="label label-warning">'+state+'</span>';
	}else if(row.clientId===1){
		htm = '<span class="label label-success">'+state+'</span>';
	}else if(row.clientId>1){
		htm = '<span class="label label-primary">'+state+'</span>';
	}else{
		htm = '<span class="label label-success">'+state+'</span>';
	}
	return htm;
}
function fm_scheduleBooking_operate(value,row, index){
	var title = "${aUs.getCurrentUserType()}" == "HOTEL"?"档期查订":"档期查阅";
	return '<a href="${ctx}/weixin/schedulebooking/place/detail?placeId='+row.id+'" target="dialog" height="640" class="btn btn-primary" title="'+title+'"><span class="glyphicon glyphicon-pencil"> </span> '+title+'</a>';
}
function fm_scheduleBooking_desc(value,row, index){
	var html = '<div class="col-md-12">面积：'+row.hallArea+'m²&nbsp;&nbsp;容纳人数：'+row.peopleNum+'人&nbsp;&nbsp;层高：'+row.height+'m&nbsp;&nbsp;楼层：'+row.floor+'F&nbsp;&nbsp;立柱：'+(row.pillar ===0?'无柱':row.pillar)+'</div>';
	return html;
}
 
</script>