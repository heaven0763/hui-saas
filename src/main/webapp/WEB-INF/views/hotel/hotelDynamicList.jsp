<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!-- Add mousewheel plugin (this is optional) -->

<div class="wrapper wrapper-content">
	<h3>动态管理</h3>
	<hr>
	<div class="form-group">
		<a qx="dynamic:add" href="javascript:loadContent(this,'${ctx}/base/hotel/dynamic/create','');" class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="hotelDynamic_searchForm">
	  	<div class="form-group" style="padding: 5px 0;">
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
		   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"  id="hotelid" name="search_EQ_m.hotelid" >
					<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel where pid = ${aUs.getCurrentUserhotelPId() }"  showPleaseSelect="fasle" addBefore=",全部"/>
				</select> 
			</c:if>
			
			<label for="party">活动执行公司</label>
	   		<input type="text" class="form-control" id="party" name="search_LIKE_m.party" placeholder="请输入活动执行公司">
	   		<label for="pcontent">动态内容</label>
	   		<input type="text" class="form-control" id="pcontent" name="search_LIKE_m.pcontent" placeholder="请输入动态内容">
   		</div>
	   	<div class="form-group" style="padding: 5px 0;">	
			<label for="createDate">发布日期</label>
	   		<input type="text" class="form-control layer-date laydate-icon" id="screateDate" name="search_GTE_m.create_date" placeholder="请输入发布日期">
	   		~
	   		<input type="text" class="form-control layer-date laydate-icon" id="ecreateDate" name="search_LTE_m.create_date" placeholder="请输入发布日期">
	   		
	   		
	   		 <button type="button" class="btn btn-primary" onclick="hotelDynamic_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
	 	 </div>
	</form>
 	<br>
	<%-- <table id="hotelDynamic_table" data-toggle="table" data-height="660" data-query-params="hotelDynamic_queryParams"
	data-pagination="true" data-url="${ctx}/base/hotel/dynamic/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="hoteLogo">场地照片</th> -->
				<!-- <th data-field="hotelName">场地名称</th> -->
				<th data-field="party">活动</th>
				<th data-field="site">场地</th>
				<th data-field="partyTime">时间</th>
				<th data-field="area">地点</th>
				<th data-field="budget">参考预算</th>
				<th data-field="pcontent">动态内容</th>
				<!-- <th data-field="imgs">动态图片</th> -->
				<th data-field="createDate">发布日期</th>
				<th data-formatter="fm_hotelDynamic_operate">操作</th> 
	        </tr>
	    </thead>
	</table> --%>
	<div class="row">
		<div id="dynamic" class="col-sm-12" style="min-height: 360px;">
			
		</div>
	</div>
	<div class="row" style="border-top: 1px solid #f5f5f5;">
		<div class="col-sm-12" style="text-align: right;">
			<div class="pull-left pagination-detail" style="margin: 20px 0;">
				<span class="pagination-info">显示第 1 到第 10 条记录，总共 121 条记录</span>
				<span class="page-list">
					每页显示 
					<span class="btn-group dropup">
						<button type="button" class="btn btn-default  dropdown-toggle" data-toggle="dropdown">
							<span class="page-size">10</span> <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li class="active" page-size="10"><a href="javascript:void(0)">10</a></li>
							<li page-size="25"><a href="javascript:void(0)">25</a></li>
							<li page-size="50"><a href="javascript:void(0)">50</a></li>
							<li page-size="100"><a href="javascript:void(0)">100</a></li>
						</ul>
					</span> 
					条记录
				</span>
			</div>
			<ul class="pagination"></ul> 
		</div>
	</div>
</div>

<script>
var dynamic_page = 1;
var dynamic_crt_page = 1;
var dynamic_rows = 10;
var fancyboxArr = [];
$(function(){
    var screateDate={elem:"#screateDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
    laydate(screateDate);
    var ecreateDate={elem:"#ecreateDate",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
    laydate(ecreateDate);
    common.pms.init();
    //$("#hotelDynamic_table").bootstrapTable({onLoadSuccess:function(){common.pms.init();}});
    $('.selectpicker').selectpicker();
    
    template.config('escape', false);
	template.helper('fmimgs', function(item){
		var html = [];
		if(item.imgs){
			var imgsArr = item.imgs.split(',');
			var thmimgs = item.thmimgs || item.imgs;
			var thmimgsArr = thmimgs.split(',');
			fancyboxArr.push('fancybox'+item.id);
			for(var i=0,len=imgsArr.length;i<len;i++){
				html.push('<a class="fancybox'+item.id+'" href="'+imgsArr[i]+'" data-fancybox-group="gallery" title="" style="display:inline-block;cursor: pointer;"><img style="width: 120px;height: 120px;margin: 5px;" src="'+thmimgsArr[i]+'"  onerror="nofindImg(this);" /></a>')
			}
		}
		return html.join('');
	});
	
	hotelDynamic_AjaxPaginator($(".pagination"));
    
    $(".pagination-detail ul li").click(function(){
		dynamic_rows = $(this).attr("page-size");
		hotelDynamic_AjaxPaginator($(".pagination"));
	});
});
function fm_hotelDynamic_operate(value,row, index){
	return '<button  qx="dynamic:delete" type="button" onclick="hotelDynamic_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}

function hotelDynamic_del_fun(id){
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
  	     	$.post('${ctx}/base/hotel/dynamic/delete/'+id, "", function (res, status) { 
  	     		if(status=="success"&&res.statusCode=="200"){
  	     			swal(res.message, "您已经永久删除了这条信息。", "success");
  	     			hotelDynamic_search();
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
function hotelDynamic_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotelDynamic_searchForm')));
}

function hotelDynamic_search(page,rows){
	//$("#hotelDynamic_table").bootstrapTable("refresh");
	page = page || 1;
	rows = rows || 10;
	var data = $.extend({page:page,rows : rows}, common.serializeObject($('#hotelDynamic_searchForm')));
	show();
	$("#dynamic").empty();
	$.ajax({
		url : '${ctx}/base/hotel/dynamic/list', //点击分页提交当前页码
		data : data,
		success : function(res) {
			hide();
			if (res != null) {//DOM操作
				var html = template('dynamic_temp_list_script', res);
				var $html = $(html);
				console.log(fancyboxArr.join(","));
				fancyboxInit($html);
				//$html.find('.fancybox').fancybox();
				$("#dynamic").append($html);
				 common.pms.init();
				var fir = (res.currtPage-1)*dynamic_rows+1;
				var end = (res.currtPage-1)*dynamic_rows+res.rows.length;
				hotelDynamic_paginationDetail(fir,end,res.total,dynamic_rows);
			}else{
				hotelDynamic_paginationDetail(1,0,0,dynamic_rows);
			}
		}
	});
}
function fancyboxInit($html){
	if(fancyboxArr){
		for(var n=0,len=fancyboxArr.length;n<len;n++){
			$html.find('.'+fancyboxArr[n]).fancybox();
		}
	}
}

function hotelDynamic_paginationDetail(fir,end,total,rows){
	var info ="显示第 "+fir+"到第 "+end+"条记录，总共 "+total+" 条记录";
	$(".pagination-info").text(info);
	$(".page-size").text(rows);
	
	$(".pagination-detail ul li").each(function(){
		if($(this).attr("page-size")==rows){
			$(this).addClass("active");
		}else{
			$(this).removeClass("active");
		}
	});
	
}

function hotelDynamic_AjaxPaginator(obj) {
	var data = $.extend({page : dynamic_page,rows : dynamic_rows}, common.serializeObject($('#hotelDynamic_searchForm')));
	show();
	$.ajax({
		type : 'POST',
		url : '${ctx}/base/hotel/dynamic/list',
		data : data,
		dataType : 'JSON',
		success : function(data) {
			$("#dynamic").empty();
			if (data != null) {//DOM操作
				var html = template('dynamic_temp_list_script', data);
				var $html = $(html);
				//$html.find('.fancybox').fancybox();
				fancyboxInit($html);
				$("#dynamic").append($html);
				common.pms.init();
				var fir = (data.currtPage-1)*dynamic_rows+1
				var end = (data.currtPage-1)*dynamic_rows+data.rows.length;
				hotelDynamic_paginationDetail(fir,end,data.total,dynamic_rows);
			}else{
				hotelDynamic_paginationDetail(1,0,0,dynamic_rows);
			}
			hide();
		},
		complete : function(data) {
			var doj = eval('('+data.responseText+')');
			var currentPage = doj.currtPage || 1;
			var totalPages = doj.totalPage || 0;//data.total/dynamic_rows;
			var options = {
				currentPage : currentPage, //当前页
				totalPages : totalPages, //总页数
				numberOfPages : 5, //设置控件显示的页码数
				bootstrapMajorVersion : 3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
				useBootstrapTooltip : true,//是否显示tip提示框
				onPageClicked : function(event, originalEvent, type, page) {
					dynamic_crt_page = page;
					hotelDynamic_search(page, dynamic_rows);
				}
			}
			obj.bootstrapPaginator(options);
		}
	})
}

//
</script>
<script id="dynamic_temp_list_script" type="text/html">
{{each rows as item i}}
	<div class="row" style="border-top: 1px solid #f5f5f5;">
		<div class="col-sm-2" style="text-align: center;padding-top: 25px;">
			<img style="width: 80px;height: 80px;" src="{{item.hoteLogo}}"  onerror="nofindImg(this);">
		</div>
		<div class="col-sm-10">
			<div style="position: relative;">
				<h2>{{item.hotelName}}</h2>
				<button  qx="dynamic:delete" type="button" onclick="hotelDynamic_del_fun('{{item.id}}')" class="btn btn-primary btn-sm" style="position: absolute;right: 0;top:0;"><span class="glyphicon glyphicon-remove"> </span> 删除</button>
			</div>
			<div >
					<span  style="border: 1px solid #f5f5f5;padding: 5px;color: #cccccc;width:auto;">
						<span style="margin-right:15px;">
							活动执行公司：{{item.party}}
						</span>
						<span style="margin-right:15px;">
							时间：{{item.partyTime}}
						</span>
						<span style="margin-right:15px;">
							地点：{{item.area}}
						</span>
						<span style="">
							参考预算：<span style="color: #ff0000;">{{item.budget}}元</span>
						</span>
					</span>
			</div>
			<div style="padding: 10px 0;">
				{{item.pcontent}}
			</div>
			<div style="padding: 10px 0;">
				{{item | fmimgs}}
			</div>
			<div style="padding: 10px;color: #cccccc;">
				{{item.createDate}}
			</div>
		</div>
	</div>
{{/each}}	
</script>
	