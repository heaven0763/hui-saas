<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
	<title>加入团队</title>
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/common.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/bootstrap/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/font-awesome.min93e3.css?v=4.4.0">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/newmain.css"> 
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/sk.css"> 
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/plugins/sweetalert/sweetalert.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/public/hplus/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css">
	<link type="text/css" rel="stylesheet" href="${ctx}/static/resource/css/bootstrap-select.min.css" />
	<style type="text/css">
		.toBottom {
		  background-image:-webkit-linear-gradient(to bottom, #dddee0, #ffffff);
		  background-image:linear-gradient(to bottom, #dddee0, #ffffff);
		}
		.width1200 {
		    width: 1280px;
		    margin: 0 auto;
		    overflow: hidden;
		}
		.error{color: red;}
		i{font-style: normal;color: red;}
		.sfsel{padding: 16px 12px;}
		.teams-hide{display: none;}
		.teams-menu {
		    position: absolute;
		    top: -320px;
		    left: 0;
		    z-index: 1000;
		    float: left;
		    min-width: 160px;
		    padding: 5px 0;
		    margin: 2px 0 0;
		    font-size: 14px;
		    text-align: left;
		    list-style: none;
		    background-color: #fff;
		    -webkit-background-clip: padding-box;
		    background-clip: padding-box;
		    border: 1px solid #ccc;
		    border: 1px solid rgba(0,0,0,.15);
		    border-radius: 4px;
		    -webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
		    box-shadow: 0 6px 12px rgba(0,0,0,.175);
		}
		.dd{cursor: pointer;padding: 5px;color: #008cd6;}
		.selected{background-color: #008cd6;color: #FFF; }
	</style>
	<script src="${ctx}/public/hplus/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctx}/public/hplus/js/bootstrap.min.js?v=3.3.6"></script>
	<script src="${ctx}/public/hplus/js/plugins/sweetalert/sweetalert.min.js"></script>
</head>
<body>
	<div class="header">
		<div style="background: #04184a;">
		    <div class="geren" style="padding: 30px;color: #ffffff;margin-left: 10%;">
                    <div style="letter-spacing: 5px;font-size: 36px;height: 60px;float: left;"> 场地管理SAAS系统</div>
                    <div style="height: 60px;float: left;margin: 10px;">
                   		<a href="${ctx}/login" style="border: 1px solid #ffffff;height: 40px;line-height:40px;border-radius: 5px;cursor: pointer;color: #ffffff;padding: 0 20px;">加入团队</a>
                    </div>
                     <div style="height: 60px;float: right;margin-right: 20%;;margin-top: 10px;">
                     <a href="${ctx}/login" style="color: #ffffff;cursor: pointer;">已有账号？请登录</a>
                     </div>
	                <div style="clear: both;"></div>
	        </div>
		</div>
	</div>
	<div class="sjzx">
		<div class="sjzxnav" style="height: 12px;">
		</div>
	</div>
	<div class="sjzx">
		<div class="toBottom" style="height: 24px;">
		</div>
	</div>
	<div class="content" style="background-color:#fcfdff;">
		<div id="pcontent" class="width1200 jiudianxq grdpxq sjzx" style="min-height:664px;position: relative;background-color:#fcfdff;padding: 0 10px;">
			<div style="margin-top: 80px;"></div>
			<div class="row" style="padding:15px 50px;">
				<div class="col-sm-12 step3">
				
				</div>
			</div>
			<div class="row" style="padding: 15px 50px;text-align: center;">
				<div class="col-sm-3 step-txt step-active" style="">
					填写个人信息 &nbsp;&nbsp;
				</div>
				<div class="col-sm-2">
					<div></div>
				</div>
				<div class="col-sm-2 step-txt step-active">验证账号</div>
				<div class="col-sm-2"></div>
				<div class="col-sm-3 step-txt step-active" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加入团队</div>
			</div>
			
			<div class="row" style="padding:15px 0;">
				<div class="col-sm-12">
				<hr style="border-top: 4px solid #eee;"/>
				</div>
			</div>
			
			<form id="form" action="${ctx}/anon/dojoin" method="post" class="" style="">
				<input id="uid" name="uid" type="hidden" value="${reguser.id}">
				<div class="row">
					<div class="col-sm-12 step-txt" style="text-align: center;">
						<span  style="line-height: 60px;color:#333;">亲，您的账号${reguser.mobile}还没有加入任何团队哦，您可以通过一下方式快速体验！</span>
					</div>
				</div>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
						<span  style="line-height: 54px;color:#333;">邀请码：</span>
					</div>
					<div class="col-sm-8 step-txt">
						<input type="text" maxlength="11" id="ivcode" name="ivcode" class="form-control m-b" placeholder="非必填"  style="display: inline-block;width: 50%;height: 34px;padding: 24px 12px;"/>
					</div>
				</div>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-12 step-txt" style="text-align: center;">
						<h3  style="color:#333;margin: 0;">请选择团队</h3>
					</div>
				</div>
				<hr>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
						<span  style="line-height: 54px;color:#333;">团队名称<i>*</i></span>
					</div>
					<div class="col-sm-8 step-txt">
						<div class="" style="width: 360px;padding: 0px;margin: 0px;position: relative;">
							<input id="teamtype" name="teamtype" type="hidden" value="">
							<input id="teamid" name="teamid" type="hidden" value="">
							<button id="selteams" type="button" class="btn btn-default" style="width: 360px;padding: 16px 12px; ">
								<span id="teamtx" class="pull-left" style="width: 320px;text-align: left;">请选择</span>
								<span class="bs-caret"><span class="caret"></span></span>
							</button>
							<div id="tesl" class="teams-menu teams-hide" style="min-width: 360px; max-height: 314px;min-height: 314px; overflow: hidden;">
							   <div style="padding: 4px 8px;">
							    <input id="teamkey" type="text" class="form-control"  onkeyup="selectTeam(this);" onchange="selectTeam(this);" />
							   </div>
							   <div id="teamlist" style="max-height: 260px; overflow-y: auto;margin-top: 10px;">
							    
							  </div>
							  </div>
						</div>
					</div>
				</div>
				<%-- <div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
					<span  style="line-height: 54px;color:#333;">团队名称<i>*</i></span>
					</div>
					<div class="col-sm-8 step-txt">
						 <select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="hotelId" name="hotelId" data-style="sfsel">
							<tags:dict sql="SELECT id,hotel_name as name FROM hui_hotel "  showPleaseSelect="false" addBefore=",全部;0,会掌柜"/>
						</select> 
					</div>
				</div> --%>
				<div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
					</div>
					<div class="col-sm-8 step-txt">
						 <button id="btn_submit" class="btn btn-success" style="display: inline-block;width: 300px;font-size: 20px;font-weight: 300;padding: 12px 12px;" type="button">加入团队</button>
					</div>
				</div>
				
				
				
				<!-- <div class="row" style="padding:10px 25px;">
					<div class="col-sm-4 step-txt" style="text-align: right;">
					</div>
					<div class="col-sm-8 step-txt">
						 <button id="btn_jointeam" class="btn btn-success" style="display: inline-block;width: 240px;font-size: 20px;font-weight: 300;padding: 12px 12px;" type="button">完成，进入体验</button>
						 <button id="btn_reset" class="btn btn-default" style="display: inline-block;width: 60px;font-size: 20px;font-weight: 300;padding: 12px 12px;" type="reset">重置</button>
					</div>
				</div> -->
				</form>
				<script src="${ctx}/static/weixin/myjs/jquery.validate.js"></script>
				<script src="${ctx}/static/weixin/myjs/jquery.metadata.js"></script>
				<script type="text/javascript">
					var flag = 0;
					$(function(){
						
						var ff='<div class="spiner-example" style="padding-top: 400px;"><div class="sk-spinner sk-spinner-fading-circle" style="width:64px;height:64px;">'
						   	+' <div class="sk-circle1 sk-circle"></div>'
						   	+' <div class="sk-circle2 sk-circle"></div>'
						   	+' <div class="sk-circle3 sk-circle"></div>'
						   	+' <div class="sk-circle4 sk-circle"></div>'
						   	+' <div class="sk-circle5 sk-circle"></div>'
						   	+' <div class="sk-circle6 sk-circle"></div>'
						   	+' <div class="sk-circle7 sk-circle"></div>'
						   	+' <div class="sk-circle8 sk-circle"></div>'
						   	+' <div class="sk-circle9 sk-circle"></div>'
						   	+' <div class="sk-circle10 sk-circle"></div>'
						   	+' <div class="sk-circle11 sk-circle"></div>'
						   	+' <div class="sk-circle12 sk-circle"></div></div></div>';
					   	var $maskDiv=  $('<div id="marks" class="modal-backdrop fade in" style="z-index:10000;display:none;">'+ff+'</div>').appendTo('body');
						   	
						
						
						 selectTeam();
						$("#selteams").click(function(){
							$("#tesl").toggleClass('teams-hide');
						});
						$('#btn_submit').click(function(){
							var teamid = $("#teamid").val();
							if(teamid==null||teamid===""){
								swal("请选择团队！","error");
								return;
							}
							var teamtype = $("#teamtype").val();
							if(flag==0){
								flag = 1;
								$maskDiv.show();
								$.post('${ctx}/anon/dojoin',{teamid:teamid,teamtype:teamtype},function(res){
									if(res.statusCode==="200"){
										swal(res.message,"success");
										setTimeout(function(){
											location.href="${ctx}/login";
										},3000);
									}else{
										swal(res.message,"error");
										flag = 0;
										$maskDiv.hide();
									}
								},"json");
							}
						});
						
						$('#btn_jointeam').click(function(){
							location.href="${ctx}/login";
						});
					});
					function selectTeam(self){
						var key = "";
						if(self){
							$this = $(self);
							var key = $this.val();
						}else{
							key="TOP";
						}
						$("#teamlist").empty();
						$("#teamlist").off();
						if(key){
						var url = '${ctx}/anon/getteams'
							$.post(url,{name:key},function(res){
								var items = [];
								for(var i=0;i<res.object.length;i++){
									var obj = res.object[i];
									items.push('<div data-id="'+obj.id+'" data-type="'+obj.type+'" data-name="'+obj.name+'" class="dd">'+obj.name+'</div>');
								}
								var hml = items.join('');
								$("#teamlist").html(hml);
								$("#teamlist").find('.dd').click(function(){
									var $_this = $(this);
									$("#teamlist").find('.dd').removeClass('selected');
									$_this.addClass('selected');
									$("#teamid").val($_this.attr('data-id'));
									$("#teamtype").val($_this.attr('data-type'));
									$("#teamtx").text($_this.attr('data-name'));
									$("#tesl").toggleClass('teams-hide');
								});
							},'json');
						}else{
							$("#teamtx").text('请选择');
						}
					}
				</script>
		</div>
	</div> 
	 <div class="footer" style="height: 85px;width: 100%;">
		 <hr style="border-top: 4px solid #eee;padding:0;"/>
	    <div style="background: #fcfdff;">
	        <div class="width1000" style="color: #c8c8c9;text-align: center;vertical-align: middle;">
	             &copy;2012-2017会掌柜  版权左右  ALL Right Reserved(粤ICP备15048082号-1)
	        </div>
	    </div>
	</div> 

</body>
</html>