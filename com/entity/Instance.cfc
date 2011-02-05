component extends="Entity" accessors="true" {
	
	property name="instanceID";
	property name="instanceKey";
	property name="instanceName";
	property name="instanceHostname";
	property name="instancePasskey";
	property name="status";
	
	public string function getTransactionKey() {
		var date = #DateFormat(now(), "MM-DD-YYYY")#;
		var passdate = lcase(hash(lcase("#getInstancePasskey()##date#")));
		return lcase(hash(lcase("#passdate##getInstanceKey()#")));
	}
	
	public numeric function getInstanceID() {
		if(!isDefined("variables.instanceID")) {
			variables.instanceID = 0;
		}
		return variables.instanceID;
	}
	
	public any function getStatus() {
		if(!isDefined("variables.status")) {
			var StatusService = createObject("webservice", "http://#getInstanceHostname()#/plugins/muraManagerRemote/remote.cfc?wsdl");
			variables.Status = StatusService.getStatus(transactionKey = getTransactionKey());
		}
		return  deserializeJSON(variables.Status);
	}
}