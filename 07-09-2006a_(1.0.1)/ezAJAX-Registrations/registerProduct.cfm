<cfsetting showdebugoutput="No" requesttimeout="120" enablecfoutputonly="Yes">
<!--- 
		ezAJAX-Registrations/registerProduct.cfm
		This system takes the information from the client who is installing the product with the end result being a valid
		Runtime License file that is downloaded by the Installer program during the installation process.
 --->
<cfparam name="URL.computerID" type="string" default="">
<cfparam name="URL.serverName" type="string" default="">
<cfparam name="URL.userName" type="string" default="">

<cfset echoEmailAddrs = "support@ez-ajax.com">

	<cfsavecontent variable="successfulProductRegistrationNotice">
		<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>&copy; Hierarchical Applications Limited, All Rights Reserved.</title>
</head>

<body>

<H3 style="color: blue;">Congratulations on successfully Registering your copy of exAJAX&##8482 Community Edition Framework</H3>

<small>Your Runtime License file is attached.  You may place this file in the root folder where you installed exAJAX&##8482 Community Edition Framework.</small>

</body>
</html>
		</cfoutput>
	</cfsavecontent>
	
	<cfsavecontent variable="resentProductRegistrationNotice">
		<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>&copy; Hierarchical Applications Limited, All Rights Reserved.</title>
</head>

<body>

<H3 style="color: blue;">Congratulations Again on successfully Registering your copy of exAJAX&##8482 Community Edition Framework</H3>

<small>Your Runtime License file is attached.  You may place this file in the root folder where you installed exAJAX&##8482 Community Edition Framework.</small>

</body>
</html>
		</cfoutput>
	</cfsavecontent>
	
	<cffunction name="errorReportNotification" output="No" access="public" returntype="string">
		<cfargument name="_noticeTxt_" type="string" required="Yes">
		<cfargument name="_extraTxt_" type="string" required="Yes">
		
		<cfsavecontent variable="_html">
			<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>&copy; Hierarchical Applications Limited, All Rights Reserved.</title>
</head>

<body>

<H5 style="color: red;">#_noticeTxt_#, #_extraTxt_#</H5>

</body>
</html>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn _html>
	</cffunction>

<cfscript>
	Request.ezAJAX_DSN = 'ezAJAX-Registrations';

	function getRuntimeLicenseForEndDate(aDate, aProductName, computerID, productVersion, aServerName, aFilePath) {
		var aStruct = StructNew();
		var _wddxData = '';
		var _wddxDataStream = '';
		aStruct.runtimeLicenseExpirationDate = aDate;
		aStruct.RuntimeLicenseStatus = '';
		aStruct.computerID = Trim(computerID);
		aStruct.ProductName = aProductName;
		aStruct.ServerName = aServerName;
		aStruct.productVersion = productVersion;
		aStruct.ColdfusionID = server.coldfusion.productname & ' ' & ListFirst(server.coldfusion.productversion) & '.' & ListGetAt(server.coldfusion.productversion, 2);
		aStruct.isCommunityEdition = true;
		aStruct.copyrightNotice = '&copy; 1990-#Year(Now())# Hierarchical Applications Limited, All Rights Reserved.  Use of or duplication of this software or any software derived from its use is illegal unless specific written permission has been granted by Hierarchical Applications Limited or a duly appointed Officer of this corporation.';
		_wddxData = Request.commonCode.CFML2WDDX(aStruct);
		_wddxDataStream = Request.commonCode.asBlowfishEncryptedHex(_wddxData);

		aStruct._wddxDataStream = _wddxDataStream;
		aStruct.filePath = aFilePath;

		Request.commonCode.cf_file_write(ExpandPath(aFilePath), _wddxDataStream);
		return aStruct;
	}
	
	extraError = '';
	
	endDate = DateAdd('d', 30, Now());
	cf_trademarkSymbol = '&##8482';
	productVersion = 0.9;
	productName = 'exAJAX#cf_trademarkSymbol# Community Edition Framework';
	URL.computerID = Trim(URLDecode(URL.computerID));
	URL.serverName = Trim(URLDecode(URL.serverName));
	URL.userName = Trim(URLDecode(URL.userName));

	if ( (Len(Trim(URL.userName)) gt 0) AND (ListLen(URL.userName, '@') eq 2) AND (ListLen(URL.userName, '.') gte 1) ) {
		_sql_statement = "SELECT id, email_domain FROM InvalidEmailDomains WHERE (email_domain = '@#ListLast(URL.userName, '@')#')";
		Request.commonCode.safely_execSQL('Request.qIsUsernameInvalid', application.blog.instance.dsn, _sql_statement);
		if (NOT Request.dbError) {
			if (Request.qIsUsernameInvalid.recordCount gte 0) { // this allows any email address to be used...
				_sql_statement = "SELECT id, username FROM UserNames WHERE (username = '#URL.userName#')";
				Request.commonCode.safely_execSQL('Request.qGetUserID', Request.ezAJAX_DSN, _sql_statement);
				if (NOT Request.dbError) {
					uid = -1;
					if (Request.qGetUserID.recordCount gt 0) {
						uid = Request.qGetUserID.id;
					}
					if (uid eq -1) {
						_sql_statement = "INSERT INTO UserNames (username) VALUES ('#URL.userName#'); SELECT @@IDENTITY as 'id';";
						Request.commonCode.safely_execSQL('Request.qAddUserName', Request.ezAJAX_DSN, _sql_statement);
						if (NOT Request.dbError) {
							if (Request.qAddUserName.recordCount gt 0) {
								uid = Request.qAddUserName.id;
							}
						}
					}
		
					if (NOT Request.dbError) {
						sid = -1;
						// this is no way to enforce a rule that says the server name cannot be a short domain name or IP address as this might frustrate some users...
			//			if ( (ListLen(URL.serverName, '.') gte 2) AND (NOT Request.commonCode.isIPAddress(URL.serverName)) ) {
						if (Len(URL.serverName) gt 0) { // this allows any server name one might imagine using even IP addresses...
							_sql_statement = "SELECT id, uid, serverName FROM ServerNames WHERE (serverName = '#URL.serverName#')";
							Request.commonCode.safely_execSQL('Request.qCheckServerName', Request.ezAJAX_DSN, _sql_statement);
							if (NOT Request.dbError) {
								bool_isServerNameTaken = false;
								if (Request.qCheckServerName.recordCount eq 0) {
									_sql_statement = "INSERT INTO ServerNames (uid, serverName) VALUES (#uid#, '#URL.serverName#'); SELECT @@IDENTITY as 'id';";
									Request.commonCode.safely_execSQL('Request.qAddServerName', Request.ezAJAX_DSN, _sql_statement);

									if (NOT Request.dbError) {
										sid = Request.qAddServerName.id;
									}
								} else {
									sid = Request.qCheckServerName.id;
									bool_isServerNameTaken = (uid neq Request.qCheckServerName.uid);
								}
		
								if ( (NOT Request.dbError) AND (sid neq -1) ) {
									if (NOT bool_isServerNameTaken) {
										aFilePath = URL.serverName;
										isError = false;
										try {
											if (NOT DirectoryExists(ExpandPath(aFilePath))) {
												Request.commonCode.cf_makeDirectory(ExpandPath(aFilePath));
											}
										} catch (Any e) {
											isError = true;
										}
										if (NOT isError) {
											if ( (ListLen(URL.computerID, '|') eq 3) AND (Len(URL.serverName) gt 0) ) {
												aStruct = getRuntimeLicenseForEndDate(endDate, productName, URL.computerID, productVersion, URL.serverName, aFilePath & '/runtimeLicense.dat');
												bool_isCommunityEdition = 0;
												if (aStruct.isCommunityEdition) {
													bool_isCommunityEdition = 1;
												}
												_sql_statement = "INSERT INTO RuntimeLicenses (sid, expirationDate, computerID, ProductName, productVersion, ServerName, ColdfusionID, isCommunityEdition, copyrightNotice, RuntimeLicenseData) VALUES (#sid#,#CreateODBCDateTime(aStruct.runtimeLicenseExpirationDate)#,'#aStruct.computerID#','#aStruct.ProductName#','#aStruct.productVersion#', '#aStruct.ServerName#','#aStruct.ColdfusionID#',#bool_isCommunityEdition#,'#aStruct.copyrightNotice#','#aStruct._wddxDataStream#'); SELECT @@IDENTITY as 'id';";
												Request.commonCode.safely_execSQL('Request.qAddLicenseToDb', Request.ezAJAX_DSN, _sql_statement);
												if (NOT Request.dbError) {
													// email the file to the URL.userName...
													optionsStruct = StructNew();
													optionsStruct.bcc = echoEmailAddrs;
													optionsStruct.cfmailparam = StructNew();
													optionsStruct.cfmailparam.type = 'text/plain';
													optionsStruct.cfmailparam.file = 'http:' & '/' & '/' & CGI.SERVER_NAME & ListSetAt(CGI.SCRIPT_NAME, ListLen(CGI.SCRIPT_NAME, '/'), aStruct.filePath, '/');
													Request.commonCode.safely_cfmail(URL.userName, 'do-not-respond@ez-ajax.com', 'Attached is your Runtime License for ezAJAX(tm) for #URL.userName# / #aStruct.ServerName#', successfulProductRegistrationNotice, optionsStruct);
													if (NOT Request.anError) {
														dataStream = 'OK';
													} else {
														extraError = extraError & Request.errorMsg;
														dataStream = 'Error 101. The Runtime License has been assigned to you however it cannot be emailed to you due to some kind of technical issue that is being resolved.  Kindly send an email to registrations@ez-ajax.com to request that your Runtime License file be emailed to you directly and this will be done.';
													}
												} else {
											//		Request.commonCode.cf_file_delete(ExpandPath(aFilePath & '/runtimeLicense.dat'));
											//		Request.commonCode.cf_removeDirectory(ExpandPath(aFilePath));
													if (NOT Request.isPKviolation) {
														extraError = extraError & Request.explainErrorText;
														dataStream = 'Error 102. The Username entered cannot be used due to some kind of technical issue we are in the process of resolving.';
													} else {
														dataStream = 'Warning 102. Another Runtime License cannot be created at this time because there is already a Runtime License issued for the same physical computer as the one just submitted. Only one Trial License per physical computer can be issued.  Can can transfer a Trial License upon request for a nominal fee, contact us at sales@ez-ajax.com.';
													}
												}
											} else {
												dataStream = 'Error 103. Invalid or Missing parameters that were required for product registration.';	
											}
										} else {
											extraError = extraError & Request.directoryPlainErrorMsg;
											dataStream = 'Error 104. The Runtime License cannot be assigned for the domain name provided because the domain name is invalid.';	
										}
									} else {
										aFilePath = URL.serverName;
										optionsStruct = StructNew();
										optionsStruct.bcc = echoEmailAddrs;
										optionsStruct.cfmailparam = StructNew();
										optionsStruct.cfmailparam.type = 'text/plain';
										optionsStruct.cfmailparam.file = 'http:' & '/' & '/' & CGI.SERVER_NAME & ListSetAt(CGI.SCRIPT_NAME, ListLen(CGI.SCRIPT_NAME, '/'), aFilePath & '/runtimeLicense.dat', '/');
										Request.commonCode.safely_cfmail(URL.userName, 'do-not-respond@ez-ajax.com', 'Attached is your Runtime License for ezAJAX(tm) for #URL.userName# / #URL.serverName#', resentProductRegistrationNotice, optionsStruct);
										if (NOT Request.anError) {
											dataStream = 'Notice 105. Your Runtime License, which was previously created for you, has been resent to your email address.';	
										} else {
											dataStream = 'Error 105. Your Runtime License cannot be resent to you due to a problem with the system that will be resolved soon.';	
										}
									}
								} else {
									extraError = extraError & Request.explainErrorText;
									dataStream = 'Error 106. The Username entered cannot be used due to some kind of technical issue we are in the process of resolving.';	
								}
							} else {
								extraError = extraError & Request.explainErrorText;
								dataStream = 'Error 107. The Username entered cannot be used due to some kind of technical issue we are in the process of resolving.';	
							}
						} else {
							dataStream = 'Error 108. The Server Name entered cannot be used because it does not appear to be a valid Domain Name for the purposes of creating a usable Runtime License for this product.';	
						}
					} else {
						extraError = extraError & Request.explainErrorText;
						dataStream = 'Error 109. The Username entered cannot be used due to some kind of technical issue we are in the process of resolving.';	
					}
				} else {
					extraError = extraError & Request.explainErrorText;
					dataStream = 'Error 110. The Username entered cannot be used due to some kind of technical issue we are in the process of resolving.';	
				}
			} else {
				dataStream = 'Error 111. The Username entered cannot be used because it is invalid - the domain for the username is known to provide anonymous email services.';	
			}
		} else {
			extraError = extraError & Request.explainErrorText;
			dataStream = 'Error 112. The Username entered cannot be used due to some kind of technical issue we are in the process of resolving.';	
		}
	} else {
		dataStream = 'Error 113. The Username entered cannot be used because it is invalid - your username MUST be a valid Internet Email address however (#URL.userName#) is not valid.';	
	}
</cfscript>

<cfif (FindNoCase('Error ', dataStream) gt 0)>
	<cfscript>
		Request.commonCode.safely_cfmail(echoEmailAddrs, 'do-not-respond@ez-ajax.com', 'ezAJAX(tm) Registration System Error Report', errorReportNotification(dataStream, extraError));
	</cfscript>
	<cflog file="#Application.applicationName#_Registrations" type="Information" text="#dataStream#, #extraError#">
</cfif>

<cfoutput>
<CFHEADER NAME="Expires" VALUE="Mon, 06 Jan 1990 00:00:01 GMT">
<CFHEADER NAME="Pragma" VALUE="no-cache">
<CFHEADER NAME="cache-control" VALUE="no-cache">
<cfcontent type="text/html" variable="#ToBinary(ToBase64(dataStream))#">
</cfoutput>
