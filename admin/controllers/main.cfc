component extends="controller" accessors="true" {
	
	property name="instanceService";
	
	public void function before(required struct rc) {
		param name="rc.instanceID" default=0;
		rc.instance = getInstanceService().read(rc.instanceID);
	}
	
	public any function default(required struct rc) {
		rc.AllInstances = getInstanceService().getAllInstances();
	}
	
	public void function saveinstance(required struct rc) {
		getFW().populate(cfc=rc.instance, keys="instanceID,instanceName,instanceKey,instanceHostname,instancePasskey");
		getInstanceService().save(rc.instance);
		getFW().redirect(action="admin:main.default");
	}
	
	public void function deleteinstance(required struct rc) {
		getInstanceService().delete(rc.instance);
		getFW().redirect(action="admin:main.default");
	}
	
} 