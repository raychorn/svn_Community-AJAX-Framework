function getButtonLabelByObj(btnObj) {
	browser_is_ff = ((browser_is_ff == null) ? false : browser_is_ff);
	if (!!btnObj) {
		return ((browser_is_ff) ? btnObj.textContent : btnObj.value);
	} else {
		alert('ERROR: Programming Error - getButtonLabelByObj() function requires a valid object pointer for a button however this was not supplied.');
	}
}
