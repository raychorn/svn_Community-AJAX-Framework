_stack_AJAX_functions = [];

function initAJAXEngine() {
	// define the function to run when a packet has been sent to the server
	oAJAXEngine.onSend = function (){
		if (global_allow_loading_data_message == true) {
			showAJAXBegins();
		}
		window.status = '';
	};

	// define the function to run when a packet has been received from the server
	oAJAXEngine.onReceive = function (){
		var _db = '';

		showAJAXEnds();

		var byteCount = 0;
		// BEGIN: This block of code always returns the JavaScript Query Object known as oAJAXEngine.js_global_varName regardless of the technique that was used to perform the ezAJAX(tm) function...
		try {
			if (this.isReceivedFromCFAjax()) {
				byteCount += this.received.length;
				eval(this.received);
			} else {
				try {
					for( var i = 0; i < this.received.length; i++) {
						byteCount += this.received[i].length;
						eval(this.received[i]);
					}
				} catch(ee) {
					_alertError(jsErrorExplainer(ee, '1.0' + ', this.received[' + i + '] = [' + this.received[i] + ']'));
				} finally {
				}
			}
		} catch(e) {
			_alertError(jsErrorExplainer(ee, '1.1'));
		} finally {
		}
		window.status = byteCount + ' bytes rcvd from ezAJAX(tm)' + ', mode is ' + oAJAXEngine.mode + ', method is ' + oAJAXEngine.method + ', isXmlHttpPreferred is ' + oAJAXEngine.isXmlHttpPreferred;
		if (this.isDebugMode()) _alert('oAJAXEngine = [' + oAJAXEngine + ']' + '\n' + this.received);
		// END! This block of code always returns the JavaScript Query Object known as oAJAXEngine.js_global_varName regardless of the technique that was used to perform the AJAX function...

		handle_next_AJAX_function(); // get the next item from the stack...
	};

	oAJAXEngine.onTimeout = function (){
		this.throwError("The current request has timed out.\nPlease try your request again.");
		showAJAXEnds();
		handle_next_AJAX_function(); // get the next item from the stack...
	};
}
	
