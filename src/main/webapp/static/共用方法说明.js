关于共用的一些方法说明:

	//输入校验，请看validate.extend.js
	
//util.string.js   start 
	/**
	 * 是否是正整数，不包括0
	 * @returns true if is positiveInteger else false
	 */
	isPositiveInteger=function(){}
	/**
	 * 是否是整数，包括0
	 * @returns
	 */
	isInteger=function(){}
	/**
	 * 是否是数字，但负数不是，因为有-号
	 * @param value
	 * @param element
	 * @returns
	 */
	isNumber = function(value, element) {}
	/**
	 * 去除两边的空格，中间的空格不会去掉
	 * @returns
	 */
	trim = function(){}
	//你懂的
	startsWith= function (pattern){}
	//你懂的
	endsWith= function(pattern) {}
	/**
	 * 不明
	 * @param index
	 * @returns
	 */
	replaceSuffix= function(index){}
	/**
	 * 将html特殊字符转为html命名实体
	 * @returns
	 */
	trans= function(){}
	
	/**
	 * 将html命名实体转为html特殊字符
	 * @returns
	 */
	encodeTXT = function(){}
	//你懂的
	replaceAll= function(os, ns){}
	//不明
	replaceTm= function($data){}
	//不明
	replaceTmById= function(_box){}
	//不明
	isFinishedTm= function(){}
	//不明
	skipChar= function(ch) {}
	
	//合法的密码，6到32位的英文或数字
	isValidPwd= function() {}
	//是否全是空格
	isSpaces= function() {}
	//是否是手机号码
	isPhone= function() {}
	//是否是url
	isUrl= function(){}
	//是否是外部 url
	isExternalUrl= function(){}
	
//util.string.js   end 
	
	
/**
 * 将form表单元素的值序列化成对象
 * @example util.serializeObject($('#formId'))
 * @requires jQuery
 * @returns object
 */
util.serializeObject = function(form){}
		
/**
 * 增加formatString功能
 * @example util.formatString('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * @returns 格式化后的字符串
 */
util.formatString = function(str){}

/**
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * @returns list
 */
util.stringToList = function(value) {}

/**
 * 去字符串空格
 * @author 
 */
util.ltrim = function(str) {}
util.rtrim = function(str) {}

//壹万壹仟贰佰叁拾叁元壹角贰分,string也可以用该方法，金额
var aa = 11233.12;
console.log(aa.amountInWords(6));

//11,233.00,string也可以用该方法，金额
var aa = 11233;
alert(aa.formatCurrency());

//身份证校验
//checkValue 身份证
//return - 正确=null;错误=错误描述
function validateIDCardNo(checkValue)

//改变easyui主题，并保存cookie，有效期7天，见 ui.extends.js
function changeTheme(themeName)

/**
 * 格式化浮点数
 * @param n
 * @param pos 保留小数位数
 * @returns {Number}
 */
function fomatFloat(n, pos)

/** 
 * formatMoney(s,type) 
 * 功能：金额按千位逗号分割 
 * 参数：s，需要格式化的金额数值. 
 * 参数：type,判断格式化后的金额是否需要小数位.1为保留，0为不保留 
 * 返回：返回格式化后的数值字符串. 
 */  
function formatMoney(s, type)
		
/**
 *	Purpose: 从身份证号码取生日
 */
function getBirthday(str) {}

/**
 * 从身份证号码中获取性别
 */
function getSex(str){}

//使用form表单进行请求到url以达到下载文件的目的，注意不要在form内使用该方法
function ajaxDownload(url){}

//从佳高会员app拿过来的，显示会员跟帖时间，如果超过一天则显示完整日期，一天内显示多少秒或分或时前
function getDiffTime(daytime){}

//日期加减,返回的是string类型，例如日期减一天，貌似跨月有bug
alert(new Date().formatDateTm('%y-%M-{%d-1}'));

//日期转字符串，可自定义格式
alert(new Date().formatDate('yyyy年MM-dd'));

//字段串转日期，返回Date类型，注意的是如果相个参数格式不对，则返回0
alert('2015-02-01'.parseDate('yyyy-MM-dd'));

