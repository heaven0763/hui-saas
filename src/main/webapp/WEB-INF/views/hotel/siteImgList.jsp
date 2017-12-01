<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>图库管理</h3>
	<hr>
<%-- 	<div class="form-group">
		<a qx="hotelimg:add" href="javascript:loadHotelContent(this,'${ctx}/base/hotel/img/create','');" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div> --%>
	<form class="form-inline" id="siteImg_searchForm">
	  <div class="form-group">
			<%-- <c:if test="${aUs.getCurrentUserType() eq 'HUI' }">
	   		<label for="hotelId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="search_EQ_hotelId" >
				<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
			</c:if>
			<c:if test="${aUs.getCurrentUserType() eq 'PARTNER' }">
				<label for="hotelId">所属场地</label>
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  name="search_EQ_hotelId" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where company_id = ${aUs.getCurrentUserCompanyId()}"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if> --%>
			<label for="siteType">场地类型	</label>
			<select class="form-control" id="siteType" name="search_EQ_s.type" style="width: 180px;" onchange="getHallList();">
				<option value="">全部</option>
				<option value="HOTEL">场地环境图</option>
				<option value="HALL">会场</option>
				<option value="ROOM">客房</option>
			</select>
			<label for="siteId">所属场地</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" id="siteId" name="search_EQ_s.id" style="width: 180px;t">
	   			<tags:dict sql="SELECT id,place_name as name FROM hui_hotel_place where hotel_id=${mhotel.id}" showPleaseSelect="false" addBefore=",全部"/>
			</select> 
			<%-- <label for="picType">图片类型</label>
	   		<select class="form-control" name="search_EQ_picType"  style="width: 180px;">
				<tags:dict sql="SELECT val id, name FROM hui_category where kind='PICTYPE'"  showPleaseSelect="false" addBefore=",全部"  />
			</select> --%>
	  </div>
	  <button type="button" class="btn btn-primary" onclick="siteImg_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	</form>
	<br>
	<table id="siteImg_table" data-toggle="table" data-height="660" data-query-params="siteImg_queryParams"
		data-pagination="true" data-url="${ctx}/base/hotel/img/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="hotelId">所属场地</th> -->
				<th data-field="type" data-formatter="fm_siteImg_siteType">场地类型</th>
				<th data-field="name" data-formatter="fm_siteImg_name">场地名称</th>
				<th data-field="ptypes">图片类型</th>
				<!-- <th data-field="originalImg">原图</th> -->
				<th data-field="imgnum" data-align="right">图片数量</th>
				<th data-field="utime">上传时间</th>
				<!-- <th data-field="timgs" data-formatter="fm_siteImg_thumbImg">图片数量</th> -->
				<!-- <th data-field="sortOrder">排序编号</th>
				<th data-field="origin">来源</th>-->
				<th data-formatter="fm_siteImg_operate">操作</th>  
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_siteImg_name(value,row, index){
	
	return '<a href="javascript:;" onclick="loadHotelContent(this,\'${ctx}/base/hotel/img/create?id='+row.id+'&type='+row.type+'\',\'\');">'+value+'</a>';
}
function fm_siteImg_operate(value,row, index){
	return '<a qx="hotelimg:update"  href="javascript:;" onclick="loadHotelContent(this,\'${ctx}/base/hotel/img/create?id='+row.id+'&type='+row.type+'\',\'\');"  class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-picture"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button  qx="hotelimg:delete" type="button" onclick="siteImg_del_fun(\''+row.id+'\',\''+row.type+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function fm_siteImg_siteType(value,row, index){
	if(value=="HOTEL"){
		return "场地环境图";
	}else if(value=="HALL"){
		return "会场";
	}else if(value=="ROOM"){
		return "客房";
	}else{
		return "其他";
	}
}
function fm_siteImg_picType(value,row, index){
	if(value=="COVER"){
		return "封面图";
	}else if(value=="PANORAMA"){
		return "全景图";
	}else if(value=="BASEPIC"){
		return "基础图库";
	}else if(value=="EXTPIC"){
		return "扩展图库";
	}else if(value=="DIMENSION"){
		return "场地尺寸图";
	}else{
		return "其他";
	}
}

function fm_siteImg_thumbImg(value,row, index){
	var html = [];
	if(row.timgs){
		var imgsArr = row.timgs.split(',');
		var len = imgsArr.length;
		return len;
		/* 
		for(var i=0;i<len-1;i++){
			html.push('<img alt="image" src="'+imgsArr[i]+'" style="width: 80px;height:80px;cursor: pointer;margin:5px;" onerror="nofind()" onclick="openSingleImg(\''+imgsArr[i]+'\')" title="点击查看大图" />')
		} */
	}
	return 0;
}
function openSingleImg(url){
	$.fancybox.open(url);
}

function confirmFun(title,text,ctype,url,data){
	swal({
        title: title,
        text: text,
        type: "warning",
        showCancelButton: true,
        cancelButtonText: "取消",
        confirmButtonColor: "#DD6B55",
        confirmButtonText: ctype,
        closeOnConfirm: false,
        showLoaderOnConfirm: true
    }, function (isConfirm)  {
    	if (isConfirm) {
    		parent.show();
   	     	$.post(url, data, function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message,"success");
   	     			siteImg_search();
   	     		}else{
   	     			swal(res.message, "error");
   	     		}
   	     		parent.hide();
   	     	}, 'json');
		} else {
			swal("已取消", "您取消了"+ctype+"操作！", "error")
		}
    });
	
}
function siteImg_del_fun(id,type){
	confirmFun("您确定要删除所有图片吗","删除后将无法恢复，请谨慎操作！","删除",'${ctx}/base/hotel/img/batch/delete/'+id+'/'+type,"");
}
function siteImg_cover_fun(id){
	confirmFun("您确定要把这张图设为封面吗？","","设为封面",'${ctx}/base/hotel/img/cover/'+id,"");
}
function siteImg_queryParams(params){
	return $.extend({},params,util.serializeObject($('#siteImg_searchForm')));
}

function siteImg_search(){
	$("#siteImg_table").bootstrapTable("refresh");
}
$(function(){
	$("#siteImg_table").bootstrapTable({onLoadSuccess: function(data){  //加载成功时执行  
    	common.pms.init();
    }});	
	
	$('.selectpicker').selectpicker();
});

function getHallList() {//获取下拉会场列表
	var type = $("#siteType").val();
	var url ='${ctx}/framework/dictionary/trslCombox?sql=select id ,name from hui_site_view where  hotel_id=${mhotel.id}';
	if(type){
		url = url +" and type='"+type+"'";
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
            $('#siteId').html(options.join(''));
            $('#siteId').selectpicker('refresh');
        },
        error: function (data) {
        }
    })

}
</script>