
/**
 * 读取的身份证信息
 * */
var IdCardInfo = function(){
	this.ERROR_CODE = "0";
	this.SUCCESS_CODE = "1";
	//成功/失败状态
	this.status = this.ERROR_CODE;
	//状态信息
	this.statusInfo = "未读取身份证";
	this.personInfo = {
			//姓名
			name : "", 
			//性别
			sex : "", 
			//民族
			nation : "",
			//出生日期
			birthday : "", 
			//地址
			address : "" , 
			//身份证号
			cardNo : "" , 
			//有效期开始
			validityDateBegin : "" ,
			//有效期结束
			validityDateEnd : "" ,
			//发证机关
			issueAuthority : "",
			//照片文件名
			photoName : "",
			
			base64Photo:""
			};
}

/**
 * 寻找读卡器
 * */
function idCardFindReader()
{
	var str;
	str = SynCardOcx1.FindReader();
	var result = false;
	if (str > 0){
		result = true;
	}else{
		result = false;
	}
	return result;
}
function readIdCard()
{
	var idCardInfo = new IdCardInfo();
	var isReady = idCardFindReader();
	if(!isReady){
		idCardInfo.statusInfo = "没有找到读卡器";
		return idCardInfo;
	}
	var nRet;
	SynCardOcx1.SetReadType(0);
	SynCardOcx1.SetPhotoType(2);
	nRet = SynCardOcx1.ReadCardMsg();
	if(nRet==0)
	{
		/* document.all['S1'].value=document.all['S1'].value+"读卡成功\r\n";	
		document.all['S1'].value=document.all['S1'].value+"姓名:"+SynCardOcx1.NameA +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"性别:"+SynCardOcx1.Sex +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"民族:"+SynCardOcx1.Nation +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"出生日期:"+SynCardOcx1.Born +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"地址:"+SynCardOcx1.Address +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"身份证号:"+SynCardOcx1.CardNo +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"有效期开始:"+SynCardOcx1.UserLifeB +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"有效期结束:"+SynCardOcx1.UserLifeE +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"发证机关:"+SynCardOcx1.Police +"\r\n";
		document.all['S1'].value=document.all['S1'].value+"照片文件名:"+SynCardOcx1.PhotoName +"\r\n"; */
		//alert("SynCardOcx1.CardNo:"+SynCardOcx1.CardNo);
		idCardInfo.personInfo.name = SynCardOcx1.NameA;
		idCardInfo.personInfo.sex = SynCardOcx1.Sex;
		idCardInfo.personInfo.nation = SynCardOcx1.Nation;
		idCardInfo.personInfo.birthday = SynCardOcx1.Born;
		idCardInfo.personInfo.address = SynCardOcx1.Address;
		idCardInfo.personInfo.cardNo = SynCardOcx1.CardNo;
		idCardInfo.personInfo.validityDateBegin = SynCardOcx1.UserLifeB;
		idCardInfo.personInfo.validityDateEnd = SynCardOcx1.UserLifeE;
		idCardInfo.personInfo.issueAuthority = SynCardOcx1.Police;
		idCardInfo.personInfo.photoName = SynCardOcx1.PhotoName;
		idCardInfo.personInfo.base64Photo = SynCardOcx1.Base64Photo;
		
		idCardInfo.status = idCardInfo.SUCCESS_CODE;
	}else{
		idCardInfo.status = idCardInfo.ERROR_CODE;
		idCardInfo.statusInfo  = "无法读取身份证";
	}
	return idCardInfo;
}