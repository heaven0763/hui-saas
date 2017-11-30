var util = util || {};
util.data = util.data || {};// 用于存放临时的数据或者对象

/**
 * 将form表单元素的值序列化成对象
 * @example util.serializeObject($('#formId'))
 * @requires jQuery
 * @returns object
 */
util.serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (this['value'] != undefined && this['value'].length > 0) {// 如果表单项的值非空，才进行序列化操作
			if (o[this['name']]) {
				o[this['name']] = o[this['name']] + "," + this['value'];
			} else {
				o[this['name']] = this['value'];
			}
		}
	});
	return o;
};

/**
 * 增加formatString功能
 * @example util.formatString('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * @returns 格式化后的字符串
 */
util.formatString = function(str) {
	for (var i = 0; i < arguments.length - 1; i++) {
		str = str.replace("{" + i + "}", arguments[i + 1]);
	}
	return str;
};

/**
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * @returns list
 */
util.stringToList = function(value) {
	if (value != undefined && value != '') {
		var values = [];
		var t = value.split(',');
		for (var i = 0; i < t.length; i++) {
			values.push('' + t[i]);/* 避免他将ID当成数字 */
		}
		return values;
	} else {
		return [];
	}
};

/**
 * 去字符串空格
 * @author 
 */
util.ltrim = function(str) {
	return str.replace(/(^\s*)/g, '');
};
util.rtrim = function(str) {
	return str.replace(/(\s*$)/g, '');
};

/**
 * 格式化浮点数
 * @param n
 * @param pos 保留小数位数
 * @returns {Number}
 */
function fomatFloat(n, pos){
	return Math.round(n*Math.pow(10, pos))/Math.pow(10, pos);
}

/** 
 * formatMoney(s,type) 
 * 功能：金额按千位逗号分割 
 * 参数：s，需要格式化的金额数值. 
 * 参数：type,判断格式化后的金额是否需要小数位. 
 * 返回：返回格式化后的数值字符串. 
 */  
function formatMoney(s, type) {  
    if (/[^0-9\.]/.test(s))  
        return "0.00";  
    if (s == null || s == "")  
        return "0.00";  
    s = s.toString().replace(/^(\d*)$/, "$1.");  
    s = (s + "00").replace(/(\d*\.\d\d)\d*/, "$1");  
    s = s.replace(".", ",");  
    var re = /(\d)(\d{3},)/;  
    while (re.test(s))  
        s = s.replace(re, "$1,$2");  
    s = s.replace(/,(\d\d)$/, ".$1");  
    if (type == 0) {// 不带小数位(默认是有小数位)  
        var a = s.split(".");  
        if (a[1] == "00") {  
            s = a[0];  
        }  
    }  
    return s;  
}  

/**
 * 改变jQuery的AJAX默认属性和方法
 * @requires jQuery
 */
$.ajaxSetup({
	type : 'POST',
	error : function(XMLHttpRequest, textStatus, errorThrown) {
		try {
			parent.$.messager.progress('close');
			parent.$.messager.alert('错误', XMLHttpRequest.responseText);
		} catch (e) {
			alert(XMLHttpRequest.responseText);
		}
	}
});

