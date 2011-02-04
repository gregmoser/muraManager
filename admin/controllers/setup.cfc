component extends="controller" {
			
	property name="instanceService";
	
	public void function addinstance(required struct rc) {
		var instance = new muraMonitor.com.entity.Instance();
		getFW().populate(cfc=insctance);
		getInstanceService().save(instance);
		getFW().redirect(action="admin:main.default");
	}
} 