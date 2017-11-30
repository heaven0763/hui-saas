<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>人员管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
</head>

<body class="" style="overflow:hidden;">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	
	<div id="top_toolbar" class="toolbar" style="">
		<div class="toolbar-title">
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">日期</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">类别</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
			</div>
			<div class="toolbar-one" style="">
			</div>
		</div>
		
		<div id="top_toolbar_query" class="toolbar-search-parent">
		
			<div class="toolbar-content dp-none font-gray-01 font-size-min">
			
				<div style="text-align:center;">
					<input type="date" id="input_params_gte_date" name="" style="float:left;width:42%;" />
					<div style="display:inline-block;font-size:1.15rem;width:2rem;">-</div>
					<input type="date" id="input_params_lte_date" name="" style="float:right;width:42%;"/>
					<div style="clear:both;"></div>
				</div> 
				
				<div class="" style="font-size:0;margin-top:0.8rem;">
					<div id="btn_date_reset"  class="btn btn-xd btn-plain btn-disable" style="width:50%;font-size:0.85rem;">重置</div>
					<div id="btn_date_conifrm" class="btn btn-xd btn-plain btn-disable" style="width:50%;font-size:0.85rem;">确定</div>
				</div>
			</div>
			
			<div class="toolbar-content dp-none font-gray-01 font-size-min">
				<div id="user_group_list" style="width:100%;font-size:0;line-height:2rem;text-align:center;">	
				</div>
			</div>
			
			
		</div>
	</div>
	
	<div id="div_list_parent" class="content tran-list-ct" style="width:100%;overflow-y:scroll;">
		
		
	</div>
	
	<form action="" id="form_list_params" style="">
		<input type="date" id="search_GTE_createDate" name="search_GTE_createDate"  />
		<input type="date" id="search_LTE_createDate" name="search_LTE_createDate"/>
		<input id="search_groupid" type="text" name="search_EQ_groupId"  />
	</form>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/data.citys.list.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/dict.js"></script>


<script>
common.ctx =  '${ctx}';

$(function(){
	dict.init();
	
	 var pager = new common.customPage({
		startnow : true,
		url :  '${ctx}/weixin/user/list',
		form : $('#form_list_params'),
		jqobj : $('#div_list_parent'),
		tmpid : 'temp_script_user_administrator'
	}); 
	 
	 $('#btn_date_conifrm').click(function(){	
		 
		 $('#search_GTE_createDate').val($('#input_params_gte_date').val());
		 $('#search_LTE_createDate').val($('#input_params_lte_date').val());
		 pager.search();
		 checkAndQuit(0);
	 });
	 
	 $('#btn_date_reset').click(function(){	//日期重置
		 $('#input_params_gte_date').val('');
		 $('#input_params_lte_date').val('');
	 });
	
	$('#div_list_parent').delegate('.one-list ','click',function(){
		var $this = $(this);
		var $target = $this.find('.hide-content');
		if($target.hasClass('dp-none')){
			$('#div_list_parent .hide-content').addClass('dp-none');
			$target.removeClass('dp-none');
		}else{
			$target.addClass('dp-none');
		}
		
	});

	
	var $topToolbar = $('#top_toolbar');
	var $top_toolbar_query = $('#top_toolbar_query');
	var $topToolbars = $('#top_toolbar .toolbar-one');
	
	//为了列表能滚动而设置高度
	$('#div_list_parent').height($(window).height() - $topToolbar.height());
	
	$topToolbars.click(function(){	//顶部选择
		var $this = $(this);
		$('#top_toolbar .toolbar-one:not(:eq('+$this.index()+'))').removeClass('icon-arrow-active');
		
		if(!$this.hasClass('icon-arrow-active')){
			$this.addClass('icon-arrow-active');
			$topToolbar.addClass('toolbar-active')
			showMaskDiv();
		}else{
			$this.removeClass('icon-arrow-active');
			$topToolbar.removeClass('toolbar-active')
			hideMaskDiv();
		}
		
		$top_toolbar_query.find('.toolbar-content').hide();
		
		var $target = $top_toolbar_query.find('.toolbar-content:eq('+($this.index() )+')');
		if(!$this.hasClass('icon-arrow-active')){
			$target.hide();
		}else{
			$target.show();
			if($target.height() > $(window).height()){
				$target.height($(window).height() - $topToolbar.find('.toolbar-title').height() - 10);	//为了弹出的选择框能滚动而设置高度
			}
		}
	
	});
	
	$('#mask-full-screen').click(function(){
		$('.icon-arrow-active').click();
	});
	
	
	$('#user_group_list').delegate('[groupid]','click',function(){	//用户类型（角色）点击事件
		var $this = $(this);
		$('#user_group_list [groupid]').removeClass('font-cl-query-chked');
		$this.addClass('font-cl-query-chked');
		$('#search_groupid').val($this.attr('groupid'));
		
		pager.search();	//查询
		checkAndQuit(1);
	});
	
	common.ajaxjson({	//获取用户类型（角色）列表
		url : '${ctx}/weixin/group/findall',
		success : function(res){
			var rows = res.object || res;
			
			var html = [];
			html.push('<div class="top-query-item-normal" groupid="">不限</div>');
			for(var i in rows){
				html.push('<div class="top-query-item-normal" groupid="'+rows[i].id+'">'+rows[i].name+'</div>');
			}
			$('#user_group_list').html(html.join(''));
		}
	});
});

function showMaskDiv(){
	$('#mask-full-screen').show();
	$('body').css('overflow','hidden');
}

function hideMaskDiv(){
	$('body').css('overflow-y','auto');
	$('#mask-full-screen').hide();
}

function checkAndQuit(index){
	$('#top_toolbar .toolbar-one').eq(index).addClass('icon-arrow-chked');
	$('#top_toolbar .toolbar-one').eq(index).removeClass('icon-arrow-active');
	$('#top_toolbar_query .toolbar-content').eq(index).hide();
	hideMaskDiv();
}

function quitWithoutCheck(index){
	$('#top_toolbar .toolbar-one').eq(index).removeClass('icon-arrow-chked');
	$('#top_toolbar .toolbar-one').eq(index).removeClass('icon-arrow-active');
	$('#top_toolbar_query .toolbar-content').eq(index).hide();
	hideMaskDiv();
}
</script>

<script id="temp_script_user_administrator" type="text/html">
{{each rows as item i}}
<div class="one-list" >
	<div class="one-list-ct-title" style="position:relative;">
		<div style="display:inline-block;">{{item.rname}}</div>
		<div class="list-ct-state " style="margin-left:0.3rem;font-weight:normal;">职务：{{item.position}}</div>
		<div class="btn btn-xs bg-type-02" style="position:absolute;right:0;" rdurl="${ctx}/weixin/user/update/{{item.id}}">修改权限</div>
	</div>
	<div class="one-list-ct-sett" style="">
		<div style="display:inline-block;font-size:0.68rem;width:12%;vertical-align:top;line-height: 1.2rem;">权限：</div>
		<div class="pms-list-parent" style="display:inline-block;width:88%;">
		{{each item.userPermissions as pms j}}
			<div class="btn btn-xs bg-none-01" style="width:48%;">{{pms.permissionName}}</div>
		{{/each}}
		</div>
	</div>
</div>
{{/each}}
</script>
</html>
