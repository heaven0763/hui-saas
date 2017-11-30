<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html style="">
<head>
	<title>我要BOOKING</title>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="${ctx}/tuodanstar.ico"/>
	<link rel="bookmark" href="${ctx}/tuodanstar.ico"/>
    <meta name="viewport" content="target-densitydpi=device-dpi, width=device-width, initial-scale=1, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link href="${ctx}/static/weixin/css/common.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/transaction.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/tools.css" rel="stylesheet" />
    <link href="${ctx}/static/weixin/css/main.css" rel="stylesheet" />
   
    <style>
   		
   		.arr-down{background-image: url('${ctx}/static/weixin/css/icon/common/arrow-down.png');background-position: 90% 50%;background-repeat: no-repeat;background-size:20px; }
    </style>
    
</head>

<body class="" style="height:100%;">
	<div id="mask-full-screen" class="window-mask mask-full-screen"></div>
	<form id="form_booking" action="${ctx}/weixin/schedulebooking/place/booking/save" method="post" class="form-control" style="">
		<input type="hidden" id="hotelId" name="hotelId" value="${hall.hotelId }">
		<input type="hidden" id="placeId" name="placeId" value="${hall.id }">
		<div class="form-group" style="">
			<div style="">预定场地：</div>
			<div class="input-parent" style=" ">
				<input class="input-form" name="rname" type="text" style="" value="${hall.hotelName}——${hall.placeName }" readonly="readonly"/>
			</div>
		</div>
		<div class="form-group" style="">
			<div style="">销售人员：</div>
			<div class="input-parent" style=" ">
				<input class="input-form" name="username" type="text" style="" value="${sale }" readonly="readonly"/>
			</div>
		</div>
		<div class="form-group" style="">
			<div style="">预定日期：</div>
			<div class="input-parent" style=" ">
				<input class="input-form" name="placeDate" type="date" style="" value="${placeDate}"/>
			</div>
		</div>
		<div class="form-group" style="">
			<div style="">预定档期：</div>
			<div class="input-parent" style=" ">
				<div class="timesolt input-form" style="position: relative;" tabindex="1" hallid="${hall.id }">
					<input type="hidden" id="scheduleTime" name="scheduleTime" value="">   
					<input type="hidden" id="scheduleTimeTxt" name="scheduleTimeTxt" value="">   
					<div id="scheduleTimeTxtdv" style="width: 100%;height:35px; border: 1px solid #ccc; border-radius: 4px;line-height: 35px;" class="arr-down"  >
						<span  class="timesolt-text" style="height:35px;line-height: 35px;padding: 0 5px;">  请选择</span>
						<!-- <i class="" style="    font-size: 3em;"></i> -->
					</div>
					<div  class="timesolt-item" tabindex="2" style="position: absolute;left: 0;top: 35px;
					background-color: #ffffff;width:100%;display: none;z-index: 2000;color: #000000;">
						<c:forEach items="${ctimes}" var="ctme">
							<div style="width: 100%;height:30px; border: 1px solid #999999;">
								<label for="timesolt_${ctme.id}" style="width:100%;line-height:30px;vertical-align:middle;">
									<input class="timesolt-select-item" id="timesolt_${ctme.id}" type="checkbox" name="timesolt" value="${ctme.id}"  style="margin:9px;" data="${ctme.name}" ${ctme.name eq bookingRecordModel.placeSchedule?'checked="checked"':''}>
									${ctme.name}
								</label>
							</div>
						</c:forEach>
						<div style="width:100%;height:30px;border:1px solid #999999;">
							<label for="timesolt_all" style="width:100%;line-height:30px;vertical-align:middle;">
								<input class="timesolt-select-item timesolt_all" id="timesolt_all" type="checkbox" name="timesolt" value="ALL" style="margin:9px;" data="全天" >
								全天
							</label>
						</div>
						<div style="width:96%;height:40px;border:1px solid #999999;text-align: center;padding: 2%;">
							<button type="button"  class="btn bg-type-01 btn-sm timesolt-select"  style="width: 40%;padding: 0.4rem 0;"  >确定</button>
							<button type="button"  class="btn bg-type-02 btn-sm timesolt-cancel"  style="width: 40%;padding: 0.4rem 0;"  >取消</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group" style="">
			<div style="">活动名称：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required" id="input-mobile" name="activityTitle" type="text" style=""/>
			</div>
		</div>
		<div class="form-group" style="">
			<div style="">公司名称：</div>
			<div class="input-parent" style=" ">
				<input class="input-form" name="company" type="text" style=""/>
			</div>
		</div>
		<div class="form-group" style="">
			<div style="">客户姓名：</div>
			<div class="input-parent" style=" ">
				<input class="input-form" name="linkman" type="text" style=""/>
			</div>
		</div>
		<div class="form-group" style="">
			<div style="">手机号码：</div>
			<div class="input-parent" style=" ">
				<input class="input-form cellPhone" id="input-mobile" name="mobile" type="text" style=""/>
			</div>
		</div>
		<div class="form-group" style="">
			<div style="">电子邮箱：</div>
			<div class="input-parent" style=" ">
				<input class="input-form" id="input-email" name="email" type="email" style=""/>
			</div>
		</div>
		<!-- <div class="form-group" style="">
			<div style="">活动日期：</div>
			<div class="input-parent" style=" ">
				<input class="input-form required" id="input-mobile" name="activityDate" type="date" style=""/>
			</div>
		</div> -->
		
	</form>
	<div  style="padding: 0.8rem 2%;">
		<div id="btn_booking" class="btn btn-lg bg-type-01"  style="width:100%;margin:0 auto;margin:3rem 0;border-radius:3px;">我要BOOKING</div>
	</div>
	<!-- <div id="btn_booking" class="btn btn-lg bg-type-01" style="width:90%;margin:0 auto;position:fixed;left:5%;bottom:5%;border-radius: 3px;"></div> -->
</body>

<script src="${ctx}/static/weixin/myjs/jquery-1.7.2.min.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
<script src="${ctx}/static/weixin/myjs/jquery.validate.extend.js"></script>
<script src="${ctx}/static/weixin/myjs/tools.js"></script>
<script src="${ctx}/static/weixin/myjs/common.js"></script>
<script src="${ctx}/static/weixin/myjs/common.ajax.js"></script>
<script src="${ctx}/static/weixin/myjs/common.delegate.js"></script>

<script>

$(function(){
	common.ctx =  '${ctx}';
	
	var $form = $('#form_booking');
	$form.validate();
	
	$('#btn_booking').click(function(){
		var scheduleTime = $("#scheduleTime").val()+"";
		if(scheduleTime==''){
			 common.toast('请选择档期！');
			 return;
		}
		common.submitForm($form,function(res){
			 common.toast('提交成功！');
			// $(".mask-full-screen").show();
			 setTimeout(function(){
				 history.back(-1);
			 },1500);
         },function(res){
        	 common.toast(res.message);
        	 $(".mask-full-screen").hide();
         });
		
	});
	
	$(".timesolt").focus(function(){
		var $this = $(this);
		var tabindex = $this.attr('tabindex');
		//$this.attr('tabindex',-1);
		//$this.css("height","240px");
		var hallId = $this.attr("hallid");
		var scheduleDate =$('input[name="placeDate"]').val();
		var hotelId = '${order.hotelId}';
		var scheduleTime = $("#scheduleTime").val();
		$.get('${ctx}/weixin/order/hall/schedule/info',{hotelId:hotelId,placeId:hallId,scheduleDate:scheduleDate},function(res){
			if(res.statusCode==='200'){
				var k =0;
				for(var i=0;i<res.object.length;i++){
					var id='#'+res.object[i].id;
					$this.find('input[id="timesolt_'+res.object[i].placeSchedule+'"]').attr("price",res.object[i].onlinePrice);
					if(res.object[i].state==='2'&&res.object[i].orderNo!='${order.orderNo}'){
						$("#timesolt_"+res.object[i].placeSchedule).attr("disabled","disabled");
						k++;
					}
					if(scheduleTime.indexOf(res.object[i].placeSchedule)>=0){
						$("#timesolt_"+res.object[i].placeSchedule).attr("checked","checked"); 
					}
				}
				
				if(k!=0){
					$this.find('input[id="timesolt_all"]').attr("disabled","disabled");
				}
				
				$this.find('.timesolt-item').show();
			}else{
				swal(res.message,'success');
			} 
		},"json");
		
	});
	/* 
	$(".timesolt-item").focus(function(){
		$('.timesolt-item').show();
	});
	$(".timesolt").blur(function(){
		var $this = $(this);
		setTimeout(function(){
			$this.find('input[type="checkbox"]').removeAttr("checked"); 
			$('input[name="scheduleTimeTxt"]').val('');
			$('input[name="scheduleTime"]').val('');
			$('#scheduleTimeTxtdv').text('');
			$this.find('.timesolt-item').hide();
		},300)
		
		
	}); */
	$(".timesolt-cancel").click(function(){
		$('.timesolt-item').hide();
	});
	$(".timesolt-select").click(function(){
		var $this = $(this);
		$this.attr('tabindex',1);
		$this.parent().parent().hide();
		var sles = [];
		var slestxt = [];
		var hallId = $this.attr('hallId');
		var n = 0;
		var sumPrice = 0;
		$this.parent().parent().find('input[type="checkbox"]:checked').each(function(){
			var $self = $(this);
			if($self.val()!='ALL'){
				sles.push($self.val());
				slestxt.push($self.attr('data'));
				n++;
			}
		});
		$this.parent().parent().prev().text(slestxt.join(','));
		$('input[name="scheduleTimeTxt"]').val(slestxt.join(','));
		$('input[name="scheduleTime"]').val(sles.join('#'));
	});
	
	$(".timesolt-select-item").change(function(){
		var $this = $(this);
		if($this.val()=='ALL'&&$(this).attr("checked")){
			$this.parent().parent().parent().find('input[type="checkbox"]').attr("checked","checked"); 
		}else if($this.val()=='ALL'&&!$(this).attr("checked")){
			$this.parent().parent().parent().find('input[type="checkbox"]').removeAttr("checked"); 
		}else if(!$(this).attr("checked")){
			$this.parent().parent().parent().find('.timesolt_all').removeAttr("checked"); 
		}
		
	});
	
});
</script>
</html>
