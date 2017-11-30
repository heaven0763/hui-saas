<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<style>
	.bgimg{margin-left:5px;padding: 12px;margin-bottom:20px; border: 1px solid #d3d3d3; width: 120px; height: 100px;text-align: center;}
	.bgimg .size{width:80px; height: 80px;}

	 #siteImgSubForm input[type="text"]{width: 400px;}
	 #siteImgSubForm select{width: 180px;}
</style>
<body class="gray-bg">
<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins" style="border: none">
	                   <div class="" style="position: relative;">
	                   		<a href="javascript:loadHotelContent(this,'${ctx}/base/hotel/img/index','');" class="btn btn-warning" style="position: absolute;right: 10px;"><span class="glyphicon glyphicon-arrow-left"> </span> 返回</a>
	                       <h3>${title }图片信息</h3>
	                        <hr/>
	                   </div>
	                   <div class="ibox-content" style="border: none">
	                   <form id="siteImgSubForm" method="post" action="${ctx}/base/hotel/img/save"  class="form-horizontal m-t" >
	                   <input type="hidden" name="siteId" id="id" value="${id}" />
	                   <input type="hidden" name="siteType" id="type" value="${type}" />
	                   <input type="hidden" name="hotelId" id="hotelId" value="${hotelId}" />
						<c:forEach items="${ptypes }" var="pt">
							<div>
								<div class="row">
									<div class="col-sm-12" style="background-color: #048dd3; color: #FFF; padding: 10px;position: relative;">
										<span style="margin-left: 2%;">${pt.name}</span>
										<c:if test="${pt.val ne 'COVER'}">
											<%-- <button type="button" class="btn btn-default" id="site_img_upload_btn_${pt.id}" style="position: absolute;right: 2px;top: 3px;"><span class="glyphicon glyphicon-off"></span> 上传</button> --%>
											<a href="${ctx}/base/hotel/img/toupload?siteId=${id}&hotelId=${hotelId}&siteType=${type}&picType=${pt.val}" target="dialog" class="btn btn-default" title="上传图片" width="800" style="position: absolute;right: 2px;top: 3px;" ><span class="glyphicon glyphicon-plus"> </span> 上传</a>
										</c:if>
										<input type="hidden" value="${pt.val }" id="site_img_type_${pt.id}"/>
									</div>
								</div>
								<div class="row">
									<div id="site_imgs_${pt.id}" class="col-sm-12" style="padding: 20px 10px 10px;">
									<c:choose>
										<c:when test="${pt.val eq 'COVER'}">
											<c:forEach items="${cover }" var="cv">
												<div class="bgimg" style="position: relative;float:left;"> 
													<img class="siteimg size" src="${cv.thumbImg}" url="${cv.originalImg}"></img> 
													<a href="javascript:;" onclick="siteImg_del_fun(${cv.id});" style="position: absolute; top:5px; right:5px;">
														<span class="glyphicon glyphicon-remove-circle" ></span>
													</a>
													
												</div>
											</c:forEach>
										</c:when>
										<c:when test="${pt.val eq 'PANORAMA'}">
											<c:forEach items="${panorama }" var="cv">
												<div class="bgimg" style="position: relative;float:left;"> 
												<img class="siteimg size" src="${cv.thumbImg}" url="${cv.originalImg}"></img> 
												<a href="javascript:;" onclick="siteImg_del_fun(${cv.id});" style="position: absolute; top:5px; right:5px;">
														<span class="glyphicon glyphicon-remove-circle" ></span>
													</a>
												</div>
											</c:forEach>
										</c:when>
										<c:when test="${pt.val eq 'BASEPIC'}">
											<c:forEach items="${basepic }" var="cv">
												<div class="bgimg" style="position: relative;float:left;">
												 	<img class="siteimg size" src="${cv.thumbImg}" url="${cv.originalImg}"></img> 
													<a href="javascript:;" onclick="siteImg_del_fun(${cv.id});" style="position: absolute; top:8px; right:5px;">
														<span class="glyphicon glyphicon-remove-circle" ></span>
													</a>
													<div style="position: absolute;width: 100%;top: -15px;left: 0;text-align: center;">
														<input type="hidden" name="imgid" id=""imgid"" value="${cv.id}" />
														排序<input type="tel" id="" name="sortOrder${cv.id }" value="${cv.sortOrder}" style="width: 40px;">
													</div>
													<div class="cvtips" style="position: absolute;width: 100%;bottom: 0;left: 0;text-align: center;background-color: #000000;opacity:0.8;display: none;">
														<a href="javascript:;" onclick="siteImg_cover_fun(${cv.id})" style="color: #FFF;">设为封面</a>
													</div>
												</div>
											</c:forEach>
										</c:when>
										<c:when test="${pt.val eq 'DIMENSION'}">
											<c:forEach items="${dimension }" var="cv">
												<div class="bgimg" style="position: relative;float:left;">
												 <img class="siteimg size" src="${cv.thumbImg}" url="${cv.originalImg}"></img> <input type="hidden" value="{1}" name="{2}">
												<div style="position: absolute;width: 100%;top: -10px;left: 0;text-align: center;">
													<input type="hidden" name="imgid" id=""imgid"" value="${cv.id}" />
													排序<input type="tel" id="" name="sortOrder${cv.id }" value="${cv.sortOrder}" style="width: 40px;">
												</div>
												 <a href="javascript:;" onclick="siteImg_del_fun(${cv.id});" style="position: absolute; top:8px; right:5px;">
													<span class="glyphicon glyphicon-remove-circle" ></span>
												</a>
												</div>
											</c:forEach>
										</c:when>
										<c:when test="${pt.val eq 'EXTPIC'}">
											<c:forEach items="${extpic }" var="cv">
												<div class="bgimg" style="position: relative;float:left;"> 
												<img class="siteimg size" src="${cv.thumbImg}"></img> <input type="hidden" value="{1}" name="{2}">
												
													<div style="position: absolute;width: 100%;top: -10px;left: 0;text-align: center;">
														<input type="hidden" name="imgid" id=""imgid"" value="${cv.id}" />
														排序<input type="tel" id="" name="sortOrder${cv.id }" value="${cv.sortOrder}" style="width: 40px;">
													</div>
													<a href="javascript:;" onclick="siteImg_del_fun(${cv.id});" style="position: absolute; top:8px; right:5px;">
														<span class="glyphicon glyphicon-remove-circle" ></span>
													</a>
												</div>
											</c:forEach>
											<div id="site_imgs_ext" style="border-bottom: 1px solid #f5f5f5;">
											</div>
											
											<div class="row" >
												<div class="col-sm-12" style="text-align: right;">
													<div class="pull-left pagination-detail" style="margin: 20px 0;">
														<span class="pagination-info">显示第 0 到第 0 条记录，总共 0 条记录</span>
														<span class="page-list">
															每页显示 
															<span class="page-size">18</span>
															条记录
														</span>
													</div>
													<ul class="pagination"></ul> 
												</div>
											</div>
										</c:when>
									</c:choose>
									
									</div>
								</div>
							</div>
						</c:forEach>
						</form>
						<hr/>
						<button type="button" class="btn btn-primary" style="width: 160px;" onclick="saveSortOrder();"><span class="glyphicon glyphicon-save"></span> 保存</button>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			var img_str = '<div class="bgimg" style="position: relative;float:left;"> <img id="img" src="{0}" class="size"></img> <input type="hidden" value="{1}" name="{2}">'
				   +'<a href="javascript:;" onclick="javascript:$(this).parent().remove();" style="position: absolute; top:5px; right:5px;"><span class="glyphicon glyphicon-remove-circle" ></span></a>';
				
			$().ready(function() {
				$(".bgimg").hover(function(){
				    $(this).find(".cvtips").show();
				},function(){
				  	$(this).find(".cvtips").hide();
				});
				
				
				 template.config('escape', false);
				$(".siteimg").click(function(){
					var imgs = [];
					var url = $(this).attr('url');
					imgs.push({href:url})
					$(this).parent().parent().find('img').each(function(){
						if(url===$(this).attr('url')){
							
						}else{
							imgs.push({href:$(this).attr('url')})
						}
					});
					$.fancybox.open(imgs);
				});
				
				/* $.getScript('${ctx}/static/plugins/kindeditor-4.1.10/kindeditor.js', function() {
					KindEditor.basePath = '${ctx}/static/plugins/kindeditor-4.1.10/';
					var editor = KindEditor.editor({
				        uploadJson: '${ctx}/base/hotel/img/upload',
				        allowFileManager : false
				    });
					<c:forEach items="${ptypes }" var="pt">
					KindEditor('#site_img_upload_btn_${pt.id}').click(function() {
						try{
							editor.loadPlugin('multiimage', function() {
					            editor.plugin.multiImageDialog({
					                clickFn : function(urlList) {
				                	    var url = $("#siteImgSubForm").attr("action");
				                	    var picType=$("#site_img_type_${pt.id}").val();
				                	    var imgs = [];
				                	    $.each(urlList,function(index,item){
				                	    	imgs.push(item.url);
				                	    });
							            var data = {imgs: imgs.join(','),picType:picType,siteId:'${id}',siteType:'${type}',hotelId:'${hotelId}'};
							            editor.hideDialog();
							            show();
					                	$.post(url,data,function(res){
					                		if(res.statusCode==="200"){
					                			loadHotelContent(this,'${ctx}/base/hotel/img/create?id=${id}&type=${type}','');
					                		}
					                		hide();
					                	},"json");
					                	
					                }
					            });
					        });
						}catch(err){
							alert(err);
						}
				    	
				    });
					</c:forEach>
				}); */
				loadExtPic(1);
			});
			function siteImg_del_fun(id){
				confirmFun("您确定要删除这条信息吗","删除后将无法恢复，请谨慎操作！","删除",'${ctx}/base/hotel/img/delete/'+id,"");
			}
			function siteImg_cover_fun(id){
				confirmFun("您确定要把这张图设为封面吗？","","设为封面",'${ctx}/base/hotel/img/cover/'+id,"");
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
			    		show();
			   	     	$.post(url, data, function (res, status) { 
			   	     		if(status=="success"&&res.statusCode=="200"){
			   	     			swal(res.message,"success");
			   	     			loadHotelContent(this,'${ctx}/base/hotel/img/create?id=${id}&type=${type}','');
			   	     		}else{
			   	     			swal(res.message, "error");
			   	     		}
			   	     		hide();
			   	     	}, 'json');
					} else {
						swal("已取消", "您取消了"+ctype+"操作！", "error")
					}
			    });
				
			}
			function loadPlace(val){
				var hotelId=$("#hotelId").val();
				if(hotelId==''){
					swal("请先选择所属场地！", "error");
					return;
				}
				var url = '${ctx}/framework/dictionary/trslCombox?sql=';
				var pls = '<option value="">请选择...</option>';
				if("HOTEL"===val){
					url += 'SELECT id,hotel_name as name FROM hui_hotel where state = \'1\' and id=${mhotel.id}';
				}else if("HALL"===val){
					url += 'SELECT id,place_name as name FROM hui_hotel_place where state = \'1\' and place_type =\'HALL\' and hotel_id=${mhotel.id}';
				}else if("ROOM"===val){
					url += 'SELECT id,place_name as name FROM hui_hotel_place where state = \'1\' and place_type =\'ROOM\' and hotel_id=${mhotel.id}';
				}
				
				$.get(url, function (res, status) { 
					var str = '';
					if(status=="success"){
						str = pls;
						$.each(res, function(i, item){
							str+='<option value="'+item.value+'">'+item.text+'</option>';
						});
						
						$("#siteId").html(str);
						$("#siteId").selectpicker('refresh');
					}
				}, 'json');
			}
			function saveSortOrder(){
				var data = $("#siteImgSubForm").serialize();
				var url = '${ctx}/base/hotel/img/sort/save';
				show();
				$.post(url,data,function(res){
	   	     		if(res.statusCode=="200"){
	   	     			swal(res.message,"success");
	   	     			loadHotelContent(this,'${ctx}/base/hotel/img/create?id=${id}&type=${type}','');
	   	     		}else{
	   	     			swal(res.message, "error");
	   	     		}
	   	     		hide();
				},'json');
			}
			
			function loadExtPic(page){
				$("#site_imgs_ext").empty();
				var url = '${ctx}/base/hotel/img/getPiclist';
				var data = {search_EQ_siteId:'${id}',search_EQ_siteType:'${type}',search_EQ_picType:'EXTPIC',page:page,rows:18,sort:'sortOrder',order:"asc"}
				$.post(url,data,function(res){
   	     			if (res != null) {//DOM操作
	   	     			var html = template('extpic_temp_list_script', res);
	   	     			html+='<div style="clear:both;"></div>';
   	     				var	$html = $(html);
   	     				$html.find(".siteimg").click(function(){
							var imgs = [];
							var url = $(this).attr('url');
							imgs.push({href:url})
							$(this).parent().parent().find('img').each(function(){
								if(url===$(this).attr('url')){
								}else{
									imgs.push({href:$(this).attr('url')})
								}
							});
							$.fancybox.open(imgs);
						});
	   	     		    $("#site_imgs_ext").html($html);
	   	     			extpic_AjaxPaginator($('.pagination'),res);
		   	     		var fir = (res.currtPage-1)*18+1;
						var end = (res.currtPage-1)*18+res.rows.length;
	   	     			extpic_paginationDetail(fir,end,res.total,18);
   	     			}else{
   	     				extpic_paginationDetail(1,0,0,18);
   	     			}
	   	     		hide();
				},'json');
			}
			
			function extpic_AjaxPaginator(obj,data) {
				var currentPage = 1;//data.currtPage || 1;
				var totalPages = data.totalPage || 1;//data.total/dynamic_rows;
				var options = {
					currentPage : currentPage, //当前页
					totalPages : totalPages, //总页数
					numberOfPages : 5, //设置控件显示的页码数
					bootstrapMajorVersion : 3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
					useBootstrapTooltip : true,//是否显示tip提示框
					onPageClicked : function(event, originalEvent, type, page) {
						loadExtPic(page);
					}
				}
				obj.bootstrapPaginator(options);
			}
			
			function extpic_paginationDetail(fir,end,total,rows){
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
		</script>
<script id="extpic_temp_list_script" type="text/html">
	{{each rows as item i}}
		<div class="bgimg" style="position: relative;float:left;"> 
			<img class="siteimg size" src="{{item.thumbImg}}" url={{item.originalImg}}></img> 
			<div style="position: absolute;width: 100%;top: -10px;left: 0;text-align: center;">
				<input type="hidden" name="imgid" id=""imgid"" value="{{item.id}}" />
				排序<input type="tel" id="" name="sortOrder{{item.id}}" value="{{item.sortOrder}}" style="width: 40px;">
			</div>
			<a href="javascript:;" onclick="siteImg_del_fun({{item.id}});" style="position: absolute; top:8px; right:5px;">
				<span class="glyphicon glyphicon-remove-circle" ></span>
			</a>
		</div>
	{{/each}}	
</script>
</div>

