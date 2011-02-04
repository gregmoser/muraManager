component extends="Entity" accessors="true" {
	
	property name="instanceID";
	property name="instanceKey";
	property name="instanceName";
	property name="instanceHostname";
	property name="passkey";
	
	public string function getTransactionKey() {
		var date = #DateFormat(now(), "MM-DD-YYYY")#;
		var passdate = lcase(hash(lcase("#getPasskey()##date#")));
		return lcase(hash(lcase("#passdate##getInstanceKey()#")));
	}
	
	public numeric function getInstanceID() {
		if(!isDefined("variables.instanceID")) {
			variables.instanceID = 0;
		}
		return variables.instanceID;
	}
}