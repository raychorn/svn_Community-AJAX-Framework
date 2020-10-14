function gamesRequiresUserAccountBlock() {
	alert('Access to our Games requires a valid User Account and the user must be logged-in.  Kindly Register for a User Account or Login to begin playing.');
	var oBtn = _$('btn_registerButton');
	if (!!oBtn) {
		oBtn.onclick();
	}
}

function downloadsRequiresPremiumBlock() {
	alert('Access to Downloads requires a Premium Subscription.');
	var oBtn = _$('btn_purchasePremiumButton');
	if (!!oBtn) {
		oBtn.onclick();
	}
}

function sampleAppsRequiresLoginBlock() {
	alert('Access to Sample Apps requires a User Account and the user to be logged-in.  Kindly Register for a User Account or Login to Demo our Sample AJAX Apps.');
	var oBtn = _$('btn_loginButton');
	if (!!oBtn) {
		oBtn.onclick();
	}
}

function displayPopUpAtForDiv(oObj, anchorPos) {
	if (!!oObj) {
		oObj.style.position = const_absolute_style;
		if ( (!!anchorPos) && (!!anchorPos.x) ) oObj.style.left = (anchorPos.x - 310) + "px";
		if ( (!!anchorPos) && (!!anchorPos.y) ) oObj.style.top = (anchorPos.y - 165) + "px";
		oObj.style.display = ((oObj.style.display.length == 0) ? const_inline_style : ((oObj.style.display == const_none_style) ? const_inline_style : const_none_style));
	}
	return oObj;
}

function _validateUserAccountName(oObj, btnObj) {
	var i = -1;
	var _f2Any = false;
	if (!!oObj) {
		var _f = oObj.value.search(/^[a-zA-Z0-9._%-]+@[a-zA-Z0-9-]+\.(?:[a-zA-Z]{2}|com|org|net|biz|info|cc|ws|us|tv)$/);
		var ar = js_invalidEmailDomains.split(',');
		for (i = 0; i < ar.length; i++) {
			_f2Any = _f2Any || (oObj.value.indexOf(ar[i]) != -1);
		}
		if (!!btnObj) btnObj.disabled = ( (_f == -1) || (_f2Any) ); 
		if ( (_f == -1) || _f2Any ) {
			oObj.style.border = 'thin solid red';
			oObj.title = 'Your User Name is NOT acceptable because ' + ((_f == -1) ? '"your domain name uses an invalid TLD" ' : '') + ((_f2Any) ? '"your domain name is for an anonymous email service which is a EULA Violation" ' : '') + '.';
		} else {
			oObj.style.border = 'thin solid lime';
			oObj.title = 'Your User Name is acceptable. You may proceed, however this does not mean your email address is necessarily valid unless it can accept in-coming email from our email server(s).';
		}
		return (( (_f == -1) || (_f2Any) ) ? true : false); 
	};
	return false;
}

function validateConactUsUserEmailAddrs() {
	_validateUserAccountName($('input_emailAddress'),$('button_submit_contactUs_panel'));
}

function isValidatedRegisterUsersName() {
	var i = -1;
	var isValid = true; 
	var obj = $('register_input_yourname'); 
	var otherObj = $('register_input_username');
	var btnObj = $('button_registerSubmit'); 
	var matchObj = $('div_password_matches');
	if ( (!!obj) && (!!btnObj) && (!!otherObj) && (!!matchObj) ) { 
		if (obj.value.length > 0) {
			var ar = obj.value.split(' '); 
			for (i = 0; i < ar.length; i++) {
				ar[i] = ar[i].charAt(0).toUpperCase() + ar[i].substring(1, ar[i].length).toLowerCase();
			}
			obj.value = ar.join(' ');
			isValid = (((ar.length == 2) && (ar[0].trim().length > 0) && (ar[1].trim().length > 0)) ? false : true); 
		}
		var x = otherObj.style.border;
		var b = ( (x.length == 0) || (x.toString().indexOf('red') != -1) || (matchObj.innerHTML.indexOf('Matches') == -1) );
		btnObj.disabled = (((isValid) || (b)) ? true : false); 
		obj.style.border = ((isValid) ? 'thin solid red' : 'thin solid lime'); 
	}; 
	return isValid;
}

function performContactUsAJAXAction(actionID, addrObj, msgObj, toEmailAddrs) {
	actionID = ((!!actionID) ? actionID : '');
	toEmailAddrs = ((!!toEmailAddrs) ? toEmailAddrs : '');
	if ( (!!addrObj) && (!!msgObj) ) {
		displayPopUpAtForDiv(_$('div_contactUsContent'));
		doAJAX_func(actionID, 'handlePerformContactUsAJAXAction(' + oAJAXEngine.js_global_varName + ')', 'emailAddress', addrObj.value, 'emailMessage', msgObj.value, 'toEmailAddrs', toEmailAddrs);
	}
}

function _displayContactUsContentIn(oObj, actionID, toEmailAddrs) {
	var _html = '';
	actionID = ((!!actionID) ? actionID : '');
	if (!!oObj) {
		_html += '<table width="350px" border="1" bgcolor="#FFFFA8" cellpadding="-1" cellspacing="-1">';
		_html += '<tr bgcolor="silver">';
		_html += '<td>';
		_html += '<table width="100%" cellpadding="-1" cellspacing="-1">';
		_html += '<tr>';
		_html += '<td width="90%" align="center" valign="top">';
		_html += '<span class="normalBoldBluePrompt">Contact Us at ' + toEmailAddrs + '</span>';
		_html += '</td>';
		_html += '<td width="*" align="center" valign="top">';
		_html += '<input type="Button" id="button_dismiss_contactUs_panel" class="buttonClass" value="[X]" onclick="displayPopUpAtForDiv(_$(\'div_contactUsContent\')); return false;">';
		_html += '</td>';
		_html += '</tr>';
		_html += '</table>';
		_html += '</td>';
		_html += '</tr>';
		_html += '<tr>';
		_html += '<td>';
		_html += '<table width="100%" cellpadding="-1" cellspacing="-1">';
		_html += '<tr>';
		_html += '<td width="20%" align="left" valign="top">';
		_html += '<span class="normalBoldBluePrompt">Your Email Address:</span>';
		_html += '</td>';
		_html += '<td width="*" align="left" valign="top">';
		_html += '<input id="input_emailAddress" value="yourEmail@yourDomain.com" size="50" maxlength="255" onkeyup="if (!!validateConactUsUserEmailAddrs) { validateConactUsUserEmailAddrs() };">';
		_html += '</td>';
		_html += '</tr>';
		_html += '<tr>';
		_html += '<td>';
		_html += '<span class="normalBoldBluePrompt">Your Message:</span>';
		_html += '</td>';
		_html += '<td>';
		_html += '<textarea id="textarea_yourMessage" cols="50" rows="3"></textarea>';
		_html += '</td>';
		_html += '</tr>';
		_html += '<tr>';
		_html += '<td colspan="2">';
		_html += '<span class="normalBoldBluePrompt">Kindly allow 24-48 hours for a response.</span>';
		_html += '</td>';
		_html += '</tr>';
		_html += '<tr>';
		_html += '<td colspan="2">';
		_html += '<input type="Button" id="button_submit_contactUs_panel" class="buttonClass" value="[Submit]" onclick="performContactUsAJAXAction(\'' + actionID + '\', _$(\'input_emailAddress\'), _$(\'textarea_yourMessage\'), \'' + toEmailAddrs + '\'); return false;">';
		_html += '</td>';
		_html += '</tr>';
		_html += '</table>';
		_html += '</td>';
		_html += '</tr>';
		_html += '</table>';
		try {
			if (oObj.innerHTML.length > 0) {
				flushCache$(oObj);
			}
		} catch(e) {
		} finally {
		}
		oObj.innerHTML = _html;
		displayPopUpAtForDiv(_$('div_contactUsContent'));
	}
}

function displayContactUsContentIn(id, actionID, toEmailAddrs) {
	var oObj = _$(id);
	return _displayContactUsContentIn(oObj, actionID, toEmailAddrs);
}

function handlePerformContactUsAJAXAction(qObj) {
	var nRecs = -1;
	var oParms = -1;
	var _id = '';
	var i = -1;
	var n = -1;
	var argsDict = DictObj.get$();

	function searchForArgRecs(_ri, _dict, _rowCntName) {
		var n = _dict.getValueFor('NAME');
		var v = _dict.getValueFor('VAL');
		if (n.trim().toUpperCase().indexOf('ARG') != -1) {
			argsDict.push(n.trim(), v);
		}
	};


	var qStats = qObj.named('qDataNum');
	if (!!qStats) {
		nRecs = qStats.dataRec[1];
	}
	if (nRecs > 0) { // at present only the first data record is consumed...
		var qData1 = qObj.named('qData1');

		if (!!qData1) {
			oParms = qObj.named('qParms');
			if (!!oParms) {
				oParms.iterateRecObjs(searchForArgRecs);
				qData1.iterateRecObjs(anyErrorRecords);

				if (!bool_isAnyErrorRecords) {
					argsDict.intoNamedArgs();

					var _toEmailAddrs = argsDict.getValueFor('toEmailAddrs');
					var toDesc = 'Development Team';
					if (_toEmailAddrs.toLowerCase() == 'sales@ez-ajax.com') {
						toDesc = 'Sales Team';
					} else if (_toEmailAddrs.toLowerCase() == 'investors@ez-ajax.com') {
						toDesc = 'Investor Relations Team';
					} else if (_toEmailAddrs.toLowerCase() == 'affiliates@ez-ajax.com') {
						toDesc = 'Affiliate Relations Team';
					}
					alert('Your message has been sent to the ezAJAX(tm) ' + toDesc + '.  Kindly allow 24-48 hours for a response.');
				} else {
					if (bool_isHTMLErrorRecords) {
						_alertHTMLError(s_explainError);
					} else {
						_alertError(s_explainError);
					}
				}
			}
		}
	}
	DictObj.remove$(argsDict.id);
}
		
function validateLoginUserName() {
	_validateUserAccountName($('login_input_username'),$('button_loginSubmit'));
}

function validateForgotPasswordUserName() {
	_validateUserAccountName($('input_forgot_username'),$('button_forgotPwdSubmit'));
}

function isValidatedRegisterUserName() {
	return _validateUserAccountName($('register_input_username'));
}

function disableWidget(obj, bool) {
	if (obj != null) {
		obj.disabled = ((bool == true) ? true : false);
	}
}

function disableWidgetByID(id, bool) {
	var obj = -1;
	obj = $(id);
	disableWidget(obj, bool);
}

function analyzePassword(s) {
	var i = -1;
	var ch = -1;
	var alphaCount = 0;
	var numericCount = 0;
	var specialCount = 0;
	var o = new Object();
	
	for (i = 0; i < s.length; i++) {
		ch = s.charCodeAt(i);
		alphaCount += (((ch >= 65) && (ch <= 90)) ? 1 : 0);
		alphaCount += (((ch >= 97) && (ch <= 122)) ? 1 : 0);
		numericCount += (((ch >= 48) && (ch <= 57)) ? 1 : 0);
		specialCount += (((ch >= 33) && (ch <= 47)) ? 1 : 0);
		specialCount += (((ch >= 58) && (ch <= 64)) ? 1 : 0);
		specialCount += (((ch >= 123) && (ch <= 126)) ? 1 : 0);
	}
	o.sInput = s;
	o.alphaCount = alphaCount;
	o.numericCount = numericCount;
	o.specialCount = specialCount;
	return o;
}

function _isWeakPassword(ap) {
	return ( ( (ap.alphaCount == 0) || (ap.numericCount == 0) || (ap.specialCount == 0) ) && (ap.sInput.trim().length < 8) );
}

function isWeakPassword(s) {
	var ap = analyzePassword(s);
	
	return _isWeakPassword(ap);
}

function _isMediumPassword(ap) {
	return ( ( ( (ap.alphaCount > 0) && (ap.numericCount > 0) ) || ( (ap.alphaCount > 0) && (ap.specialCount > 0) ) && (ap.sInput.trim().length > 4) ) || ( (ap.sInput.trim().length >= 8) && (ap.sInput.trim().length < 12) ) );
}

function isMediumPassword(s) {
	var ap = analyzePassword(s);
	
	return (_isWeakPassword(ap) && _isMediumPassword(ap));
}

function _isStrongPassword(ap) {
	return ( ( (ap.alphaCount > 0) || (ap.numericCount > 0) || (ap.specialCount > 0) ) && (ap.sInput.trim().length >= 12) );
}

function isStrongPassword(s) {
	var ap = analyzePassword(s);
	
	return (_isMediumPassword(ap) && _isStrongPassword(ap));
}

function isPasswordValid(s) {
	return (s.trim().length > 0);
}
				
function validatePassword(s, sOther) {
	var bool_isPasswordValid = isPasswordValid(s);
	var bool_isOtherPasswordPresent = (sOther != null);
	var bool_isOtherPasswordValid = (((bool_isOtherPasswordPresent) && (s == sOther)) ? true : false);
	var ap = -1;
	var cObj1 = $('register_input_password');
	var cObj2 = $('register_input_confirmpassword');
	var bool_shallSubmitBtnBeDisabled = true;
	var bool_passwordsMatches = false;

	var cObj = $((bool_isOtherPasswordPresent) ? 'span_password_matches' : 'span_password_rating');
	var tdObj = $((bool_isOtherPasswordPresent) ? 'td_password_matches' : 'td_password_rating');
	try {
		if (bool_isPasswordValid) {
			// rate the password...
			ap = analyzePassword(s);
			// display the rating...
			if ( (cObj != null) && (tdObj != null) ) {
				if (bool_isOtherPasswordPresent) {
					if (s == sOther) {
						if (AJAXEngine.browser_is_ie) {
							tdObj.style.background = 'lime';
						} else {
							tdObj.style.border = 'thin solid lime;';
						}
						cObj.innerHTML = '(Matches)';
						disableWidgetByID('div_password_matches', false);
						bool_passwordsMatches = true;
					} else {
						tdObj.style.background = '';
						cObj.innerHTML = '(Does Not Match)';
						disableWidgetByID('div_password_matches', true);
						bool_passwordsMatches = false;
					}
				} else {
					if (_isStrongPassword(ap)) {
						if (AJAXEngine.browser_is_ie) {
							tdObj.style.background = 'lime';
						} else {
							tdObj.style.border = 'thin solid lime;';
						}
						cObj.innerHTML = '(Strong)';
						disableWidgetByID('div_password_rating', false);
					} else if (_isMediumPassword(ap)) {
						if (AJAXEngine.browser_is_ie) {
							tdObj.style.background = 'cyan';
						} else {
							tdObj.style.border = 'thin solid cyan;';
						}
						cObj.innerHTML = '(Medium)';
						disableWidgetByID('div_password_rating', false);
					} else if (_isWeakPassword(ap)) {
						if (AJAXEngine.browser_is_ie) {
							tdObj.style.background = 'yellow';
						} else {
							tdObj.style.border = 'thin solid yellow;';
						}
						cObj.innerHTML = '(Weak)';
						disableWidgetByID('div_password_rating', false);
					} else {
						tdObj.style.background = '';
						cObj.innerHTML = '(Not Rated)';
						disableWidgetByID('div_password_rating', true);
					}
				}
			}
		} else {
			if ( (cObj != null) && (tdObj != null) ) {
				if (bool_isOtherPasswordPresent) {
					tdObj.style.background = '';
					cObj.innerHTML = '(Does Not Match)';
					disableWidgetByID('div_password_matches', true);
					bool_passwordsMatches = false;
				} else {
					tdObj.style.background = '';
					cObj.innerHTML = '(Not Rated)';
					disableWidgetByID('div_password_rating', true);
				}
			}
		}

		bool_shallSubmitBtnBeDisabled = true;
		if ( (cObj1 != null) && (cObj2 != null) ) {
			bool_shallSubmitBtnBeDisabled = ( (cObj1.value.trim().length > 0) && (cObj2.value.trim().length > 0) );
		}

		if ( (bool_shallSubmitBtnBeDisabled == false) || (bool_passwordsMatches == false) ) {
			var mObj = $('span_register_newUser_status_message');
			if ( (mObj != null) && (cObj1.value.length > 0) && (cObj2.value.length > 0) ) {
				if (bool_isOtherPasswordValid == false) {
					mObj.innerHTML = 'WARNING: Password is not valid because it does not match or it is the first password entered.';
				} else {
					mObj.innerHTML = 'WARNING: Password is not valid because it does not contain the following characters ("a"-"z" or "A"-"Z" and "0"-"9" and any special characters). PLS enter a valid password.';
				}
			}

			disableWidgetByID('button_registerSubmit', true);
			return true;
		} else {
			var mObj = $('span_register_newUser_status_message');
			if (mObj != null) {
				mObj.innerHTML = '';
			}
			
			disableWidgetByID('button_registerSubmit', isValidatedRegisterUserName());
			return false;
		}
	} catch(e) {
	} finally {
	}

	return true;
}

function receiveRegisterData(msg) {
	var i = -1;
	var _html = '';
	var ar2 = [];
	var oObj = $('div_register_newUser_status');
	var fObj = $('body_register_newUser');
	if ( (!!oObj) && (!!fObj) ) {
		var ar = msg.split('&');
		for (i = 0; i < ar.length; i++) {
			ar2 = ar[i].split('=');
			if (ar2.length == 2) {
				if (ar2[0].toUpperCase() == 'statusMsg'.toUpperCase()) {
					_html += unescape(ar2[1]);
				} else if (ar2[0].toUpperCase() == 'showForm'.toUpperCase()) {
					fObj.style.display = ((ar2[1].toUpperCase() == 'true'.toUpperCase()) ? const_inline_style : const_none_style);
				}
			}
		}
		oObj.innerHTML = _html;
	}
}

function performSubmitRegisterForm(username, yourname, password, confirmpassword) {
//	alert('username = [' + username + ']' + ', yourname = [' + yourname + ']' + ', password = [' + password + ']' + ', confirmpassword = [' + confirmpassword + ']'); 
	if ( (!!username) && (!!yourname) && (!!password) && (!!confirmpassword) ) {
		doAJAX_func('performSubmitRegisterForm', 'handleSubmitRegisterForm(' + oAJAXEngine.js_global_varName + ')', 'username', username, 'yourname', yourname, 'password', password, 'confirmpassword', confirmpassword);
	}
}

function performSubmitLoginForm(username, password) {
//	alert('username = [' + username + ']' + ', password = [' + password + ']'); 
	if ( (!!username) && (!!password) ) {
		doAJAX_func('performSubmitLoginForm', 'handleSubmitRegisterForm(' + oAJAXEngine.js_global_varName + ')', 'username', username, 'password', password);
	}
}

function performSubmitForgotPasswordForm(username) {
//	alert('username = [' + username + ']'); 
	if (!!username) {
		doAJAX_func('performSubmitForgotPasswordForm', 'handleSubmitRegisterForm(' + oAJAXEngine.js_global_varName + ')', 'username', username);
	}
}

function performUserLogoffAction() {
	doAJAX_func('performUserLogoffAction', 'handleSubmitRegisterForm(' + oAJAXEngine.js_global_varName + ')');
}

function redirectBrowserToUrl(aURL) {
	if (!!aURL) {
		window.location.href = aURL;
	}
}
