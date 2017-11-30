<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<script type="text/javascript">
$().ready(function() {
	$('.selectpicker').selectpicker();
	/* 
	
	'bold', 'italic', 'underline', 'fontborder', 'strikethrough',  'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',  
                   'rowspacingtop', 'rowspacingbottom', 'lineheight' 
	
	*/
	/* var hg_editor = new UE.ui.Editor({
        //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
        toolbars:[],
        //关闭字数统计
        wordCount:false,
        //关闭elementPath
        elementPathEnabled:false,
        //默认的编辑区域高度
        initialFrameHeight:150
    });
	hg_editor.render("introduction"); */
	
	
    var e = "<i class='fa fa-times-circle'></i> ";
	$("#hotelGroupSubForm").validate({
        rules: {
        	name: "required"
        },
        messages: {
        	name: e + "请输入集团名称"
        },
        submitHandler: function(form) {
            var url = $(form).attr("action");
            var data = $(form).serialize();
            parent.show();
       　		$.post(url, data, function (res, status) { 
       　			if(status=="success"&&res.statusCode=="200"){
       　				$('#close_btn').click();
       　				swal(res.message, "success");
       　				hotelGroup_search();
       　			}else{
       　				swal(res.message, "error");
       　			}
       　			parent.hide();
       　		}, 'json'); 
         }  
    });
	$.getScript('${ctx}/static/plugins/kindeditor-4.1.10/kindeditor.js', function() {
		KindEditor.basePath = '${ctx}/static/plugins/kindeditor-4.1.10/';
		var editor = KindEditor.editor({
	        uploadJson: '${ctx}/base/hotel/img/upload',
	        allowFileManager : false
	    });
		KindEditor('#WX_icon').click(function() {
			try{
				editor.loadPlugin('image', function() {
		            editor.plugin.imageDialog({
		            	showRemote: false,
		                clickFn : function (url, message, error) {
		                	swal("上传成功", "success");
 	                        $('input[name="logo"]').val(url);
 	   						$('#WX_icon').attr('src', url);
	                        editor.hideDialog();
 	                     }
		            });
		        });
			}catch(err){
				alert(err);
			}
	    	
	    });
	});
});
</script>
<div class="modal-body"> 
  
<form id="hotelGroupSubForm" method="post" action="${ctx}/base/hotel/group/save"  class="form-horizontal m-t" ><!--   -->
  <input type="hidden" name="id" id="id" value="${hotelGroup.id}" />
  <input type="hidden" name="logo" id="logo" value="${hotelGroup.logo}" >
  <input type="hidden" name="state" id="state" value="${hotelGroup.state}" >
 	<div class="form-group form-inline" style="height: 50px;">
		<label for="picurl" class="col-sm-2 control-label">场地LOGO</label>
		<div class="col-sm-10">
			<div class="add" style="position: relative; margin-left: 1rem; height: 5.0rem; width: 10.0rem;">
				<img id="WX_icon" src="${hotelGroup.logo}" onerror="javascript:this.src='${ctx}/public/css/images/add-img.png'" style="height: 5.0rem; width: 10.0rem;border: 1px solid #f5f5f5;" /> 
			</div>
		</div>
	</div>
  <div class="form-group form-inline">
	    <label for="name" class="col-sm-2 control-label">集团名称</label>
	     <div class="col-sm-10">
	     	<input type="text" class="form-control" name="name" data-options="required:true" value="${hotelGroup.name}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
  </div>
	  <div class="form-group form-inline">
	    <label for="linkman" class="col-sm-2 control-label">联系人</label>
	     <div class="col-sm-10">
	     	<input type="text" class="form-control" name="linkman" data-options="required:true" value="${hotelGroup.linkman}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="tel" class="col-sm-2 control-label">联系电话</label>
	     <div class="col-sm-10">
	     	<input type="text" class="form-control" name="tel" data-options="required:true" value="${hotelGroup.tel}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="email" class="col-sm-2 control-label">邮箱</label>
	     <div class="col-sm-10">
	     	<input type="text" class="form-control" name="email" data-options="required:true" value="${hotelGroup.email}" aria-required="true" aria-invalid="false" class="valid" />
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="city" class="col-sm-2 control-label">所属城市</label>
	     <div class="col-sm-10">
	     	<select class="form-control selectpicker" data-live-search="true" data-width="auto" data-size="10"   id="city" name="city"  >
	     		<tags:dict sql="SELECT id id,region_name name FROM hzg_saas.hui_region where region_type = 2 order by zimu asc " selectedValue="${hotelGroup.city}"  showPleaseSelect="fasle" addBefore=",全部"/>
			</select>
	    </div>
	  </div>
				
	  <div class="form-group form-inline">
	    <label for="introduction" class="col-sm-2 control-label">场地简介</label>
	     <div class="col-sm-10">
	     	<script id="introduction" name="introduction" type="text/plain"></script>
	     	<textarea class="form-control" name="introduction" style="width: 100%;height: 150px;">${hotelGroup.introduction}</textarea>
	    </div>
	  </div>
	  <div class="form-group form-inline">
	    <label for="memo" class="col-sm-2 control-label">备注</label>
	     <div class="col-sm-10">
	     	<textarea class="form-control" name="memo" style="width: 100%;height: 80px;">${hotelGroup.memo}</textarea>
	    </div>
	  </div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal"><span class="glyphicon glyphicon-off"></span> 关闭</button>
		<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span> 保存</button>
	</div>
</form>
</div>

