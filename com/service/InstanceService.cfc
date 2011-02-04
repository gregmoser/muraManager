component extends="Service" accessors="true" {
			
	property name="dao";
			
	public any function init(required any DAO) {
		setDAO(arguments.DAO);
		return this;
	}
	
	public any function save(required any instance) {
		getDAO().save(arguments.instance);
	}
}