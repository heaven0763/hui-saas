<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="wrapper wrapper-content">
	<h3>城市合伙人</h3>
	<hr>
	<div class="form-group">
		<a qx="user:add" href="${ctx}/weixin/city/partner/create" target="dialog" class="btn btn-primary" title="添加用户" data-permission="user:create"><span class="glyphicon glyphicon-plus"></span> 添加合伙人</a>
	</div> 
	<form class="form-inline" id="city_partner_searchForm">
	    <div class="form-group">
			
			<label for="city">地区</label>
	   		<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10" name="search_EQ_c.city" style="width: 200px;">
				<tags:dict sql="SELECT id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc "  showPleaseSelect="fasle" addBefore=",全部"/>
			</select> 
		    <label for="nickname">合伙人姓名</label>
		    <input type="text" class="form-control" id="rname" name="search_LIKE_u.rname" placeholder="请输入用户姓名">
		     <label for="mobile">手机号码</label>
		    <input type="text" class="form-control" id="mobile" name="search_LIKE_u.mobile" placeholder="请输入手机号码">
		   
		    <input type="hidden"  name="sort" value="createDate">
		    <input type="hidden"  name="order" value="desc">
		    <button type="button" class="btn btn-primary" onclick="city_partner_search()" data-permission="user:query"><span class="glyphicon glyphicon-search" > </span> 查询</button>
	    </div>
	</form>
	<br/>
	<table id="city_partner_table" data-toggle="table" data-height="660" data-query-params="city_partner_queryParams"
		data-pagination="true" data-url="${ctx}/weixin/city/partner/pc/list" data-data-type="json">
	    <thead>
	        <tr>
				<th data-field="rname">姓名</th>
				<th data-field="cityTxt">地区</th>
				<th data-field="mobile">联系电话</th>
				<th data-field="email">电子邮箱</th>
				<th data-options="state" data-formatter="fm_city_partner_state">状态</th>
				
				<th data-field="annualAmount" >本年度达成业务</th>
				<th data-field="hotelQuantity" data-formatter="fm_city_partner_hotelQuantity">开拓场地数量</th>
				<th data-field="annualAmounts" data-formatter="fm_city_partner_annualAmounts">年度接待业务金额</th>
				<th data-field="allAmount" data-formatter="fm_city_partner_allAmount">累计接待业务金额</th>
				<th data-field="staffs" data-formatter="fm_city_partner_staffs">管辖人员树状图</th>
	        </tr>
	    </thead>
	</table>
	<script>
		$(function(){
			common.pms.init();
			$("#city_partner_table").bootstrapTable({onLoadSuccess:function(){
				common.pms.init();
			}});
		});
		function fm_city_partner_state(value,row, index){
			if(row.state==="0"){
				return "待认证";
			}else{
				return "已认证";
			}
		}
		
		function fm_city_partner_hotelQuantity(value,row, index){
			return '<a class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;" onclick="exportExcel(\'hotel\','+row.id+',0)" title="点击导出数据">'+value+'</a>';
		}
		
		function fm_city_partner_annualAmounts(value,row, index){
			return '<a class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;" onclick="exportExcel(\'order\','+row.id+',1)" title="点击导出数据">'+row.annualAmount+'</a>';
		}
		
		function fm_city_partner_allAmount(value,row, index){
			return '<a class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;" onclick="exportExcel(\'order\','+row.id+',0)" title="点击导出数据">'+value+'</a>';
		}
		
		function fm_city_partner_staffs(value,row, index){
			return '<a class="btn btn-xs bg-none-01" style="padding:0.1rem 1rem;" onclick="exportExcel(\'staff\','+row.id+',0)" title="点击导出数据">导出</a>';
		}
		
		function city_partner_queryParams(params){
			return $.extend({},params,util.serializeObject($('#city_partner_searchForm')));
		}
		function city_partner_search(){
			$("#city_partner_table").bootstrapTable("refresh");
		}
		function exportExcel(type,cmpyId,idx){
			var url = '${ctx}/weixin/city/partner/export/'+type+"?cmpyId="+cmpyId+"&idx="+idx;
			common.ajaxDownload(url);
		}
		</script>
</div>
