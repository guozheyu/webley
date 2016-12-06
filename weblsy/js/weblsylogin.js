function gwserverJson(){
	this.context="";
	this.encryptType="0";
	this.sessionId="";
}

function contextDic(){
	this.head="";
	this.body="";
}

function contextHead(){
	this.serviceId = "lcbp";
	this.userAgent = "pc";
	this.version = "1.0";
	this.channel = "01";
	this.appType = "lcbp";
	this.type = "LOGIN";
	this.userId = "";
	this.token = "";
	this.checkTokenFlag = "0";
	this.randomCode = "";
	this.randomTaskId="";
	this.imageCode = "";
	this.imageTaskId = "";
	this.appVersion = "1";
}

function contextBody(){
	this.url = "/system/login.json";
	this.body = 	"";
}
function contextBodyBody(){
	this.ajaxCheckTokenFlag = "0";
	this.ajaxImageCode = "";
	this.ajaxImageTaskId = "";
	this.ajaxRandomCode = "";
	this.ajaxRandomTaskId = "";
	this.ajaxType = "LOGIN";
	this.channelType = "01";
	this.s_loginName = "";
	this.s_password = "";
	this.s_randomNumber = "";
}

function createJson(userId,randomCode,randomTaskId,password,imageCode,imageTaskid){
	var cbodybody = new contextBodyBody();
	cbodybody.s_password = password;
	cbodybody.s_loginName = userId;
	cbodybody.ajaxRandomTaskId = randomTaskId;
	cbodybody.s_randomNumber = randomCode;
	cbodybody.ajaxRandomCode = randomCode;
	//cbodybody.ajaxImageCode = imageCode;
	//cbodybody.ajaxImageTaskId = imageTaskid;
	
	var cbody = new contextBody();
	cbody.body = cbodybody;
	var chead = new contextHead();
	chead.userId = userId;
	chead.randomCode = randomCode;
	chead.randomTaskId = randomTaskId;
	//chead.imageCode = imageCode;
	//chead.imageTaskId = imageTaskid;
	
	var cdic = new contextDic();
	cdic.body = cbody;
	cdic.head = chead;
	
	var context = new gwserverJson();
	context.context = cdic;
	return context;
}
/**********************发送手机验证码**********************/
function contextCommonBodyBody(){
	this.channelType = "01";
	this.s_smsType = "0002";
}
function contextCommonHead(){
	this.appType = "03";
	this.appVersion = "1.0";
	this.channel = "01";
	this.checkTokenFlag = "1";
	this.serviceId = "lcbp";
	this.imageCode = "";
	this.imageTaskId = "";
	this.token = "";
	this.type = "SMS";
	this.userAgent = "pc";
	this.userId = "";
	this.version = "1.0";
}
function createSendJson(phoneToken,userId,imageCode,imageTaskId){
	var cbodybody = new contextCommonBodyBody();
	var cbody = new contextBody();
	cbody.body = cbodybody;
	cbody.url = "/system/usersSendMessage.json";
	
	var chead = new contextCommonHead();
	chead.token = phoneToken;
	chead.userId = userId;
	chead.imageCode = imageCode;
	chead.imageTaskId = imageTaskId;
	chead.checkTokenFlag = "1";//验证
	chead.type = "SMS";
	var cdic = new contextDic();
	cdic.body = cbody;
	cdic.head = chead;
	
	var context = new gwserverJson();
	context.context = cdic;
	return context;
}

/**********************验证手机验证码**********************/
function contextVerifyBodyBody(){
	this.channelType = "01";
	this.s_codeSms = "";
	this.s_taskId = "";
}
function createValidateJson(phoneToken,userId,codesms,taskId){
	var cbodybody = new contextVerifyBodyBody();
	cbodybody.s_codeSms = codesms;
	cbodybody.s_taskId = taskId;
	var cbody = new contextBody();
	cbody.body = cbodybody;
	cbody.url = "/system/userVerifySms.json";
	
	var chead = new contextCommonHead();
	chead.token = phoneToken;
	chead.userId = userId;
	chead.imageCode = codesms;
	chead.imageTaskId = taskId;
	chead.checkTokenFlag = "1";//不验证
	chead.type = "CMS";
	var cdic = new contextDic();
	cdic.body = cbody;
	cdic.head = chead;
	
	var context = new gwserverJson();
	context.context = cdic;
	return context;
}
/*******************获取密文***********************/
function contextMiwenBodyBody(){
	this.amount = "";
	this.token = "";
	this.accountNo = "";
	this.accountType = "";
	this.defaultTradeType = "";
	this.selectTradeType = "";
}
function createMiwenJson(token,userId,amount,accountNo,accountType,defaultTradeType,selectTradeType){
	var cbodybody = new contextMiwenBodyBody();
	cbodybody.amount = amount;
	cbodybody.token = token;
	cbodybody.accountNo=accountNo;
	cbodybody.accountType=accountType;
	cbodybody.defaultTradeType=defaultTradeType;
	cbodybody.selectTradeType=selectTradeType;
	var cbody = new contextBody();
	cbody.body = cbodybody;
	cbody.url = "";
	
	var chead = new contextHead();
	chead.token = token;
	chead.userId = userId;
	chead.checkTokenFlag = "1";
	chead.type="CREATECIPHER";
	
	var cdic = new contextDic();
	cdic.body = cbody;
	cdic.head = chead;
	
	var context = new gwserverJson();
	context.context = cdic;
	return context;
}