component extends="Service" accessors="true" {
			
	property name="dao";
			
	public any function init(required any DAO) {
		setDAO(arguments.DAO);
		return this;
	}	
}