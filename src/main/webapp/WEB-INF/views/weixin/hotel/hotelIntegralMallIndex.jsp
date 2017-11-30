<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>积分商城</title>
    <meta charset="utf-8">
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    
    <link href="${ctx}/static/weixin/css/font-awesome.min.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
   	<style type="text/css">
   		i.ic{background-image:url(${ctx}/static/weixin/css/icon/main/jfcons.png);background-repeat: no-repeat;background-size:14px;    background-position: center; }
   		.bgimg{height: 7rem;width: 7rem;background-size: cover;background-position: center;}
   	</style>
    
</head>

<body class="">
	<div id="mask-full-screen" class="mask-full-screen"></div>
	<div id="top_toolbar" class="toolbar" style="">
		<div class="toolbar-title">
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">已通过</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">审核中</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
			<div class="toolbar-one" style="">
				<span class="toolbar-one-text" style="">不通过</span><i class="fa fa-angle-down toolbar-one-arrow" style="">&nbsp;</i>
			</div>
		</div>
	</div>
	<div id="div_list_parent" class="content tran-list-ct" style="width:100%;overflow-y:scroll;margin-top:3rem;">
		<!-- <div class="one-list" style="" item-rdurl="#">
			<div  style="padding-top: 0.5rem;width: 100%;">
				<div class="bgimg" style="float:left;background-image: url('http://192.168.199.166:8081/hui/static/uploadfiles/integralmall/1488336392349.jpg');">
					<img alt="" src="http://pic.xiami.net/images/album/img19/72/58a52ddd79908_3642119_1487220189.jpg?x-oss-process=image/resize,limit_0,m_pad,w_185,h_185" style="width: 100%;height: 100%;">
				</div>
				<div  style="float:left;margin-left: 10px;width: 60%;">
					<div class="one-list-ct-title" style="min-height: 40px;widht:100%;height:100%;word-wrap:break-word;word-break:break-all;">标准豪华双人房并赠送双人免费自助餐</div>
					<div style="margin: 3% 0;font-size: 0.75rem;widht:100%;">
						<div style="float: left;">场地原价：￥499.00</div>
						<div style="float: right;"><i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i><span style="color: red;">700分</span></div>
						<div style="clear:both;"></div>
					</div>
					<div style="margin: 3% 0;font-size: 0.75rem;">会掌柜价：￥297.00</div>
					<div style="margin: 3% 0;font-size: 0.75rem;">
						<div class="btn btn-xs" style="float:left;color:#019FEA;border: 1px solid #019FEA;">不通过</div>
						
						<div class="btn btn-xs bg-type-01" style="float:left;margin-left: 5px;">通过</div>
						<div style="clear:both;"></div>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div class="one-list" style="" item-rdurl="#">
			<div  style="padding-top: 0.5rem;">
				<div style="display:inline-block;float:left;width: 30%;">
					<img alt="" src="http://pic.xiami.net/images/album/img19/72/58a52ddd79908_3642119_1487220189.jpg?x-oss-process=image/resize,limit_0,m_pad,w_185,h_185" style="width: 100%;height: 100%;">
				</div>
				<div  style="float:left;margin-left: 10px;width: 65%;">
					<div class="one-list-ct-title" style="margin: 3% 0;min-height: 40px;widht:100%;height:100%;word-wrap:break-word;word-break:break-all;">标准豪华双人房并赠送双人免费自助餐</div>
					<div style="margin: 3% 0;font-size: 0.75rem;widht:100%;">
						<div style="float: left;">场地原价：￥499.00</div>
						<div style="float: right;"><i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i><span style="color: red;">700分</span></div>
						<div style="clear:both;"></div>
					</div>
					<div style="margin: 3% 0;font-size: 0.75rem;">会掌柜价：￥297.00</div>
					<div style="margin: 3% 0;font-size: 0.75rem;">
						<div class="btn btn-xs" style="float:left;color:#019FEA;border: 1px solid #019FEA;">不通过</div>
						
						<div class="btn btn-xs bg-type-01" style="float:left;margin-left: 5px;">通过</div>
						<div style="clear:both;"></div>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div class="one-list" style="" item-rdurl="#">
			<div  style="padding-top: 0.5rem;">
				<div style="display:inline-block;float:left;width: 30%;">
					<img alt="" src="http://pic.xiami.net/images/album/img19/72/58a52ddd79908_3642119_1487220189.jpg?x-oss-process=image/resize,limit_0,m_pad,w_185,h_185" style="width: 100%;height: 100%;">
				</div>
				<div  style="float:left;margin-left: 10px;width: 65%;">
					<div class="one-list-ct-title" style="margin: 3% 0;min-height: 40px;widht:100%;height:100%;word-wrap:break-word;word-break:break-all;">标准豪华双人房并赠送双人免费自助餐</div>
					<div style="margin: 3% 0;font-size: 0.75rem;widht:100%;">
						<div style="float: left;">场地原价：￥499.00</div>
						<div style="float: right;"><i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i><span style="color: red;">700分</span></div>
						<div style="clear:both;"></div>
					</div>
					<div style="margin: 3% 0;font-size: 0.75rem;">会掌柜价：￥297.00</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div class="one-list" style="" item-rdurl="#">
			<div  style="padding-top: 0.5rem;">
				<div style="display:inline-block;float:left;width: 30%;">
					<img alt="" src="http://pic.xiami.net/images/album/img19/72/58a52ddd79908_3642119_1487220189.jpg?x-oss-process=image/resize,limit_0,m_pad,w_185,h_185" style="width: 100%;height: 100%;">
				</div>
				<div  style="float:left;margin-left: 10px;width: 65%;">
					<div class="one-list-ct-title" style="margin: 3% 0;min-height: 40px;widht:100%;height:100%;word-wrap:break-word;word-break:break-all;">标准豪华双人房并赠送双人免费自助餐</div>
					<div style="margin: 3% 0;font-size: 0.75rem;widht:100%;">
						<div style="float: left;">场地原价：￥499.00</div>
						<div style="float: right;"><i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i><span style="color: red;">700分</span></div>
						<div style="clear:both;"></div>
					</div>
					<div style="margin: 3% 0;font-size: 0.75rem;">会掌柜价：￥297.00</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div class="one-list" style="" item-rdurl="#">
			<div  style="padding-top: 0.5rem;">
				<div style="display:inline-block;float:left;width: 30%;">
					<img alt="" src="http://pic.xiami.net/images/album/img19/72/58a52ddd79908_3642119_1487220189.jpg?x-oss-process=image/resize,limit_0,m_pad,w_185,h_185" style="width: 100%;height: 100%;">
				</div>
				<div  style="float:left;margin-left: 10px;width: 65%;">
					<div class="one-list-ct-title" style="margin: 3% 0;min-height: 40px;widht:100%;height:100%;word-wrap:break-word;word-break:break-all;">标准豪华双人房并赠送双人免费自助餐</div>
					<div style="margin: 3% 0;font-size: 0.75rem;widht:100%;">
						<div style="float: left;">场地原价：￥499.00</div>
						<div style="float: right;"><i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i>&nbsp;&nbsp;<span style="color: red;">700分</span></div>
						<div style="clear:both;"></div>
					</div>
					<div style="margin: 3% 0;font-size: 0.75rem;">会掌柜价：￥297.00</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div> -->
	</div>
	<form action="" id="form_list_params" style="display:none;">
		<input type="hidden" id="search_EQ_state" name="search_EQ_checkState"  />
		<input type="hidden" id="search_GTE_state" name="search_GTE_checkState"  />
		<input type="hidden" id="search_LTE_state" name="search_LTE_checkState"  />
	</form>
	<c:if test="${groupMap.ishotelsalesdirector }">
		<div qx="integral:add" qxvt="hide" class="export-res-parent" style=""  item-rdurl="${ctx}/weixin/hotel/integral/create">
	    	<div class="export-res-first-line" style="">添加</div>
	    	<div class="export-res-second-line">商品</div>
	     </div>
     </c:if>
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>
<script src="${ctx}/static/weixin/myjs/template.js"></script>
<script src="${ctx}/static/weixin/myjs/common.pager.js"></script>
<script src="${ctx}/static/weixin/myjs/common.permission.js"></script>
<script>
	common.ctx =  '${ctx}';
	var mtype='${mtype}';
	var mposition='${mposition}';
	var mgid='${mgid}';
	var pager = null;
	$(function(){
		//dict.init();
		common.pms.init();
	 	pager = new common.customPage({
			startnow : false,
			url :  '${ctx}/weixin/hotel/integral/list',
			form : $('#form_list_params'),
			jqobj : $('#div_list_parent'),
			tmpid : 'temp_script_hotel_list',
			callback : function(res,$appendContent){
				common.pms.init();
			}
		});  
	 	template.config('escape', false);
		template.helper('state', function(data){
			var html =[];
			console.log(('${groupMap.ishoteladministrator}'=='true'));
			if(data.checkState=='0'&&mtype=='HOTEL'&&'${groupMap.ishoteladministrator}'=='true'){//场地初审
				html.push('<div qx="integral:check" class="btn btn-md btn-blue-plain" style="float:left;padding: 0.2rem 0.5rem;" onclick="nopass('+data.id+')">不通过</div>');
				html.push('<div qx="integral:check" class="btn btn-md bg-type-01 pass" style="float:left;margin-left: 5px;padding: 0.2rem 0.5rem;" onclick="pass('+data.id+')">通过</div>');
				html.push('<div style="clear:both;"></div>');
				return html.join('');
			}else if(data.checkState=='1'&&mtype=='HUI'&&'${groupMap.iscompanysale}'=='true'){//公司销售审核
				html.push('<div qx="integral:check" class="btn btn-md btn-blue-plain" style="float:left;padding: 0.2rem 0.5rem;" onclick="nopass('+data.id+')">不通过</div>');
				html.push('<div qx="integral:check" class="btn btn-md bg-type-01 pass" style="float:left;margin-left: 5px;padding: 0.2rem 0.5rem;" onclick="pass('+data.id+')">通过</div>');
				html.push('<div style="clear:both;"></div>');
				return html.join('');
			}else if(data.checkState=='3'&&mtype=='HUI'&&'${groupMap.iscompanysalesdirector }'=='true'){//运营总监审核
				html.push('<div qx="integral:check" class="btn btn-md btn-blue-plain" style="float:left;padding: 0.2rem 0.5rem;" onclick="nopass('+data.id+')">不通过</div>');
				html.push('<div qx="integral:check" class="btn btn-md bg-type-01 pass" style="float:left;margin-left: 5px;padding: 0.2rem 0.5rem;" onclick="pass('+data.id+')">通过</div>');
				html.push('<div style="clear:both;"></div>');
				return html.join('');
			}else if(data.checkState=='5'){
				return '';
			}else if(data.checkState=='6'){
				return '';
			}/* else{
				html.push('<div qx="integral:check" class="btn btn-md btn-blue-plain" style="float:left;padding: 0.2rem 0.5rem;" onclick="nopass('+data.id+')">不通过</div>');
				html.push('<div qx="integral:check" class="btn btn-md bg-type-01 pass" style="float:left;margin-left: 5px;padding: 0.2rem 0.5rem;" onclick="pass('+data.id+')">通过</div>');
				html.push('<div style="clear:both;"></div>');
				return html.join('');
			}  */
			return '';
		});
		 
	
		
		var $topToolbar = $('#top_toolbar');
		var $topToolbars = $('#top_toolbar .toolbar-one');
		
		//为了列表能滚动而设置高度
		$('#div_list_parent').height($(window).height() - $topToolbar.height());
		$topToolbars.click(function(){	//顶部选择
			var $this = $(this);
			$('#top_toolbar .toolbar-one:not(:eq('+$this.index()+'))').removeClass('icon-arrow-active');
			
			//if(!$this.hasClass('icon-arrow-active')){
				$this.addClass('icon-arrow-active');
				$topToolbar.addClass('toolbar-active')
				//showMaskDiv();
			/* }else{
				$this.removeClass('icon-arrow-active');
				$topToolbar.removeClass('toolbar-active')
				//hideMaskDiv();
			} */
			switch($this.index()){
			case 0:
				$("#search_EQ_state").val('5');
				$("#search_GTE_state").val('');
				$("#search_LTE_state").val('');
				pager.search();
				break;
			case 1:
				$("#search_EQ_state").val('');
				$("#search_GTE_state").val('0');
				$("#search_LTE_state").val('4');
				pager.search();
				break;
			case 2:
				$("#search_EQ_state").val('6');
				$("#search_GTE_state").val('');
				$("#search_LTE_state").val('');
				pager.search();
				break;
			}
		});
		
		$('#top_toolbar .toolbar-one:eq(0)').click();
		
		$(".export-res-parent").click(function(){
			location.href='${ctx}/weixin/hotel/integral/create';
		});
	});
	function nopass(id){
		
		showMaskDiv();
		$.post('${ctx}/weixin/hotel/integral/nopass/'+id,'',function(res){
			toastFn(res.message);
			if(res.statusCode=='200'){
				pager.search();
			}
			hideMaskDiv();
		},'json');
	}
	
	function pass(id){
		showMaskDiv();
		$.post('${ctx}/weixin/hotel/integral/pass/'+id,'',function(res){
			toastFn(res.message);
			if(res.statusCode=='200'){
				pager.search();
			}
			hideMaskDiv();
		},'json');
	}
	
	function showMaskDiv(){
		$('#mask-full-screen').show();
		$('body').css('overflow','hidden');
	}

	function hideMaskDiv(){
		$('body').css('overflow-y','auto');
		$('#mask-full-screen').hide();
	}

	function disabledScroll(event){
		 event.preventDefault();
	};
</script>
<script id="temp_script_hotel_list" type="text/html">
	{{each rows as item i}}
		<div class="one-list" style="" item-rdurl="#">
			<div  style="padding-top: 0.5rem;">
				<div class="bgimg" style="float:left;background-image: url('${ctx}/{{item.img}}');">
					<!-- <img alt="" src="http://pic.xiami.net/images/album/img19/72/58a52ddd79908_3642119_1487220189.jpg?x-oss-process=image/resize,limit_0,m_pad,w_185,h_185" style="width: 100%;height: 100%;"> -->
				</div>
				<div  style="float:left;margin-left: 10px;width: 60%;">
					<div class="one-list-ct-title" style="min-height: 40px;widht:100%;height:100%;word-wrap:break-word;word-break:break-all;">{{item.name}}</div>
					<div style="margin: 3% 0;font-size: 0.95rem;widht:100%;">
						<div style="float: left;">场地原价：￥{{item.price}}</div>
						<div style="float: right;"><i class="ic">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</i><span style="color: red;">{{item.integral}}分</span></div>
						<div style="clear:both;"></div>
					</div>
					<div style="margin: 3% 0;font-size: 0.95rem;">会掌柜价：￥{{item.zgprice}}</div>
					<div style="margin: 3% 0;font-size: 0.75rem;">
						{{item | state}}
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	{{/each}}

</script>
</html>
