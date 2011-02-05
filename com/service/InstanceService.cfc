component extends="Service" accessors="true" {
			
	property name="dao";
			
	public any function init(required any DAO) {
		setDAO(arguments.DAO);
		return this;
	}
	
	public any function save(required any instance) {
		return getDAO().save(arguments.instance);
	}
	
	public any function read(required numeric instanceID) {
		return queryToEntity(getDAO().getInstanceByID(arguments.instanceID), true);
	}
	
	public any function delete(required any instance) {
		return getDAO().delete(arguments.instance);
	}
	
	public array function getAllInstances() {
		return queryToEntity(getDAO().getAllInstances());
	}
	
	public any function getNewEntity() {
		return new com.entity.Instance(); 
	}
}