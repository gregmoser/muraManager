component extends="controller" accessors="true" {
	
	public void function before(required struct rc) {
		request.layout = false;
	}
} 