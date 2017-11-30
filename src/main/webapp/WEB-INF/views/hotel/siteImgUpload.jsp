<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/include.inc.jsp"%>
<div class="modal-body">	
<form id="img_upd_form">
<input type="hidden" id="hotelId" name="hotelId" value="${hotelId}">
<input type="hidden" id="siteId" name="siteId" value="${siteId}">
<input type="hidden" id="siteType" name="siteType" value="${siteType}">
<input type="hidden" id="picType" name="picType" value="${picType}">
<div id="uploader-demo" class="wu-example">
    <!--用来存放文件信息-->
    <div class="btns">
        <input id="myupload" class="myupload"  type="file" multiple="multiple"  accept="image/gif, image/jpeg, image/png, image/jpg, image/bmp" />
        <div id="queue"></div>
    </div>
    <div id="thelist" class="uploader-list" style="padding: 5px;border: 3px dashed #e6e6e6;min-height: 350px;"></div>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" id="close_btn" data-dismiss="modal">
		<span class="glyphicon glyphicon-off"></span> 关闭
	</button>
	<button type="button" class="btn btn-default" onclick="saveImg()">
	 	<span class="glyphicon glyphicon-save"></span> 全部插入
	</button>
</div>
</form>
<style>


#uploader-demo .thumbnail {
    width: 110px;
    height: 110px;
}
#uploader-demo .thumbnail img {
    width: 100%;
}
.uploader-list {
    width: 100%;
    overflow: hidden;
}
.file-item {
    float: left;
    position: relative;
    margin: 0 20px 20px 0;
    padding: 4px;
}
.file-item .error {
    position: absolute;
    top: 4px;
    left: 4px;
    right: 4px;
    background: red;
    color: white;
    text-align: center;
    height: 20px;
    font-size: 14px;
    line-height: 23px;
}
.file-item .info {
    position: absolute;
    left: 4px;
    bottom: 4px;
    right: 4px;
    height: 20px;
    line-height: 20px;
    text-indent: 5px;
    background: rgba(0, 0, 0, 0.6);
    color: white;
    overflow: hidden;
    white-space: nowrap;
    text-overflow : ellipsis;
    font-size: 12px;
    z-index: 10;
}
.upload-state-done:after {
    content:"\f00c";
    font-family: FontAwesome;
    font-style: normal;
    font-weight: normal;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    font-size: 32px;
    position: absolute;
    bottom: 0;
    right: 4px;
    color: #4cae4c;
    z-index: 99;
}
.file-item .progress {
    position: absolute;
    right: 4px;
    bottom: 4px;
    height: 3px;
    left: 4px;
    height: 4px;
    overflow: hidden;
    z-index: 15;
    margin:0;
    padding: 0;
    border-radius: 0;
    background: transparent;
}
.file-item .progress span {
    display: block;
    overflow: hidden;
    width: 0;
    height: 100%;
    background: #d14 url(../images/progress.png) repeat-x;
    -webit-transition: width 200ms linear;
    -moz-transition: width 200ms linear;
    -o-transition: width 200ms linear;
    -ms-transition: width 200ms linear;
    transition: width 200ms linear;
    -webkit-animation: progressmove 2s linear infinite;
    -moz-animation: progressmove 2s linear infinite;
    -o-animation: progressmove 2s linear infinite;
    -ms-animation: progressmove 2s linear infinite;
    animation: progressmove 2s linear infinite;
    -webkit-transform: translateZ(0);
}
@-webkit-keyframes progressmove {
    0% {
        background-position: 0 0;
    }
    100% {
        background-position: 17px 0;
    }
}
@-moz-keyframes progressmove {
    0% {
        background-position: 0 0;
    }
    100% {
        background-position: 17px 0;
    }
}
@keyframes progressmove {
    0% {
        background-position: 0 0;
    }
    100% {
        background-position: 17px 0;
    }
}

a.travis {
  position: relative;
  top: -4px;
  right: 15px;
}
</style>

<script>
$(function(){
	var $list = $("#thelist");
	var BASE_URL = "${ctx}/static/plugins/uploadify/scripts/";
	$('#myupload').uploadify({
	    swf      : BASE_URL+'uploadify.swf',
	    uploader : '${ctx}/base/hotel/img/upload;jsessionid=<%=session.getId() %>',
	    buttonText: '<div>选择文件</div>'
	    ,fileSizeLimit:'5MB'
        ,fileTypeExts: '*.jpg;*.png;*.gif'
        ,queueSizeLimit: 20
       	,formData: {
               dir: 'image'
           }
	    ,onUploadComplete: function(file){
	    	 console.log(file);
            //在每一个文件上传成功或失败之后触发，返回上传的文件对象或返回一个错误，如果你想知道上传是否成功，最后使用onUploadSuccess或onUploadError事件
        }
	    ,onQueueComplete:function(queueData){
            console.log(queueData.uploadsSuccessful+'\n'+queueData.uploadsErrored)
        }
	    , onUploadSuccess: function(file,data,respone){
            var obj = eval('('+data+')');
            var $li = $('<div id="' + file.id + '" class="file-item thumbnail">' +
	                '<img src="'+obj.url+'">' +
	                '<div class="info">' + file.name + '</div>' +
	                '<input type="hidden" name="imgs" value="'+obj.url+'">' +
	                '<img src="${ctx}/static/plugins/uploadify/img/uploadify-cancel.png" style="position: absolute;top: 0;right: 0;width:20px;cursor: pointer;" onclick="deleteFile(this)" />'+
	            '</div>');
            $("#thelist").append($li);
         }
	});

});

function deleteFile(self){
	$this = $(self);
	var $img = $this.parent().find("img");
	var path = $img.attr("src");
	$.post('${ctx}/base/hotel/img/remove',{path:path},function(){},'json');
	$this.parent().remove();
}
function saveImg(){
	var data =$("#img_upd_form").serialize();
    show();
	$.post('${ctx}/base/hotel/img/save',data,function(res){
		if(res.statusCode==="200"){
			$("#close_btn").click();
			loadHotelContent(this,'${ctx}/base/hotel/img/create?id=${siteId}&type=${siteType}','');
		}
		hide();
	},"json");
}
</script>
</div>
