<cfsetting requesttimeout="120">
<!--- BEGIN: This block of code sets-up the Request.qryObj which is a ColdFusion Query Object that holds the parms from the ezAJAX(tm) call --->
<!--- Request.qryStruct also contains the variables that were passed-in from the caller... --->
<cfinclude template="cfinclude_AJAX_Begin.cfm">
<!--- END! This block of code sets-up the Request.qryObj which is a ColdFusion Query Object that holds the parms from the ezAJAX(tm) call --->

<cfscript>
	aRuntimeLicenseStruct = Request.commonCode.readRuntimeLicenseFile();
	RuntimeLicenseStatus = aRuntimeLicenseStruct.RuntimeLicenseStatus;
	bool_RuntimeLicenseStatus = (Len(aRuntimeLicenseStruct.RuntimeLicenseStatus) eq 0);
</cfscript>

<cfif (0)>
	<cfdump var="#aRuntimeLicenseStruct#" label="aRuntimeLicenseStruct" expand="No">
</cfif>

<!--- This is where you may code your ColdFusion code that processes the ezAJAX(tm) Function --->
<cfif (IsDefined("Request.qryStruct.cfm"))>
	<cfscript>
		bool_onChangeSubMenu = false;
		Request.qryStruct.namedArgs = StructNew();
		if (IsDefined("Request.qryStruct.argCnt")) {
			try {
				for (i = 1; i lte Request.qryStruct.argCnt; i = i + 2) {
					argName = Request.qryStruct['arg' & i];
					argVal = Request.qryStruct['arg' & (i + 1)];
					Request.qryStruct.namedArgs[argName] = argVal;
				}
			} catch(Any e) {
			}
		}
		if (bool_RuntimeLicenseStatus) {
			if ( (IsDefined("Request.qryStruct.referer")) AND (FindNoCase(CGI.SERVER_NAME, Request.qryStruct.referer) gt 0) ) {
				if ( (IsDefined("Request.qryStruct.sessid")) AND (IsValid('UUID', Request.qryStruct.sessid)) ) {
					Request.commonCode.userDefinedAJAXFunctions(Request.qryStruct);
				} else {
					qObj = QueryNew('id, errorMsg, moreErrorMsg, explainError, isPKviolation, isHTML');
					QueryAddRow(qObj, 1);
					QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount);
					QuerySetCell(qObj, 'errorMsg', '<br><br><br><h5 style="color: red">201. Use of this ezAJAX(tm) Server is strictly limited to those who have valid User Accounts for this site.</h5>', qObj.recordCount);
					QuerySetCell(qObj, 'moreErrorMsg', '', qObj.recordCount);
					QuerySetCell(qObj, 'explainError', '', qObj.recordCount);
					QuerySetCell(qObj, 'isPKviolation', '', qObj.recordCount);
					QuerySetCell(qObj, 'isHTML', 1, qObj.recordCount);
					Request.commonCode.registerQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... he CF Var named Request.qryData is used to hold an array of Query Objects...
				}
			} else {
				qObj = QueryNew('id, errorMsg, moreErrorMsg, explainError, isPKviolation, isHTML');
				QueryAddRow(qObj, 1);
				QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount);
				errorReason = '';
				if (NOT IsDefined("Request.qryStruct.referer")) {
					errorReason = 'Missing the referer from the ezAJAX(tm) parameters.';
				} else if (FindNoCase(CGI.SERVER_NAME, Request.qryStruct.referer) gt 0) {
					errorReason = 'Use of this ezAJAX(tm) Server is limited to the #CGI.SERVER_NAME# domain.';
				}
				QuerySetCell(qObj, 'errorMsg', '<br><br><br><h5 style="color: red">' & errorReason & '</h5>', qObj.recordCount);
				QuerySetCell(qObj, 'moreErrorMsg', '', qObj.recordCount);
				QuerySetCell(qObj, 'explainError', '', qObj.recordCount);
				QuerySetCell(qObj, 'isPKviolation', '', qObj.recordCount);
				QuerySetCell(qObj, 'isHTML', 1, qObj.recordCount);
				Request.commonCode.registerQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... he CF Var named Request.qryData is used to hold an array of Query Objects...
			}
		} else {
			qObj = QueryNew('id, errorMsg, moreErrorMsg, explainError, isPKviolation, isHTML');
			QueryAddRow(qObj, 1);
			QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount);
			QuerySetCell(qObj, 'errorMsg', RuntimeLicenseStatus, qObj.recordCount);
			QuerySetCell(qObj, 'moreErrorMsg', '', qObj.recordCount);
			QuerySetCell(qObj, 'explainError', '', qObj.recordCount);
			QuerySetCell(qObj, 'isPKviolation', '', qObj.recordCount);
			QuerySetCell(qObj, 'isHTML', 1, qObj.recordCount);
			Request.commonCode.registerQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... he CF Var named Request.qryData is used to hold an array of Query Objects...
		}
	</cfscript>
<cfelse>
	<cfoutput>
		bool_canDebugHappen = [#bool_canDebugHappen#]<br>
		<cfdump var="#URL#" label="URL Scope" expand="No">
		<cfdump var="#FORM#" label="FORM Scope" expand="No">
		<cfdump var="#CGI#" label="CGI Scope" expand="No">
	</cfoutput>
</cfif>
<!--- the name of the cfm page is stored in the following variable: Request.qryObj.NAME["cfm"] --->

<!--- BEGIN: This block of code passes the Request.qryObj which is a ColdFusion Query Object back to the ezAJAX(tm) caller via a JavaScript object called qObj --->
<cfinclude template="cfinclude_AJAX_End.cfm">
<!--- END! This block of code passes the Request.qryObj which is a ColdFusion Query Object back to the ezAJAX(tm) caller via a JavaScript object called qObj --->
