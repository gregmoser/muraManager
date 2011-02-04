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
	
	public any function save(required any instance) {
		var instanceQuery = new Query();
		if(arguments.instance.getInstanceID() == 0) {
			instanceQuery.setSQL("
				INSET INTO MuraManagerInstance (
					instanceKey,
					instanceName,
					instanceHostname,
					passkey
				) VALUES (
					:instanceKey,
					:instanceName,
					:instanceHostname,
					:passkey
				)
			");
		} else {
			instanceQuery.setSQL("
				UPDATE
					MuraManagerInstance
				SET
					instanceKey = :instanceKey,
					instanceName = :instanceName,
					instanceHostname = :instanceHostname,
					passkey = :passkey
				WHERE
					instanceID = :instanceID
			");
			instanceQuery.addParam(name="instanceID", value=arguments.instance.getInstanceID(), cfsqltype="cf_sql_varchar");
		}
		instanceQuery.addParam(name="instanceKey", value=arguments.instance.getInstanceKey(), cfsqltype="cf_sql_varchar");
		instanceQuery.addParam(name="instanceName", value=arguments.instance.getInstanceName(), cfsqltype="cf_sql_varchar");
		instanceQuery.addParam(name="instanceHostname", value=arguments.instance.getInstanceHostname(), cfsqltype="cf_sql_varchar");
		instanceQuery.addParam(name="passkey", value=arguments.instance.getPasskey(), cfsqltype="cf_sql_varchar");
		instanceQuery.execute();
		
		return instanceQuery.result();
	}
} 