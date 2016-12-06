	//显示等待
	function showBg(msg){
		$("#loading_msg_id").html(msg);
		$(".common_show_id").hide();
		$("#loading_id").show();
	}
	//取消等待
	function hiddenBg(){
		$(".common_show_id").show();
		$("#loading_id").hide();
	}
	//得到状态提示信息
	function getStatusMsg(obj){
		var gateReturnType = obj.gateReturnType;
		if(gateReturnType!="R"&&gateReturnType!="S"&&gateReturnType!=""){
			//var message = "";
			return obj.gateReturnCode+"|"+obj.gateReturnMessage+"|"+obj.gateSeq;
			//return "错误码:"+obj.gateReturnCode+" 错误信息:"+obj.gateReturnMessage+" 订单号:"+obj.gateSeq;
		}else{
			return 0;
		}
	}
	
	//修改密码
	function changePassword(){
		window.location.href="changePassword.html";
	}
	//退出
	function quitLogin(){
		storage.clear(); 
		localstorage.token = null;
		localstorage.userChName = '';
		localstorage.token_flag='0';
		if(localstorage.hiddenflag!=null && localstorage.hiddenflag!=undefined && localstorage.hiddenflag!=''){
			if(localstorage.hiddenflag==1){
				localstorage.clear();
				localstorage.hiddenflag=1;
			}else{
				localstorage.clear();
			}
		}else{
			localstorage.clear();
		}
		
		window.location.href="login.jsp";
	}
	//返回首页
	function  backMoney(){
		//删除session 跳转页面
		storage.clear();
		window.location.href = "index.jsp";
	}	
	
	function getUrlParam(name){  
		//构造一个含有目标参数的正则表达式对象  
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");  
			 //匹配目标参数  
		var r = window.location.search.substr(1).match(reg);  
		//返回参数值  
		if (r!=null) return unescape(r[2]);  
		return null;  
	} 
	