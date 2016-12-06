
function MakeOrder(amount){
	//得到密文
	var or = getMiwenResult(amount);
	
	
	getSessoinKey();
	
}

//解密解签
function getDecryptInfo(){
	var url = "";
	var params = getRequestJson(or);
	
	//异步请求
	var result = "";
	var optString = result.businessContext;
	
	var decrypt = PaySdkdecrypt(optString,businessData.getTokenKey());
	
	if(null != decrypt){
		var returnBackJson = decrypt.returnBackJson;
		
		businessData.setReturnBackJson(returnBackJson);
		
		value.setOrderId(decrypt.merchantSeq);
		value.setAmount(decrypt.amount);
		
	}else{
		alert("解密失败！");
	}
}

//获取sessionkey
function getSessoinKey(){
	//获得8位随机数
	var strR1 = "";//服务器端生成
	
	var encryptRequestBody = "";//将r1 进行RSA加密
	
	var url = "";
	var params = getRequestJson(encryptRequestBody);
	
	//异步请求获取sessesionkey
	//返回result
	
	var result = "";
	var businessContext = result.businessContext;

	//r1 是businessData.getTokenKey() --- 用r1解密  是因为 appserver用r1加密reponse
	var decrypt = PaySdkdecrypt(businessContext, businessData.getTokenKey());
	
	if(null != decrypt){
		var responseJson = decrypt;
		var tokenId = responseJson.tokenId;
		var strR2 = responseJson.randCipher;
		var strTokenKey = null;
		if(strR2.length() == 16){
			strTokenKey = strR1.substring(0,8)+strR2.substring(8,16);
			businessData.setTokenKey(strTokenKey);
		}
		businessData.setTokenId(tokenId);
		
		alert("解密成功");
		
		getDecryptInfo();
	}else{
		alert("解密错误");
	}
	
}

function getRequestJson(business,bsData) {
	var requestJson = new RequestJson();
	try {
		var tokenJson;
		if (undefined != bsData.tokenId) {
			tokenJson = "{\"tokenId\":\"" + bsData.tokenId + "\"}";
		}
		requestJson.version= "1.0";
		requestJson.source="PC";
		requestJson.merchantNum="";
		requestJson.merchantSeq=bsData.merchantSeq;
		requestJson.transDate=$("#time_id").val().substring(0, 8);
		requestJson.transTime=$("#time_id").val().substring(8, 17);
		requestJson.transCode="";
		requestJson.securityType="";
		requestJson.reserve1="";
		requestJson.reserve2="";
		requestJson.reserve3="";
		requestJson.reserve4="";
		requestJson.reserve5="";
		if (undefined != bsData.tokenId) {
			requestJson.reserveJson=tokenJson;
		} else {
			requestJson.reserveJson="";
		}
		requestJson.businessContext= business
				.replace("\r", "").replace("\n", "");

	} catch (e) {
		
	}
	return requestJson;

}

//存储数据
var BusinessData =function(){
	this.merchantSeq="";
	this.tokenKey="";
	this.tokenId="";
	this.returnBackJson="";
}

function RequestJson(){
	this.tokenId="";
	this.version="1.0";
	this.source="PC";
	this.merchantNum="";
	this.merchantSeq="";
	this.transDate="";
	this.transTime="";
	this.transCode="";
	this.securityType="";
	this.reserve1="";
	this.reserve2="";
	this.reserve3="";
	this.reserve4="";
	this.reserveJson="";
	this.businessContext="";
}


//获得订单的密文
function getMiwenResult(amount){
	var order = new order();
	order.amount=amount;
	
	//加密order
	return order;
}
//需要加密的订单
function Order(){
	this.name="contextCreate";
	this.platformId="cust0001";//生产==P0000012015110600000001===平台号
	this.defaultTradeType="1,2,3,4,";
	this.merchantName="PC Demo";
	this.merchantNum="M23002016070000027375";
	this.notifyUrl="http://111.205.207.103/merchantdemo/noticeServlet";
	this.orderInfo="PC收款测试";
	this.merchantSeq="cmbc";
	this.transDate="";
	this.transTime="";
	this.printFlag="0";
	this.isConfirm="0";
	this.isShowSuccess="0";
	this.remark="";
	this.selectTradeType="2";//反扫
	this.amount="1";
}

//解密
function PaySdkdecrypt(){
	
}

function done(str) {
	var randNum = Math.floor(Math.random() * 36);
	return str + arr[randNum];
}
var arr = [0,1,2,3,4,5,6,7,8,9,"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D"];