component extends="Entity" accessors="true" {
	
	property name="instanceKey";
	property name="instanceID";
	property name="instanceName";
	property name="instanceHostname";
	property name="passkey";
	
	public string function getTransactionKey() {
		var date = #DateFormat(now(), "MM-DD-YYYY")#;
		var passdate = lcase(hash(lcase("#getPasskey()##date#")));
		return lcase(hash(lcase("#passdate##getInstanceKey()#")));
	}
}