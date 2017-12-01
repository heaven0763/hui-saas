<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
<link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
<link href="${ctx}/static/resource/css/adapt.css" rel="stylesheet" />
<style>
<!--
.btn-hotel-checked{color: #ffffff;background-color: #274082;}
-->
</style>
<div class="modal-body">
<style>
</style>
	<form class="form-inline" id="sel_hotel_searchForm">
	  <input type="hidden" name="userId" value="${user.id}">
	  <div class="form-group">
		  <label for="city">员工姓名</label>
		  <span class="form-control" style="width: 200px;">${user.rname }</span>
		  <label for="city">员工职务</label>
		   <span class="form-control" style="width: 200px;">${user.position }</span>
		   <label for="hotelType">场地类型</label>
	   		<select class="form-control"  id="hotelType" name="search_EQ_h.hotel_type">
				<tags:dict sql="SELECT id,name as name FROM hui_category where kind ='HOTELTYPE' "  showPleaseSelect="false" addBefore=",全部"/>
			</select>
			<label for="hotelType">场地权限</label>
	   		<select class="form-control"  id="hotelpower" name="hotelpower">
				<option value="1">权限内场地</option>
				<option value="0">权限外场地</option>
			</select>
		 <%--  <label for="city">所在城市</label>
		   <span class="form-control" style="width: 200px;">${user.city }</span>
		   <select class="form-control" disabled="disabled" style="width: 200px;">
		  	 <tags:dict sql="select  id ,region_name name  from hui_region where region_type='2' "  showPleaseSelect="false" selectedValue="${user.city }"/>
		   </select> --%>
	  </div>
	  <hr/>
	  <div class="form-group">
			<label for="city">场地所属城市</label>
	   		<select class="form-control"   id="province" name="province" refval="value" reftext="text" 
				refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#city" onchange="areaclear();">
				<tags:dict sql="select  id ,region_name name  from hui_region where parent_id='1' "  showPleaseSelect="false" addBefore=",全部" />
			</select>
			<select class="form-control"   id="city" name="city" refval="value" reftext="text" 
	     		refurl="${ctx}/framework/dictionary/trslCombox?sql=select  id ,region_name name  from hui_region where parent_id={value}" refdata="parent_id=:{value}" ref="#district" onchange="areaclear('city');">
	     		<option value="">全部</option>
			</select>
			<select class="form-control"   id="district" name="district" refval="value" reftext="text" 
				refurl="${ctx}/framework/dictionary/trslCombox?sql=SELECT id,district as name FROM hui_district where region_id in (select parent_id from hui_region where id={value})" refdata="region_id=:{value}" ref="#tradeArea">
				<option value="">全部</option>
			</select> 
			<label for="hotelName">场地名称</label>
	   		<input type="text" class="form-control" id="hotelName" name="search_LIKE_h.hotel_name" placeholder="请输入场地名称">
		  <button type="button" class="btn btn-primary" onclick="loadHotel()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
		  <button id="hotel_sel_all" type="button" class="btn btn-primary" > 全选</button>
		  <button id="hotel_unsel_all" type="button" class="btn btn-primary" > 全不选</button>
	  </div>
	</form>
	<hr>
	<div id="sel_hotel_list" style="padding: 0.2rem 0;max-height: 380px;overflow: auto;">
	</div>
	<div class="modal-footer">
		<div class="row">
			<div class="col-sm-12  authhotel" style="text-align: right;padding: 0;">
				<div class="pull-left pagination-detail" style="margin: 20px 0;padding: 0 5px;">
					<span class="pagination-info"></span>
					<span class="page-list">
						每页显示 
						<span class="btn-group dropup">
							<button type="button" class="btn btn-default  dropdown-toggle" data-toggle="dropdown">
								<span class="page-size">10</span> <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu">
								<li class="active" page-size="30"><a href="javascript:void(0)">30</a></li>
								<li page-size="40"><a href="javascript:void(0)">40</a></li>
								<li page-size="50"><a href="javascript:void(0)">50</a></li>
								<li page-size="100"><a href="javascript:void(0)">100</a></li>
							</ul>
						</span> 
						条记录
					</span>
				</div>
				<ul class="pagination"></ul> 
				<div class="pull-right" style="text-align: right;padding: 0 5px;margin: 20px 0;">
					<button type="button" class="btn btn-default" id="sel_hotel_close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
					<button type="button" class="btn btn-primary" id="author_hotel_save"><span class="glyphicon glyphicon-save"></span> 保存</button>
					<input type="hidden" id="userId" name="userId" value="${user.id}" />
				</div>
			</div>
		</div>
		<div class="row">
			
		</div>
	</div>
<script type="text/javascript">
var flag = 0;
var auhtl_page = 1;
var auhtl_crt_page = 1;
var auhtl_crt_rows = 30
$(function(){
	//loadHotel();
	authorhotel_AjaxPaginator($(".authhotel .pagination"));
	$('.selectpicker').selectpicker();
	var $sel_hotel_list = $('#sel_hotel_list');
	$sel_hotel_list.delegate('[hotelid]','click',function(){	//场地列表点击事件
		var $this = $(this);
		$this.toggleClass('btn-hotel-checked').toggleClass('btn-hotel-unchecked');
	});
	
	/* $("#hotelname").text($this.text());
	$("#hotelId").val($this.attr('hotelid'));
	loadDetailContent($this.attr('hotelid')); 
	$("#sel_hotel_close_btn").click(); */
	
	$("#hotel_sel_all").click(function(){
		$('#sel_hotel_list [hotelid]').removeClass('btn-hotel-unchecked').addClass('btn-hotel-checked');
	});
	
	$("#hotel_unsel_all").click(function(){
		$('#sel_hotel_list [hotelid]').removeClass('btn-hotel-checked').addClass('btn-hotel-unchecked');
	});
	
	$("#author_hotel_save").click(function(){
		var hotel_ids = [];
		$('#sel_hotel_list .btn-hotel-checked').each(function(){
			hotel_ids.push($(this).attr('hotelid'));
		});
		var unhotel_ids = [];
		$('#sel_hotel_list .btn-hotel-unchecked').each(function(){
			unhotel_ids.push($(this).attr('hotelid'));
		});
		var userId = $("#userId").val();
		var url = "${ctx}/base/user/author/hotel/save"
		$.post(url,{userId:userId,hotelIds:hotel_ids.join(','),unhotelIds:unhotel_ids.join(',')},function(res){
			if(res.statusCode=="200"){
				swal(res.message,'success');
				loadHotel();
			}else{
				swal(res.message,'error');
			}
		},"json");
	});
	
	
	$(".authhotel .pagination-detail ul li").click(function(){
		auhtl_crt_rows = $(this).attr("page-size");
		authorhotel_AjaxPaginator($(".authhotel .pagination"));
	});
});
 function loadHotel(){
	 authorhotel_AjaxPaginator($(".authhotel .pagination"));
}
function authorhotel_search(page,rows){
	//$("#hotelDynamic_table").bootstrapTable("refresh");
	page = page || 1;
	rows = rows || 30;
	var data = $.extend({page:page,rows : rows}, common.serializeObject($('#sel_hotel_searchForm')));
	show();
	$("#sel_hotel_list").empty();
	$.ajax({
		url : '${ctx}/base/hotel/auth/select/list', //点击分页提交当前页码
		data : data,
		success : function(res) {
			hide();
			if (res != null) {//DOM操作
				var html = [];
				var list = res.object.rows;
				for(var i in list){
					html.push('<div class="btn btn-query btn-plain bg-none-query '+('${user.id}'==list[i].reclaimUserId?'btn-hotel-checked':'btn-hotel-unchecked')+'" style="width:30%;margin: 0.4rem 0.2rem;" hotelid="'+list[i].id+'" hotelname="'+list[i].hotelName+'">'+list[i].hotelName+'</div>');
				}
				$('#sel_hotel_list').html(html.join(''));
				var fir = (res.object.currtPage-1)*auhtl_crt_rows+1;
				var end = (res.object.currtPage-1)*auhtl_crt_rows+list.length;
				authorhotel_paginationDetail(fir,end,res.object.total,auhtl_crt_rows);
			}else{
				authorhotel_paginationDetail(1,0,0,auhtl_crt_rows);
			}
		}
	});
}

function authorhotel_paginationDetail(fir,end,total,rows){
	var info ="显示第 "+fir+"到第 "+end+"条记录，总共 "+total+" 条记录";
	$(".authhotel .pagination-info").text(info);
	$(".authhotel .page-size").text(rows);
	
	$(".authhotel .pagination-detail ul li").each(function(){
		if($(this).attr("page-size")==rows){
			$(this).addClass("active");
		}else{
			$(this).removeClass("active");
		}
	});
	
}

function authorhotel_AjaxPaginator(obj) {
	var data = $.extend({page : auhtl_page,rows : auhtl_crt_rows}, common.serializeObject($('#sel_hotel_searchForm')));
	//show();
	$.ajax({
		type : 'POST',
		url : '${ctx}/base/hotel/auth/select/list',
		data : data,
		dataType : 'JSON',
		success : function(res) {
			$("#sel_hotel_list").empty();
			if (res != null) {//DOM操作
				var html = [];
				var list = res.object.rows;
				for(var i in list){
					html.push('<div class="btn btn-query btn-plain bg-none-query '+('${user.id}'==list[i].reclaimUserId?'btn-hotel-checked':'btn-hotel-unchecked')+'" style="width:30%;margin: 0.4rem 0.2rem;" hotelid="'+list[i].id+'" hotelname="'+list[i].hotelName+'">'+list[i].hotelName+'</div>');
				}
				$('#sel_hotel_list').html(html.join(''));
				var fir = (res.object.currtPage-1)*auhtl_crt_rows+1;
				var end = (res.object.currtPage-1)*auhtl_crt_rows+list.length;
				authorhotel_paginationDetail(fir,end,res.object.total,auhtl_crt_rows);
			}else{
				authorhotel_paginationDetail(1,0,0,auhtl_crt_rows);
			}
		},
		complete : function(data) {
			console.log(data.responseText);
			var doj = eval('('+data.responseText+')');
			var currentPage = doj.object.currtPage || 1;
			var totalPages = doj.object.totalPage || 0;//data.total/auhtl_crt_rows;
			var options = {
				currentPage : currentPage, //当前页
				totalPages : totalPages, //总页数
				numberOfPages : 5, //设置控件显示的页码数
				bootstrapMajorVersion : 3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
				useBootstrapTooltip : true,//是否显示tip提示框
				onPageClicked : function(event, originalEvent, type, page) {
					auhtl_crt_page = page;
					authorhotel_search(page, auhtl_crt_rows);
				}
			}
			obj.bootstrapPaginator(options);
		}
	})
}

</script>
</div>
