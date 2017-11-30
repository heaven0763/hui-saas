 $.extend($.validator.defaults,{
	errorPlacement : function(error, element){
		/*var inputLabelText = element.parent().prev().text();
		inputLabelText = inputLabelText? inputLabelText.replace('：','') : '';
		switch(error.text()){
		case 'required':
			toastFn('请输入'+inputLabelText);
			break;
		case 'email':
			toastFn('请输入合法的邮箱地址');
			break;
		default:
			toastFn(error.text());
			break;
		}*/
		
    },
    showErrors: function(errorMap,errorList){
    	var $form = $(this.currentForm);
    	var error = {};
    	for(var i in errorMap){
    		error = {
    			name : i,	
				message : errorMap[i]
    		};
    		break;
    	}
    	var element = $form.find('[name='+error.name + ']');
    	var inputLabelText = element.parent().prev().text();
		inputLabelText = inputLabelText? inputLabelText.replace('：','') : '';
		switch(error.message){
		case 'required':
			toastFn('请输入'+inputLabelText);
			break;
		case 'email':
			toastFn('请输入合法的邮箱地址');
			break;
		default:
			toastFn(error.message);
			break;
		}
    },
    highlight : function(element, errorClass, validClass) {
	},
	onkeyup:false,
	onfocusout:false
});
    
/***
 * 校验身份证号 IdCardNoValid
 * */
$.validator.addMethod("idCardNo", function(value, element) {
    return validateIDCardNo(value) || this.optional(element); 
},'请输入合法的身份证号');

$.validator.addMethod("cellPhone", function(value, element) {
    var tel = /^(13|15|18)\d{9}$/; 
    return tel.test(value) || this.optional(element); 
}, "请输入正确的手机号码");

$.validator.addMethod("NE", function(value, element, param) {	//no equal 不等于
	var target = $(param);
	
	return value != target.val() || this.optional(element); 
});

/**
 * 金额校验，只能包含数字和一个.
 */
$.validator.addMethod('float',function(value){
	return /^\d+(\.\d+)?$/i.test(value);
},'请输入合法金额');

//身份证校验
//checkValue 身份证
//return - 正确=null;错误=错误描述
function validateIDCardNo(checkValue)
{	
/*	if(checkValue=="")
		return "输入为空值";*/
		
	var paraValue = null;
	 
	if(checkValue.length!=15&&checkValue.length!=18)
	{
		paraValue ="身份证号码的位数不正确 ";		
	}else if(checkValue.length==18){
		var dateStr = checkValue.substring(6,10)+"-"+checkValue.substring(10,12)+"-"+checkValue.substring(12,14);
		if(!validateDate(dateStr)){
			paraValue ="身份证中的日期不合法 ";					
		}
		last_value = get18bit(checkValue.substring(0,17));
		if(last_value!=checkValue.substring(17,18))
		{
			if (paraValue==null) {
				paraValue = "末位校验码不对 ";			
			} else {
				paraValue = paraValue + "," + "末位校验码不对 ";					    
			}			
		}
	}else if(checkValue.length==15){
		var reg =/^\d{15}/g;

		if(reg.test(checkValue)){
			//ADD BY ZXQ 2005-07-15
			//alert("validateID--zxq");
			var __year = "19"+checkValue.substring(6,8);
			
			var __month = checkValue.substring(8,10);
			var __day = checkValue.substring(10,12);		
			if(!validateDate(CStr(__year)+"-"+CStr(__month)+"-"+CStr(__day))){
				paraValue = "身份证(15位)中的日期不合法";			
			}				
			var __idDate=convertstring2date(CStr(__year)+"-"+CStr(__month)+"-"+CStr(__day));
			if(__idDate>=(new Date())){
				paraValue = "身份证(15位)中的日期不合法";
			}		  
			paraValue == null;
		}else{
			paraValue =  "身份证(15位)号码不正确 ";
		}
	}
	return paraValue == null ? true : false;	
}

//fuction: validateDate added by wzp 判断是否日期
//parameter:
//	strValue - the string to validate
//version:
function validateDate( strValue ) 
{  
var objRegExp = /^\d{4}(\-|\/|\.)\d{1,2}\1\d{1,2}$/
//check to see if in correct format
if(strValue=="") return true;
else if(!objRegExp.test(strValue))
return false; //doesn't match pattern, bad date
else{
var arrayDate = strValue.split(RegExp.$1); //split date into month, day, year
	var intDay = parseInt(arrayDate[2],10); 
	var intYear = parseInt(arrayDate[0],10);
var intMonth = parseInt(arrayDate[1],10);  
var j=convertstring2date(strValue); 
	//check for valid month
	if(intMonth > 12 || intMonth < 1) {
	return false;
	}
	    //create a lookup for months not equal to Feb.
	    var arrayLookup = { '01' : 31,'03' : 31, '04' : 30,'05' : 31,'06' : 30,'07' : 31,'08' : 31,'09' : 30,'10' : 31,'11' : 30,'12' : 31,'1' : 31,'3' : 31, '4' : 30,'5' : 31,'6' : 30,'7' : 31,'8' : 31,'9' : 30}	  
	    //check if month value and day value agree
	    if(arrayLookup[arrayDate[1]] != null) {
	      if(intDay <= arrayLookup[arrayDate[1]] && intDay != 0)
	        return true; //found in lookup table, good date
	    }
	    //check for February
		var booLeapYear = (intYear % 4 == 0 && (intYear % 100 != 0 || intYear % 400 == 0));
	    if( ((booLeapYear && intDay <= 29) || (!booLeapYear && intDay <=28)) && intDay !=0)
	    return true; //Feb. had valid number of days
	  }
return false; //any other values, bad date
}
function convertstring2date(strValue)
{		
  var objRegExp = /^\d{4}(\-|\/|\.)\d{1,2}\1\d{1,2}$/
  if(objRegExp.test(strValue)){  
    var arrayDate = strValue.split(RegExp.$1); //split date into month, day, year
    var intDay = parseInt(arrayDate[2],10); 
    var intYear = parseInt(arrayDate[0],10);
    var intMonth = parseInt(arrayDate[1],10); 
    return new Date(intYear,intMonth-1,intDay);
  }
}
//////////计算身份证号码的第18位///////////	
function get18bit(textfield)
{
	var ll_value=0;
	for(i=2;i<=18;i++)
	{	
		ls_letter=textfield.substring(18-i,19-i);
	 	ll_value=ll_value+ls_letter*gf_wi(i);
	}
	ll_value=ll_value%11;
	if(ll_value==2)
		return ("X");
	else if(ll_value==0||ll_value==1)
		return (1-ll_value);
	else 	return (12-ll_value);
}

/**
 *	Purpose: 将数值类型转化为String   
 *	Inputs: int  
 *	Returns: String
 */
function CStr(inp) 
{ 
	return(""+inp+""); 
} 
//身份证校验
//checkValue 身份证
//return - 正确=null;错误=错误描述
function validateIDError(checkValue)
{	
	if(checkValue=="")
		return "输入为空值";
		
	var paraValue = null;
	 
	if(checkValue.length!=15&&checkValue.length!=18)
	{
		paraValue ="身份证号码的位数不正确 ";		
	}else if(checkValue.length==18){
		var dateStr = checkValue.substring(6,10)+"-"+checkValue.substring(10,12)+"-"+checkValue.substring(12,14);
		if(!validateDate(dateStr)){
			paraValue ="身份证中的日期不合法 ";					
		}
		last_value = get18bit(checkValue.substring(0,17));
		if(last_value!=checkValue.substring(17,18))
		{
			 if (paraValue==null) {
				paraValue = "末位校验码不对 ";			
				} else {
				paraValue = paraValue + "," + "末位校验码不对 ";					    
				}			
		}
	}else if(checkValue.length==15){
		var reg =/^\d{15}/g;
		
		if(reg.test(checkValue)){
			//ADD BY ZXQ 2005-07-15
			//alert("validateID--zxq");
			var __year = "19"+checkValue.substring(6,8);
			
			var __month = checkValue.substring(8,10);
			var __day = checkValue.substring(10,12);		
			if(!validateDate(CStr(__year)+"-"+CStr(__month)+"-"+CStr(__day))){
				paraValue = "身份证(15位)中的日期不合法";			
			}				
			var __idDate=convertstring2date(CStr(__year)+"-"+CStr(__month)+"-"+CStr(__day));
			if(__idDate>=(new Date())){
				paraValue = "身份证(15位)中的日期不合法";
			}		  
			return paraValue;
		}else{
			paraValue =  "身份证(15位)号码不正确 ";
		}
	}	
	return paraValue;	
}
function gf_wi(al_i)
{
	var ll_wi=1;
	do
	{
		ll_wi=ll_wi*2;
		al_i--;
	}while(al_i>1)
	
	return ll_wi%11;
}

$.extend(jQuery.validator.messages, {
    required: "required",
	remote: "remote",
	email: "email",
	url: "请输入合法的网址",
	date: "请输入合法的日期",
	dateISO: "请输入合法的日期 (ISO).",
	number: "请输入合法的数字",
	digits: "只能输入整数",
	creditcard: "请输入合法的信用卡号",
	equalTo: "请输入相同的值",
	accept: "请输入拥有合法后缀名的字符串",
	maxlength: jQuery.validator.format("长度不能大于 {0} "),
	minlength: jQuery.validator.format("长度不能小于 {0} "),
	rangelength: jQuery.validator.format("长度介于 {0} 和  {1} "),
	range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
	max: jQuery.validator.format("max"),
	min: jQuery.validator.format("min")
});