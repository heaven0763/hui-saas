var tools = tools || {}; 
var toastTimeoutID = 0;

/**
 * 封装的toast方法
 * 例如，
 * 原本是
 * alert('提示！！！！');
 * 可直接替换alert,变为
 * toastFn('提示！！！！');
 * @param text  必须，提示信息
 * @param time	非必须，显示持续时间
 * @param cb	非必须，提示信息消失后的回调函数
 */
function toastFn(text,time,cb){
	clearTimeout(toastTimeoutID);
	time = time | 1500;
	var $toastdiv = $('#toast-div');
	if($toastdiv.length < 1){
		$toastdiv = $('<div id="toast-div"><div id="toast-text"></div></div>').appendTo('body');
	}
	$('#toast-text').text(text);
	$toastdiv.show();
	toastTimeoutID = setTimeout(function(){
		$toastdiv.hide();
		if(cb){
			cb();
		}
	},time);
}




/**
 * 封装的confirm方法
 * 例如，原来是
 * 
 * if(!confirm('确定吗？')){
 * 		return;
 * };
 * do something ...
 * 
 * 现在可改为
 * 
 * confirmFn('确定吗？',function(){
 * 	  do something ...
 * });
 * 
 * @param msg 提示信息
 * @param okCb	点击确定后的回调函数
 */
function confirmFn(msg,okCb){
	confirmBox({
		msg : msg,
		ok : function(){
			if(okCb){
				okCb();
			}
		}
	});
}

/**
 * 示例
 * confirmBox({
			title : '这是标题',
			msg : '真的确定吗',
			okBtnText : 'yes',
			cancelBtnText : 'no',
			ok : function(){
				toastFn('您点击了确定');
			},
			cancel: function(){
				toastFn('您点击了取消');
			}
		});
 */
var confirmBox = function(ops){
	var _self = {};
	_self.setting = $.extend({
		title:'系统提示',
		msg:'确定？',
		okBtnText:'确定',
		cancelBtnText:'取消',
		maskDiv : $('#mask-div'),
		confirmDivP : $('confirm-div-p'),
		ok : function(){ },
		cancel : function(){ }
	},ops);
	_self.init = function(){
			if(_self.setting.maskDiv.length < 1){
				_self.setting.maskDiv = $('<div id="mask-div"></div>').appendTo('body');
			}
			if(_self.setting.confirmDivP.length < 1){
				_self.setting.confirmHtml = '<div id="confirm-div-p">'
												+'<div id="confirm-div-inner">'
													+'<div id="confirm-title">'+_self.setting.title+'</div>'
													+'<div id="confirm-msg">'+_self.setting.msg+'</div>'
													+'<div id="confirm-cancel">'+_self.setting.cancelBtnText+'</div>'
													+'<div id="confirm-ok">'+_self.setting.okBtnText+'</div>'
												 +'</div>'
											+'</div>';
				_self.setting.confirmDivP = $(_self.setting.confirmHtml).appendTo('body');
			}
			
			_self.setting.confirmDivP.find('#confirm-cancel').click(_self.cancelEvent);
			_self.setting.confirmDivP.find('#confirm-ok').click(_self.okEvent);
			
	};
	_self.show = function(){
		_self.setting.maskDiv.show();
		_self.setting.confirmDivP.show();
		 $('html').css('overflow-y','hidden');
		 window.addEventListener('touchmove',disabledScroll);
	};
	_self.hide = function(){
		_self.setting.maskDiv.hide();
		_self.setting.confirmDivP.hide();
		 $('html').css('overflow-y','auto');
		 window.removeEventListener('touchmove',disabledScroll);
	};
	
	_self.okEvent = function(){
		_self.hide();
		_self.setting.ok();
	};
	
	_self.cancelEvent = function(){
		_self.hide();
		_self.setting.cancel();
	};
	
	_self.init();
	_self.show();
	
	return _self;
};
/**
 * 
 * @param msg open: 进度条显示;close : 进度条关闭
 * 
 */
function progressBarFn(msg){
	var $progressDiv = $('#mask-div');
	if($progressDiv.length < 1){
		$progressDiv = $('<div id="mask-div" style="display: none;"> <div class="progressbar" > <div class="pbattext"><img src="/jgismp/static/common/css/img/loading.gif"> </div></div></div>').appendTo('body');
	}
	if(msg=='open'){
		$progressDiv.show();
		 $('html').css('overflow-y','hidden');
		 window.addEventListener('touchmove',disabledScroll);
	}else{
		$progressDiv.hide();
		 $('html').css('overflow-y','auto');
		 window.removeEventListener('touchmove',disabledScroll);
	}
};
function disabledScroll(event){
	 event.preventDefault();
};





