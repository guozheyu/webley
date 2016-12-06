
//拿到查询body
function getRequestQueryBody(tradeType,bsData){
	var requestQueryJson ="{tradeType:'"+tradeType+"',returnBackJson:'"+bsData.returnBackJson+"',remark:''}";
	return requestQueryJson;
}

//查询请求
function RequestQueryJson(){
	this.tradeType="";
	this.remark="";
	this.returnBackJson="";
}

//拿到支付body
function getRequestPayBody(tradeType,payInfo,bsData){
	var requestPayJson = new RequestPayJson();
	try {
		requestPayJson.payInfo=payInfo;
		requestPayJson.remark="";
		requestPayJson.returnBackJson=bsData.returnBackJson;
		requestPayJson.selectTradeType=tradeType;
	} catch (e) {
		
	}
	return requestPayJson;
}

//支付请求
function RequestPayJson(){
	this.payInfo="";
	this.remark="";
	this.returnBackJson="";
	this.selectTradeType="";
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

function RequestJson(){
	//this.tokenId="";
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
