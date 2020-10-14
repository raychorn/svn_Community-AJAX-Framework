<cfsetting enablecfoutputonly="Yes" showdebugoutput="No">

	<cfset bool_sessionLoggedin = ( (IsDefined("session.persistData.loggedin")) AND (session.persistData.loggedin) AND (IsDefined("Session.persistdata.QAUTHUSER")) AND (IsQuery(Session.persistdata.QAUTHUSER)) )>

	<cfoutput>
		
<cfif (1)>
		<div id="#Request.cf_div_floating_debug_menu#" style="display: inline; height: 20px; background-color: ##80FFFF; border: thin solid Black;">
			<table width="*" border="0" cellpadding="-1" cellspacing="-1" style="margin-left: 5px; margin-right: 5px;">
				<tr>
					<td align="left" valign="top">
						<table width="100%" cellpadding="-1" cellspacing="-1">
							<tr>
	<cfif (Request.commonCode.isServerLocal()) OR (Request.cf_isDebugMode)>
								<td align="left">
									<span class="onholdStatusBoldClass">AJAX:</span>&nbsp;<button name="btn_helperPanel" id="btn_helperPanel" class="buttonMenuClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" title="Click this button to open the ezAJAX(tm) Debug Panel" onclick="var cObj = $('td_ajaxHelperPanel'); var bObj = $('btn_helperPanel'); var tbObj = $('table_ajaxHelperPanel'); if ( (!!cObj) && (!!bObj) && (!!tbObj) ) { cObj.style.display = ((cObj.style.display == const_none_style) ? const_inline_style : const_none_style); labelButtonByObj(bObj, ((cObj.style.display == const_inline_style) ? '[<<]' : '[>>]')); if (cObj.style.display == const_inline_style) { tbObj.style.width = _global_clientWidth; repositionBasedOnFloatingDebugPanel(tbObj); oAJAXEngine.setDebugMode(); } else { oAJAXEngine.setReleaseMode(); }; }; return false;">[>>]</button>&nbsp;
								</td>
								<td align="left">
									<span class="onholdStatusBoldClass">Scopes:</span>&nbsp;<button name="btn_helperPanel2" id="btn_helperPanel2" class="buttonMenuClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" title="Click this button to open the Scopes Debug Panel" onclick="handle_ajaxHelper2_onClick(); return false;">[>>]</button>  <!--- var oO = _$(const_div_floating_debug_menu); if (!!oO) { _alert(oO.innerHTML); }; --->
								</td>
	</cfif>
	<cfif 0>
								<td>
									<input id="radioBtn_allowArticleBrowserScroll" name="controlArticleBrowserScroll" type="radio" onclick="performAllowArticleBrowserScroll(false); return true;">&nbsp;<span class="normalSmallStatusBoldClass">Articles Scroll</span>
									&nbsp;|&nbsp;
									<input id="radioBtn_disallowArticleBrowserScroll" name="controlArticleBrowserScroll" type="radio" checked onclick="performAllowArticleBrowserScroll(true); return true;">&nbsp;<span class="normalSmallStatusBoldClass">Articles No-Scroll</span>
								</td>
	</cfif>
	<cfif (1)>
		<cfif (NOT bool_sessionLoggedin)>
									<td>
		<cfif (Request.commonCode.isServerLocal())>
										&nbsp;|&nbsp;
		</cfif>
										<button name="btn_registerButton" id="btn_registerButton" type="button" class="registerButtonClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="this.disabled = true; performOpenLoginRegisterWindow2(this.id); return false;">Register</button>
									</td>
		</cfif>
									<td>
										&nbsp;|&nbsp;
										<cfif (NOT bool_sessionLoggedin)>
											<button name="btn_loginButton" id="btn_loginButton" type="button" class="loginButtonClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="this.disabled = true; performOpenLoginRegisterWindow2(this.id); return false;">Login</button>
										<cfelse>
											<cfset _usersFullName = Request.commonCode.loggedInUsersFullName()>
											<span class="normalPrompt"><NOBR>Welcome back <u>#_usersFullName#</u>.</NOBR>&nbsp;</span>
											<button name="btn_logoffButton" id="btn_logoffButton" type="button" class="loginButtonClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onkeydown="if (event.keyCode == 13) { return true; };" onclick="this.disabled = true; performUserLogoffAction(); return false;">Logoff</button>
											<span class="normalPrompt">&nbsp;<NOBR>Kindly Logoff if you are not <u>#_usersFullName#</u>.</NOBR></span>
										</cfif>
									</td>
		<cfif (NOT bool_sessionLoggedin)>
									<td>
										&nbsp;|&nbsp;
										<button name="btn_forgotPasswordButton" id="btn_forgotPasswordButton" type="button" class="forgotPasswordButtonClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="this.disabled = true; performOpenLoginRegisterWindow2(this.id); return false;">Forgot Password</button>
									</td>
		</cfif>
		<cfif (bool_sessionLoggedin)>
									<td>
										&nbsp;|&nbsp;
										<button name="btn_purchasePremiumButton" id="btn_purchasePremiumButton" type="button" <cfif NOT (Session.persistData.blogname is 'default')>style="display: none;"</cfif> class="premiumButtonClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="this.disabled = true; performOpenLoginRegisterWindow2(this.id); return false;">Premium Account</button>
									</td>
		</cfif>
		<cfif (bool_sessionLoggedin)>
									<td>
										&nbsp;|&nbsp;
										<button name="btn_contactUs" id="btn_contactUs" type="button" <cfif NOT (Session.persistData.blogname is 'default')>style="display: none;"</cfif> class="premiumButtonClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="displayContactUsContentIn('div_contactUsContent', 'performContactUsAction', 'support@contentopia.net'); return false;">Contact Us</button>
									</td>
		</cfif>
	</cfif>
		<cfif (Request.commonCode.isServerLocal())>
									<td>
										<NOBR>
										&nbsp;|&nbsp;
										<span class="normalx9TextClass">isIE = [#Request.commonCode.isBrowserIE()#]</span>
										&nbsp;|&nbsp;
										<span class="normalx9TextClass">isFF = [#Request.commonCode.isBrowserFF()#]</span>
										&nbsp;|&nbsp;
										<span class="normalx9TextClass">isNS = [#Request.commonCode.isBrowserNS()#]</span>
										&nbsp;|&nbsp;
										<span class="normalx9TextClass">isOP = [#Request.commonCode.isBrowserOP()#]</span>
										</NOBR>
									</td>
		</cfif>
							</tr>
						</table>
					</td>
				</tr>
				<tr bgcolor="##FFFFA8">
					<td id="td_loginRegisterFrame" align="left" style="display: none;">
						<div align="left" style="<cfif (Request.commonCode.isBrowserIE())>border-left: thin solid Black; border-right: thin solid Black; border-top: thin solid Black;<cfelse>border: thin solid Black;</cfif>">
							<table width="100%" cellpadding="-1" cellspacing="-1">
								<tr bgcolor="##DDDDDD">
									<td valign="top" align="right">
										<button id="btn_closeLoginRegisterFrame" class="buttonClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="this.disabled = true; performCloseLoginRegisterWindow(); return false;">[X]</button>
									</td>
								</tr>
								<tr>
									<td valign="top" align="left">
										<div id="div_loginRegisterOuterWrapper">
											<div id="div_loginRegisterForm"></div>
											<div id="div_forgotPasswordForm"></div>
											<div id="div_registerForm"></div>
											<div id="div_premiumForm"></div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<cfif (Session.persistData.blogname is 'default')>
					<tr>
						<td>
							<div id="div_contactUsContent2"></div>
						</td>
					</tr>
				</cfif>
			</table>
		</div>
		
		<table id="table_menuHelperPanel" width="100%" bgcolor="##80FFFF" border="1" cellpadding="-1" cellspacing="-1">
			<tr>
				<td id="td_menuHelperPanel" style="display: none;" align="left" valign="top">
					<textarea id="ta_menuHelperPanel" readonly rows="5" cols="175" class="textClass"></textarea>
				</td>
			</tr>
		</table>
		
		<table width="100%" cellpadding="-1" cellspacing="-1">
			<tr>
				<td align="center" id="td_ajaxHelperPanel" style="display: none;">
					<table width="100%" bgcolor="##80FFFF" border="1" bordercolor="silver" cellspacing="-1" cellpadding="-1" id="table_ajaxHelperPanel" style="width: 800px;">
						<tr>
							<td>
								<table width="100%" cellpadding="-1" cellspacing="-1">
									<tr>
										<td width="16%" align="center">
											<button name="btn_useDebugMode" id="btn_useDebugMode" class="buttonMenuClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="var s = getButtonLabelByObj(this); if (s.toUpperCase().indexOf('DEBUG') != -1) { oAJAXEngine.setReleaseMode(); labelButtonByObj(this, labelDebug2ReleaseButton); } else { oAJAXEngine.setDebugMode(); labelButtonByObj(this, labelRelease2DebugButton); }; return false;">[Debug Mode]</button>
										</td>
										<td width="17%" align="center">
											<button name="btn_useXmlHttpRequest" id="btn_useXmlHttpRequest" class="buttonMenuClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="var s = getButtonLabelByObj(this); var bObj = _$('btn_hideShow_iFrame'); if (s.toUpperCase().indexOf('XMLHTTPREQUEST') == -1) { oAJAXEngine.isXmlHttpPreferred = false; labelButtonByObj(this, labelIFrame2XmlHttpRequestButton); } else { oAJAXEngine.isXmlHttpPreferred = true; labelButtonByObj(this, labelXmlHttpRequest2IFrameButton); }; if (!!bObj) { bObj.style.display = ((oAJAXEngine.isXmlHttpPreferred) ? const_none_style : const_inline_style); } return false;">[Use iFrame]</button>
										</td>
										<td width="16%" align="center">
											<button name="btn_useMethodGetOrPost" id="btn_useMethodGetOrPost" class="buttonMenuClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="var s = getButtonLabelByObj(this); if (s.toUpperCase().indexOf('GET') != -1) { oAJAXEngine.setMethodGet(); labelButtonByObj(this, labelGet2PostButton); } else { oAJAXEngine.setMethodPost(); labelButtonByObj(this, labelPost2GetButton); }; return false;">[Use Get]</button>
										</td>
										<td width="17%" align="center">
											<button name="btn_hideShow_iFrame" id="btn_hideShow_iFrame" class="buttonMenuClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="var s = getButtonLabelByObj(this); if (s.toUpperCase().indexOf('SHOW') != -1) { oAJAXEngine.showFrame(); labelButtonByObj(this, labelShow2HideButton); } else { oAJAXEngine.hideFrame(); labelButtonByObj(this, labelHide2ShowButton); }; return false;">[Show iFrame]</button>
										</td>
										<td width="17%" align="center">
											<input type="checkbox" id="cb_debugPanel_toggle_AJAX_echo" onclick="global_echo_AJAX_commands = ((global_echo_AJAX_commands) ? false : true); return true;">&nbsp;<a href="" onclick="simulateCheckBoxClick('cb_debugPanel_toggle_AJAX_echo'); return false;"><span class="textClass"><NOBR>Echo ezAJAX&##8482 Commands</NOBR></span></a>
										</td>
										<td width="17%" align="center">
											<button name="btn_1" id="btn_1" class="buttonMenuClass<cfif (Request.commonCode.isBrowserFF() OR Request.commonCode.isBrowserNS())>FF</cfif>" onclick="doAJAX_func('getTopLevelMenuNames'); return false;">[Test]</button>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
	<cfif (Request.commonCode.isServerLocal())>
		<cfsavecontent variable="content_application_debug_panel">
			<cfoutput>
				#Request.commonCode.scopesDebugPanelContentLayout()#
			</cfoutput>
		</cfsavecontent>		
		
		<table id="table_ajaxHelperPanel2" style="width: 800px;" cellpadding="-1" cellspacing="-1">
			<tr>
				<td id="td_ajaxHelperPanel2" align="center" style="display: none;">
					<table border="1" cellspacing="-1" cellpadding="-1">
						<tr>
							<td align="center">
								#content_application_debug_panel#
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</cfif>
</cfif>
</cfoutput>

