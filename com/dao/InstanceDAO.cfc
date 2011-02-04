component extends="DAO" {
	
	public query function getAllInstances() {
		var instanceQuery = new Query();
		instanceQuery.setSQL("
			SELECT
				instanceID,
				instanceKey,
				instanceName,
				instanceHostname,
				Passkey
			FROM
				MuraMonitorInstance
		");
		instanceQuery.execute();
		return instanceQuery.result();
	}
	
	public query function getInstanceByID(required int id) {
		var instanceQuery = new Query();
		instanceQuery.setSQL("
			SELECT
				instanceID,
				instanceKey,
				instanceName,
				instanceHostname,
				Passkey
			FROM
				MuraMonitorInstance
			WHERE
				instanceID = :id
		");
		instanceQuery.addParam(name="id", value=arguments.id, cfsqltype="cf_sql_int");
		instanceQuery.execute();
		return instanceQuery.result();
	}
} 