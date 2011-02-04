component extends="Service" accessors="true" {
			
	property name="dao";
			
	public void function init(required any DAO) {
		setDAO(arguments.DAO);
		return this;
	}	
}