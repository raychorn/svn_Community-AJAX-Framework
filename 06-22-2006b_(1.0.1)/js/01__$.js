function $$(id, fromObj) {
	var obj = null;
	
	function usingGetElementById(id, fromObj) {
		return ((typeof fromObj.getElementById == const_function_symbol) ? fromObj.getElementById(id) : null);
	};
	
	function usingAll(id, fromObj) {
		return ((fromObj.all) ? fromObj.all[id] : null);
	};
	
	function usingLayers(id, fromObj) {
		return ((fromObj.layers) ? fromObj.layers[id] : null);
	};
	
	var _db = '';
	if (typeof id == const_string_symbol) {
		try { obj = usingGetElementById(id, fromObj); _db += 'A. obj = [' + obj + ']'; } catch(e) { obj = null; _db += 'A.1 obj = [' + obj + ']'; };
		if (obj == null) {
			try { obj = usingAll(id, fromObj); _db += 'B. obj = [' + obj + ']'; } catch(e) { obj = null; _db += 'B.1 obj = [' + obj + ']'; };
			if (obj == null) {
				try { obj = usingLayers(id, fromObj); _db += 'C. obj = [' + obj + ']'; } catch(e) { obj = null; _db += 'C.1 obj = [' + obj + ']'; };
			}
		}
	}
//	alert('$$ :: ' + 'id = [' + id + ']' + ', obj = [' + obj + ']' + ', fromObj.getElementById = [' + fromObj.getElementById + ']' + ', fromObj.all = [' + fromObj.all + ']' + ', fromObj.layers = [' + fromObj.layers + ']' + '\n' + _db);
	return obj;
}

function _$(id, _frame) {
	try {
		return ((_frame != null) ? $$(id, _frame.document) : $$(id, document));
	} catch(e) {
		return null;
	} finally {
	}
//	return ((!!_frame) ? ((_frame.document.getElementById) ? _frame.document.getElementById(id) : null) : ((document.getElementById) ? document.getElementById(id) : null));
}
