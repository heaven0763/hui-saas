<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>场地管理</h3>
	<hr>
	<div class="form-group">
		<a qx="hotel:add" href="javascript:;" onclick="loadContent(this,'${ctx}/base/hotel/create','');"  class="btn btn-primary" title="添加"><span class="glyphicon glyphicon-plus"> </span> 添加</a>
	</div>
	<form class="form-inline" id="hotel_searchForm">
		  <div class="form-group">
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
				
				<label for="hotelType">场地类型</label>
		   		<select class="form-control"  id="hotelType" name="search_EQ_h.hotel_type">
					<tags:dict sql="SELECT id,name as name FROM hui_category where kind ='HOTELTYPE' "  showPleaseSelect="false" addBefore=",全部"/>
				</select>
				<%-- <label for="hotelStar">场地星级</label>
		   		<select class="form-control"  id="hotelType" name="search_EQ_h.hotel_star">
					<tags:dict sql="SELECT id,name as name FROM hui_category where kind ='STAR' "  showPleaseSelect="false" addBefore=",全部"/>
				</select> --%>
				<c:if test="${!groupMap.iscompanysales && ! groupMap.ishotelsales }">
					<label for="reclaim_user_id">开拓销售</label>
					<select class="form-control"  data-live-search="true"  id="reclaim_user_id" name="search_EQ_h.reclaim_user_id"  data-width="auto" data-size="10" >
						<option value="">全部</option>
						<c:forEach items="${sales}" var="sale">
							<option value="${sale.id }">${sale.rname}-${sale.mobile}</option>
						</c:forEach>
					</select>
				</c:if>
				<br>
				<br>
				<label for="hotelStar">人数</label>
		   		<select class="form-control"  id="hotelType" name="person">
					<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='PERSON' "  showPleaseSelect="false" addBefore=",全部"/>
				</select>
				<label for="hotelStar">面积</label>
		   		<select class="form-control"  id="hotelType" name="area">
					<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='AREA' "  showPleaseSelect="false" addBefore=",全部"/>
				</select>
				<label for="hotelStar">价格</label>
		   		<select class="form-control"  id="hotelType" name="price">
					<tags:dict sql="SELECT val id,name as name FROM hui_category where kind ='PRICE' "  showPleaseSelect="false" addBefore=",全部"/>
				</select>
				<label for="hotelName">场地名称</label>
		   		<input type="text" class="form-control" id="hotelName" name="search_LIKE_h.hotel_name" placeholder="请输入场地名称">
				
		   		<label for="decorationTime">装修时间</label>
		  		<input type="text" class="form-control  layer-date laydate-icon" id="decorationTime" name="decorationTime" placeholder="请输入装修时间">
		   		
				
				
			  <button type="button" class="btn btn-primary" onclick="hotel_search()"><span class="glyphicon glyphicon-search"> </span> 查询</button>
		  </div>
		</form>
		<br>
	<table id="hotel_table" class="table-condensed" data-toggle="table" data-height="660" data-query-params="hotel_queryParams"
		data-pagination="true" data-url="${ctx}/base/hotel/list" data-data-type="json">
	    <thead>
	        <tr>
				<!-- <th data-field="hotelFaceImg">场地封面图片</th> -->
				<th data-field="pName">集团名称</th>
				<th data-field="hotelName" data-formatter="fm_hotel_name">场地名称</th>
				<th data-field="hotelTypeText">场地类型</th>
				<!-- <th data-field="hotelStarText">场地星级</th> -->
				<th data-field="district" data-formatter="fm_hotel_region">所属区域</th>
				<th data-field="updateDate">更新时间</th>
				<th data-field="hallNum" data-align="right">会场数量</th>
				<th data-field="roomNum" data-align="right">客房数量</th>
				<th data-field="reclaimUserName" data-align="right">开拓销售</th>
				
				<!-- <th data-field="hallMaxArea" data-align="right">会场面积</th>
				<th data-field="maxPeopleNum" data-align="right">容納人数</th>
				<th data-field="averagePrice" data-align="right">价格</th>
				<th data-field="recommendedIndex">推荐指数</th>
				<th data-field="reviewIndex">评论指数</th>
				<th data-field=contact>联系人</th>
				<th data-field="telephone">联系固话</th>
				<th data-field="mobile">联系手机</th>
				<th data-field="email">邮箱</th> 
				<th data-field="state">场地状态</th> 
				<th data-field="verify">实地认证</th>
				<th data-field="isTui">推荐场地</th>
				<th data-field="isbest">优质场地</th>-->
				<th data-formatter="fm_hotel_operate">操作</th> 
	        </tr>
	    </thead>
	</table>
</div>
<script>
function fm_hotel_operate(value,row, index){
	
	return '<a qx="hotel:update" href="javascript:;" onclick="loadContent(this,\'${ctx}/base/hotel/manage/'+row.id+'\',\'\');" class="btn btn-primary btn-sm" title="修改"><span class="glyphicon glyphicon-pencil"> </span> 修改</a>'
	+'&nbsp;&nbsp;<button qx="hotel:delete" type="button" onclick="hotel_del_fun(\''+row.id+'\')" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-remove"> </span> 删除</button>';
}
function fm_hotel_name(value,row, index){
	//qx="hotel:update"
	return '<a  href="javascript:;" onclick="loadContent(this,\'${ctx}/base/hotel/manage/'+row.id+'\',\'\');" title="修改">'+value+'</a>';
}

function fm_hotel_state(value,row, index){
	if(row.locked=="0"){
		return "使用中";
	}else{
		return "已锁定";
	}
}
function hotel_del_fun(id){
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
   	     	$.post('${ctx}/base/hotel/delete/'+id, "", function (res, status) { 
   	     		if(status=="success"&&res.statusCode=="200"){
   	     			swal(res.message, "您已经永久删除了这条信息。", "success");
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
	var decorationTime={elem:"#decorationTime",format:"YYYY-MM-DD",max:"2099-06-16",istime:false,istoday:false};
	   laydate(decorationTime);
    common.pms.init();
    $("#hotel_table").bootstrapTable({onLoadSuccess: function(){  //加载成功时执行  
    	common.pms.init();
    }});
	
});
function hotel_queryParams(params){
	return $.extend({},params,util.serializeObject($('#hotel_searchForm')));
}

function hotel_search(){
	$("#hotel_table").bootstrapTable("refresh");
}

</script>