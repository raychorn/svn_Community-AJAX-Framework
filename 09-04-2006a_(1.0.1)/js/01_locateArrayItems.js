function locateArrayItems(a, what, start) {
	var f = 0;
	if (start) {
		startWhere = start 
	}
	else {
		startWhere = 0;
	}
	what = ((what != null) ? what.toString() : '');
	var nWhat = what.length;
	for(f=startWhere; f < a.length; f++) {
		if (a[f].toString().substr(0,nWhat) == what) {
			return f;
		}
	}
	return -1;
}

