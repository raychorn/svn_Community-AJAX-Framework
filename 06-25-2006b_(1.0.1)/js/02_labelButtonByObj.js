function labelButtonByObj(bObj, sLabel) {
	if (!!bObj) {
		browser_is_ie = ((browser_is_ie == null) ? false : browser_is_ie);
		browser_is_ff = ((browser_is_ff == null) ? false : browser_is_ff);
		if (typeof sLabel == const_function_symbol) {
			if (browser_is_ie) {
				sLabel = sLabel(bObj.value);
			} else if (browser_is_ff) {
				sLabel = sLabel(bObj.textContent);
			}
		} else {
			sLabel = ((sLabel == null) ? '' : sLabel);
		}
		if (browser_is_ie) {
			bObj.value = sLabel; 
		} else if (browser_is_ff) {
			bObj.textContent = sLabel; 
		}
	}
}
