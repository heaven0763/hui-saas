<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script id="temp_script_SITE" type="text/html">
{{each rows as item i}}
<div class="one-list" style="" item-rdurl="${ctx}/weixin/order/evaluate/detail/{{item.id}}">
<div class="one-list-ct"  style="">
	<div class="one-list-ct-title" style="">
		<div style="display:inline-block;">{{item.itemName}}</div>
		<div class="list-ct-state list-ct-state-02 " style="display:inline-block;">{{item.star}}</div>
		<div style="display: inline-block;float: right;font-size: 0.8rem;font-weight: normal;"><i class="fa fa-map-marker"></i>{{item.city}}</div>
	</div>
	
	<div class="one-list-ct-sett" style="">
		<div class="sett-left" style="">所在行政区域：{{item.area}}</div>
		<div class="eva-star-parent" style="" >
			客户综合评价：
			<div class="icon-start-02 icon-start-size-{{item.comprehensive}}" style="display:inline-block;" >
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
			</div>
		</div>
	</div>
</div>
</div>
{{/each}}
</script>
<script id="temp_script_SALE" type="text/html">
{{each rows as item i}}
<div class="one-list" style="" item-rdurl="${ctx}/weixin/order/evaluate/detail/{{item.id}}">
<div class="one-list-ct"  style="">
	<div class="one-list-ct-title" style="">
		<div style="display:inline-block;">{{item.itemName}}</div>
		<div class="list-ct-state list-ct-state-01 " style="display:inline-block;">{{item.star}}</div>
		<div class="eva-star-parent" style="font-size: 0.8rem;" >
			客户综合评价：
			<div class="icon-start-02 icon-start-size-{{item.comprehensive}}" style="display:inline-block;" >
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
			</div>
			
		</div>
	</div>
	
	<div style="font-size: 0.8rem;display: flex;justify-content: space-between;margin-top:0.5rem;">
		<div>姓名：{{item.saleName}}</div>
		<div>职位：{{item.salePosition}}</div>
		<div>联系电话：{{item.saleMobile}}</div>
	</div>
</div>
</div>
{{/each}}
</script>
<script id="temp_script_PLATFORM" type="text/html">
{{each rows as item i}}
<div class="one-list" style="" item-rdurl="${ctx}/weixin/order/evaluate/detail/{{item.id}}">
<div class="one-list-ct"  style="">
	<div class="one-list-ct-title letter-sp-min" style="margin-top:0.3rem;display: flex;justify-content:space-between;">
		<div class="font-size-min" style="font-weight:normal;">地区：{{item.city}}</div>
		<div class="font-size-min" style="font-weight:normal;">评论人群：{{item.euserType | tp_fnUSERTYPE}}</div>
		<div class="eva-star-parent" style="float:none;text-aglin:right;" >
			客户综合评价：
			<div class="icon-start-02 icon-start-size-{{item.comprehensive}}" style="display:inline-block;" >
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
			</div>
			
		</div>
		<div style="clear:both;"></div>
	</div>
	
</div>
</div>
{{/each}}

</script>
<!-- <div class="one-list-ct-sett eva-toggle-div" style="font-size:0.75rem;line-height:1.5rem;display:none;">
		<div class="" style="width:33%.33;float:left;">平台体验感：
			<div class="icon-start-01 icon-start-size-5" style="display:inline-block;" >
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
			</div>
		</div>
		<div class="" style="width:33%.33;float:right;">公司跟进服务：
			<div class="icon-start-01 icon-start-size-5" style="display:inline-block;" >
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
			</div>
		</div>
		<div class="" style="width:33%.33;float:left;">获取优惠：
			<div class="icon-start-01 icon-start-size-5" style="display:inline-block;" >
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
				<i class="fa fa-star"></i>
			</div>
		</div>
		<div style="clear:both;"></div>
	</div> -->