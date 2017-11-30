var common = common || {}; 

common.ctx = '';

/**
 * 该方法只能用来进行提交操作,后台必须返回ajaxDoneSuccess或者ajaxDoneSuccess这种格式
 */
common.ajaxjson = function(op){
	$.ajax({
		type: op.type || 'post',url: op.url,data: op.data,cache: false,
		success: function(response){
			var json = common.parseJson(response);
			
			common.ajaxDone(json,op);
		},
		error: common.ajaxError
	});
    
};

common.ajaxDone = function(response,op){
	if(response.statusCode == 200){	//正确返回json,成功
		if(op.success){
			op.success(response);
		}
		if(response.callbackFn){	//回调函数
			try{
				eval('(' + response.callbackFn + ')');
			}catch(err){}
		}
	}else{	//失败
		var errMsg = '';
		//返回操作失败,或者报错
		if(response.statusCode == 309){	
			if(op.error){
				op.error(response);
			}else{
				errMsg = response.message;
				common.alert(errMsg);
			}
			
		}else{
			//common.alert('网络请求错误！');
		}
	}
	
};
common.submitForm = function($form, callback,error){
	var op = {
		$form : $form,
		success : callback,
		error : error
	};
	common.submit(op);
};

common.submit = function(op){
	var $form = op.$form;
    var $iframe = $('#callbackframe');
    if ($iframe.length == 0) {
        $iframe = $("<iframe id='callbackframe' name='callbackframe' src='about:blank' style='display:none'></iframe>").appendTo("body");
    }
    var iframe = $iframe[0];
    $form.attr('target','callbackframe');
   
    if($form.valid && !$form.valid()){
		return;
	}
    if($form.attr('action').indexOf(common.ctx) == -1){
        $form.attr('action',common.ctx + $form.attr('action'))
    }
    if($("#mask-full-screen")){
    	$("#mask-full-screen").show();
    }
    common._iframeResponse($iframe[0],$form,op);
    $form.submit();
}

common.progressbar = '<div class="progress" id="progress_div" style="display:none;" >'
						+'<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%;">'
						+'0%'
						+'</div>'
						+'</div>';

common.ajaxForm =function(op){
  var $form =  $('#'+op.formId);
  /*var $progress_div = $form.find('#progress_div');
  if($progress_div.length < 1 && op.showProgress != 0){
	  $progress_div = $(common.progressbar).appendTo($form);
  }*/
  $form.submit(function() {
	  $form.ajaxSubmit({
		    beforeSubmit:function(){
		    	if($form.valid()){
					//$progress_div.show().find('.progress-bar').width(0 + '%').text(0 + '%');
					return true;
		    	}
		    	return false;
		    },
			uploadProgress: function(event,position,total, percentComplete ){
				//$progress_div.show().find('.progress-bar').width(percentComplete + '%').text(percentComplete + '%');
			},
			success: function(res){
				var res = common.parseJson(res);
				if(res.statusCode != 200){
					if(op.doneError){
						op.doneError(res);
					}else{
						common.alert(res.message);
					}
					
				}else{
					if(op.success ){
						op.success(res);
					}
				}
			}
			
		}); 
	 return false;
 });
		 
	 
};

/**
 * @param iframe
 * @param callback
 */
common._iframeResponse = function(iframe, $form,op){
	var $iframe = $(iframe), $document = $(document);
	$document.trigger("ajaxStart");
	$iframe.bind("load", function(event){
		$iframe.unbind("load");
		$('div.window-mask').css('z-index',$form.parents('div.window:eq(0)').css('z-index')-1);
		$document.trigger("ajaxStop");
		if (iframe.src == "javascript:'%3Chtml%3E%3C/html%3E';" || // For Safari
			iframe.src == "javascript:'<html></html>';") { // For FF, IE
			return;
		}
		var doc = iframe.contentDocument || iframe.document;
		// fixing Opera 9.26,10.00
		if (doc.readyState && doc.readyState != 'complete') return; 
		// fixing Opera 9.64
		if (doc.body && doc.body.innerHTML == "false") return;
		var response;
		if (doc.XMLDocument) {
			// response is a xml document Internet Explorer property
			response = doc.XMLDocument;
		} else if (doc.body){
			try{
				response = $iframe.contents().find("body").text();
				response = jQuery.parseJSON(response);
			} catch (e){ // response is html document or plain text
				response = doc.body.innerHTML;
			}
		} else {
			// response is a xml document
			response = doc;
		}
		common.ajaxDone(response,op);
		//callback(response);
	});
};

common.ajaxError = function(xhr, ajaxOptions, thrownError){
	var errMsg = '<div>Http status: ' + xhr.status + ' ' + xhr.statusText + '</div>'
	+ '<div>ajaxOptions: '+ajaxOptions + '</div>'
	+ '<div>thrownError: '+thrownError + '</div>'
	+ '<div>'+xhr.responseText+'</div>';
	if(common && common.alert){
		common.alert('系统内部错误');
	}else{  alert('系统内部错误\n'+errMsg);}
}


common.ajaxDownload = function(url,$form){
	var ajaxDownFrame = $('#ajaxDownFrame');
	var ajaxDownForm = $form || $('#ajaxDownForm');
	if(ajaxDownFrame.length < 1){
		ajaxDownFrame = $('<iframe id="ajaxDownFrame" name="ajaxDownFrame" style="display:none;" />');
		$('body').append(ajaxDownFrame);
	}
	if(ajaxDownForm.length < 1){
		ajaxDownForm = $('<form id="ajaxDownForm" target="ajaxDownFrame" method="post" style="display:none;"/>');
		$('body').append(ajaxDownForm);
	}
	ajaxDownFrame.bind("load", function(event){
		ajaxDownFrame.unbind("load");
		var iframeBody = document.getElementById('ajaxDownFrame').contentWindow.document.body;
		if(iframeBody){
			var text = iframeBody.innerText;
			if(text !=''){
				common.alert(JSON.parse(text).message);
				iframeBody.innerText = '';
			}
		}
	});
	ajaxDownFrame.attr('name','ajaxDownFrame');
	ajaxDownForm.attr('action',url);
	ajaxDownForm.submit();
	
}

common.parseJson = function(data) {	//string to json
	try{
		if ($.type(data) == 'string')
			return eval('(' + data + ')');
		else return data;
	} catch (e){
		return {};
	}
}

/**
 * 改变jQuery的AJAX默认属性和方法
 * @requires jQuery
 */
$.ajaxSetup({
　　timeout: 60 * 1000,
     cache :false
　　　　//请求成功后触发
});

