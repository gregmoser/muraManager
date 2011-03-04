component extends="controller" accessors="true" {
	
	property name="instanceService";
	
	public void function before(required struct rc) {
		rc.sectionTitle = "Dashboard";
	}
	
	public any function default(required struct rc) {
		rc.AllInstances = getInstanceService().getAllInstances();
	}
	
} 