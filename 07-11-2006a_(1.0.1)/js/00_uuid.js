function uuid() {
	var uuid = (new Date().getTime() + "" + Math.floor(1000 * Math.random()));
	return uuid;
}
