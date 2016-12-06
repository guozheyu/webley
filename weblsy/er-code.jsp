<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@page import="org.joda.time.DateTime"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String time = new DateTime().toString("yyyyMMddHHmmssSSS");
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="Expires" content="0">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-control" content="no-cache">
		<meta http-equiv="Cache" content="no-cache">		
    	<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>中国民生银行收银台</title>
    	<link rel="stylesheet" href="css/bootstrap.css" >
    	<link rel="stylesheet" href="css/bootstrap-responsive.css" >
   	 	<link rel="stylesheet" href="css/iconfont.css" >
   	 	<link rel="stylesheet" href="css/styles.css">
		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	    <!--[if lt IE 9]>
	      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
	    <style>
	    	@media (max-width: 480px) {
			.footer{
				position: relative;
				font-size: 12px;
				margin-top: 10px;
			}
		}
	    </style>
	</head>
	<body style="width:99.0%;height: 300px;">
		<div class="navbar navbar-inverse navbar-static-top nav-style" style="position:absolute; width:100%; left:0; top:0; overflow:hidden;">
			<div class="navbar-inner navbar-header">
				<div class="container">
					<a class="brand logo-padd" href="javascript:void(0);"><img src="img/logo.png" style="border: 0px;" width="240"></a>
					<div class="top-info">
						<a class="logout" href="javascript:void(0);" onclick="quitLogin()">退出</a>
						<!-- <a class="change-password" href="changePassword.html">修改密码</a> -->
						<div class="pull-right username">
							<i class="iconfont">&#xe600;</i>
							<span id="user_name_id">收款商户：***</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container" style="padding-top:80px;">
			<div class="order-info common_show_id" style="padding-top: 13px;padding-bottom: 13px;">
				<div class="pull-left">订单号：<span class="colorb" id="order_id"></span></div>
				<div class="pull-right" id="merchant_name_id">收款商户：***********公司</div>
			</div>
			<div class="sum-info marginb20 common_show_id" >
				<span class="font-color">应付金额</span>
				<input type="text" disabled="true" id="order_money_id" value="" style="background-color:#dfe0e3;"/>
				<span>元</span>
				<!--<a style="color:#888888;">手动输入</a>-->
			</div>
			<div class="payment-box1 height340 common_show_id" style="height: 260px">
				<div class="tag-pos"><img id="trade_type_img_id"  src=""></div>
				<div class="main">
					<div class="er-code" id="erweima_image_id">
					</div>
<!-- 					<div class="scan-btn" style="height: 10px;">
						<button type="button" style="float: none;" class="back-btn" onclick="order()">返回</button>
					</div> -->
				</div>
			</div>
			<div class="sub" id="loading_id" style="display: none">
				<img src="img/MSLoad1.gif" class="s-img"></img>
				<p id="loading_msg_id">正在提交...</p>
			</div>				
		</div>
		<div class="footer" id="footer_id">
			Copyright&copy;版权所有&nbsp;中国民生银行&nbsp;|&nbsp;24小时客服服务热线 95568
		</div>
		<script src="js/jquery.min.js"></script>
   		<script src="js/bootstrap.js"></script>
		<script type="text/javascript" src="js/json2.js" ></script>
		<script type="text/javascript" src="js/security/aes.js" ></script>
		<script type="text/javascript" src="js/security/mode-ecb.js" ></script>
		<script type="text/javascript" src="js/security/jquery.base64.js" ></script>
		<script type="text/javascript" src="js/weblsypay.js?v=1.0" ></script> 
		<script type="text/javascript" src="js/util/money.js?v=1.0" ></script>
		<script type="text/javascript" src="js/util/common.js?v=1.0" ></script>   
		<script type="text/javascript" src="js/jquery.qrcode.min.js" ></script>    		
   		<script type="text/javascript">
   			//document.body.addEventListener('touchstart', function () { });  //保证手机端按钮或链接active效果
   			var com_path = "../../appweb";
   			function order(){
   				backMoney();
   			}
   			var TRADETYPE_FAN_SAO = "";
   			var storage = window.sessionStorage;//本地session存储
   			var localstorage = window.localStorage;//本地session存储
   			var orderInfoJson;
   			var businessData;
   			$(function(){
   				showBg("页面加载中...");	
   				var token=localstorage.getItem("token");
	   			//验证是否登录
	   			if(token==null){
	   				window.location.href="login.html";//未登录
	   				return;
	   			}
	   			//验证是否登录确认
	   			var token_flag=localstorage.getItem("token_flag");
	   			if(token_flag=='0' || token_flag==null){
	   				window.location.href="login.html";//未登录
	   				return;
	   			}
	   			//是否取消copyright
	   			var hiddenflag=localstorage.getItem("hiddenflag");
	   			if(hiddenflag=='1'){
	   				$('#footer_id').hide();
	   			}
	   			var local_orderInfoJson = storage.getItem("orderInfoJson");  				
   				if(local_orderInfoJson==null){
	   				window.location.href="index.html";
	   				return;
   				}
   				var local_businessData = storage.getItem("businessData");
   				if(local_businessData==null){
	   				window.location.href="index.html";
	   				return;
   				}
   				orderInfoJson = JSON.parse(local_orderInfoJson);
   				businessData = JSON.parse(local_businessData);
   				var order_id = orderInfoJson.merchantSeq;
   				var order_money_id = orderInfoJson.amount;
   				$("#order_id").html(order_id);
   				$("#order_money_id").val(order_money_id.parseFen2Yuan()); 
   				
   				var userChName = localstorage.getItem("userChName");
   				$("#user_name_id").html("收款商户："+userChName);
  				$("#merchant_name_id").html("收款商户："+userChName);
  				
  				var tradeType = storage.getItem("tradeType");
  				if(tradeType=='3'){//微信正扫
  					$("#trade_type_img_id").attr("src","img/weixin_03.png");
  					TRADETYPE_FAN_SAO = "1";
  					pay();
  				}else if(tradeType=='6'){//支付宝正扫
  					$("#trade_type_img_id").attr("src","img/zhifubao_03.png");
  					TRADETYPE_FAN_SAO = "5";
  					pay();
  				}else{
  					alert("请返回选择支付方式");
	   				window.location.href="index.html";
	   				return;
  				}
   			});
  			
   			//获取二维码
   			function pay(){
   				showBg("生成二维码中...");
				//支付==================================================
				var erWeiMa_bsContext = getRequestPayBody(TRADETYPE_FAN_SAO,"",businessData);
				var erWeiMa_bsContext_Json = JSON.stringify(erWeiMa_bsContext);
				var key = CryptoJS.enc.Utf8.parse(businessData.tokenKey);  //
			    var iv  = CryptoJS.enc.Utf8.parse('');  //
			   	var srcs = CryptoJS.enc.Utf8.parse(erWeiMa_bsContext_Json);
			    var encrypted = CryptoJS.AES.encrypt(srcs, key, {iv: iv, mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
			    var encryptedJson =encrypted.ciphertext.toString().toUpperCase();
				
			    var payParams = getRequestJson(encryptedJson,businessData);
			    var pay_url_temp = com_path+"/appserver/pay.do";
	   			$.ajax({
   	   				type:"POST",
   	   				url:pay_url_temp,
   	   				dataType:"json",
   	   				contentType:"application/json",
   	   				data:JSON.stringify(payParams),
   	   				success:function(data){
							var tradeStatus;
							try{
   								var result = data;
   								if(result==undefined){
   									gotoResult(4);
   									return;
   								}
   								var bsContext = data; 
   								
								//判断状态
								var bsContext_msg = getStatusMsg(bsContext);
								if(bsContext_msg!=0){
				   					storage.payErrMsg="0|"+bsContext_msg;
				   					window.location.href = "payError.html";
									return;
								}
   								
   								var businessContext = bsContext.businessContext;
   								if(businessContext==''){
   									gotoResult(4);
   									return;
   								}
   								//AES解密
   								var key = CryptoJS.enc.Utf8.parse(businessData.tokenKey);  //
   								var iv  = CryptoJS.enc.Utf8.parse('');  //
   							    var encryptedHexStr = CryptoJS.enc.Hex.parse(businessContext);
   							    var srcs = CryptoJS.enc.Base64.stringify(encryptedHexStr);
   							    var decrypt = CryptoJS.AES.decrypt(srcs, key, { iv: iv,mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
   							    var responseJson_ = decrypt.toString(CryptoJS.enc.Utf8); 
   							    var responseJson = JSON.parse(responseJson_);
   							    tradeStatus = responseJson.tradeStatus;
   								var imgMsg  =$.base64.decode(responseJson.payInfo);
   							
   								showQrcode(imgMsg);
   								hiddenBg();
   								//掉查询接口
								againQuery();
							}catch(paye){
   								gotoResult(4);
   								return;
							}
					},
					error : function() {// 调用出错执行的函数
						flag = true;
						gotoResult(5);
						return;
					}
				});
  			}
   			
   			//查询支付结果
   			var loopFlag = 0;//不用继续查询标记
   			var loopCount = 0;
   			function queryPay(){
   				if(loopCount>=50){//查询超时
   					gotoResult(3);
   					return;
   				}
   				
   				//查询==================================================
   				//var query_bsContext = getRequestQueryBody(TRADETYPE_FAN_SAO,businessData);
   				//var query_bsContext_Json = JSON.stringify(query_bsContext);
   				var query_bsContext_Json = getRequestQueryBody(TRADETYPE_FAN_SAO,businessData);
   				var key = CryptoJS.enc.Utf8.parse(businessData.tokenKey);  //
   			    var iv  = CryptoJS.enc.Utf8.parse('');  //
   			   	var srcs = CryptoJS.enc.Utf8.parse(query_bsContext_Json);
   			    var encrypted = CryptoJS.AES.encrypt(srcs, key, {iv: iv, mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
   			    var encryptedJson =encrypted.ciphertext.toString().toUpperCase();	
   			    var queryParams = getRequestJson(encryptedJson,businessData);
   					
   			 	var query_url_temp = com_path+"/appserver/query.do";
   			 	loopCount++;
	   			$.ajax({
   	   				type:"POST",
   	   				url:query_url_temp,
   	   				dataType:"json",
   	   				contentType:"application/json",
   	   				data:JSON.stringify(queryParams),
   	   				success:function(data){     			 	
   						 	var tradeStatus;
   							try{
   	   							var result = data;
   	   							var bsContext = data; 
   	   							
								//判断状态
								var bsContext_msg = getStatusMsg(bsContext);
								if(bsContext_msg!=0){
									//开头0是特定信息错误== 0|错误码|错误信息|订单号
				   					storage.payErrMsg="0|"+bsContext_msg;
				   					window.location.href = "payError.html";
									return;
								}

   	   							var businessContext = bsContext.businessContext;
   	   							//AES解密
   	   							var key = CryptoJS.enc.Utf8.parse(businessData.tokenKey);  //
   	   							var iv  = CryptoJS.enc.Utf8.parse('');  //
   	   						    var encryptedHexStr = CryptoJS.enc.Hex.parse(businessContext);
   	   						    var srcs = CryptoJS.enc.Base64.stringify(encryptedHexStr);
   	   						    var decrypt = CryptoJS.AES.decrypt(srcs, key, { iv: iv,mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
   	   						    var responseJson_ = decrypt.toString(CryptoJS.enc.Utf8); 
   	   						    var responseJson = JSON.parse(responseJson_);
   	   						   	tradeStatus = responseJson.tradeStatus;
   							}catch(querye){
   								//掉查询接口
   								againQuery();
   								return;
   							}

   							switch (tradeStatus) {
   							case 'S':
   								loopFlag=1;
   								showBg("支付成功!");
   								//跳结果页面打印
   								gotoResult(1);
   								break;
   							case 'E':
   								loopFlag=1;
   								gotoResult(2);
   								break;							
   							default:
   								//掉查询接口
   								againQuery();
   								break;
   							}
   					},
					error : function() {// 调用出错执行的函数
						//掉查询接口
						againQuery();
   					}   	   				
	   			});
   			}
   			//循环多次查询结果
   			function againQuery(){
   				if(loopFlag==0){
   					setTimeout(queryPay, "2000");
   				}	
   			}
   			//跳转结果页面 1成功,  2失败,  3查询失败,4获取二维码失败  100返回首页  
   			function gotoResult(re){
   				if(re==1){
   					window.location.href = "paySuccess.html";
   				}else if(re==2){
   					//开头1是特定信息错误== 1|错误信息
   					storage.payErrMsg="1|支付失败";
   					window.location.href = "payError.html";
   				}else if(re==3){
   					storage.payErrMsg="1|查询支付结果失败";
   					window.location.href = "payError.html";
   				}else if(re==4){
   					storage.payErrMsg="1|获取二维码失败";
   					window.location.href = "payError.html";
   				}else if(re==5){
   					storage.payErrMsg="1|服务器繁忙";
   					window.location.href = "payError.html";
   				}else{
   					window.location.href = "index.html";
   				}
   			}
 
			function showQrcode(urlmsg){
				$('#erweima_image_id').html("");
				//$('#erweima_image_id').qrcode({width:160,height:160,text:urlmsg,render:"table"});
				$('#erweima_image_id').qrcode({width:160,height:160,text:urlmsg,render:"canvas"});
			}

   		</script>
   		
		<input type="hidden" id="time_id" value="<%=time%>">
	</body>
</html>