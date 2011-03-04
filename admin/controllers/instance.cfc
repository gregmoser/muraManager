component extends="controller" accessors="true" {
	
	property name="instanceService";
	
	public void function detail(required struct rc) {
		param name="rc.instanceID" default=0;
		rc.instance = getInstanceService().read(rc.instanceID);
	}
	
	public void function edit(required struct rc) {
		detail(rc);
		getFW().setView("admin:instance.detail");
		rc.edit = 1;
	}
	
	public void function create(required struct rc) {
		detail(rc);
		getFW().setView("admin:instance.detail");
		rc.edit = 1;
	}
	
	public void function save(required struct rc) {
		param name="rc.instanceID" default=0;
		rc.instance = getInstanceService().read(rc.instanceID);
		getFW().populate(cfc=rc.instance, keys="instanceID,instanceName,instanceKey,instanceHostname,instancePasskey");
		getInstanceService().save(rc.instance);
		getFW().redirect(action="admin:main.default");
	}
	
	public void function delete(required struct rc) {
		param name="rc.instanceID" default=0;
		rc.instance = getInstanceService().read(rc.instanceID);
		getInstanceService().delete(rc.instance);
		getFW().redirect(action="admin:main.default");
	}
	
} 