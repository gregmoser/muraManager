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
	
	public any function getSiteStatus(required string siteID) {
		var status = getStatus();
		var site = structNew();
		for(var i = 1; i <= arrayLen(status.sites); i++) {
			if(status.sites[i].siteid == arguments.siteid) {
				site = status.sites[i];
			}
		}
		return site;
	}
	
	public any function getStatus() {
		if(!isDefined("variables.status")) {
			try {
				var StatusService = createObject("webservice", "http://#getInstanceHostname()#/plugins/muraManagerRemote/remote.cfc?wsdl");
				variables.Status = StatusService.getStatus(transactionKey = getTransactionKey());	
			} 
			catch(any e) {
				var tempStatus = structNew();
				tempStatus.error = "Could Not Access Web Service";
				variables.Status = serializeJSON(tempStatus);
			}
		}
		return  deserializeJSON(variables.Status);
	}
}