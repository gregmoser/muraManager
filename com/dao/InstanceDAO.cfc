component extends="DAO" {
	
	public query function getAllInstances() {
		var instanceQuery = new Query();
		instanceQuery.setSQL("
			SELECT
				instanceID,
				instanceKey,
				instanceName,
				instanceHostname,
				instancePasskey
			FROM
				MuraManagerInstance
		");
		
		return instanceQuery.execute().getResult();
	}
	
	public query function getInstanceByID(required numeric id) {
		var instanceQuery = new Query();
		instanceQuery.setSQL("
			SELECT
				instanceID,
				instanceKey,
				instanceName,
				instanceHostname,
				instancePasskey
			FROM
				MuraManagerInstance
			WHERE
				instanceID = :id
		");
		instanceQuery.addParam(name="id", value=arguments.id, cfsqltype="cf_sql_int");
		
		return instanceQuery.execute().getResult();
	}
	
	public any function save(required any instance) {
		var instanceQuery = new Query();
		if(arguments.instance.getInstanceID() == 0) {
			instanceQuery.setSQL("
				INSERT INTO MuraManagerInstance (
					instanceKey,
					instanceName,
					instanceHostname,
					instancePasskey
				) VALUES (
					:instanceKey,
					:instanceName,
					:instanceHostname,
					:instancePasskey
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
					instancePasskey = :instancePasskey  
				WHERE
					instanceID = :instanceID
			");
			instanceQuery.addParam(name="instanceID", value=arguments.instance.getInstanceID(), cfsqltype="cf_sql_int");
		}
		instanceQuery.addParam(name="instanceKey", value=arguments.instance.getInstanceKey(), cfsqltype="cf_sql_varchar");
		instanceQuery.addParam(name="instanceName", value=arguments.instance.getInstanceName(), cfsqltype="cf_sql_varchar");
		instanceQuery.addParam(name="instanceHostname", value=arguments.instance.getInstanceHostname(), cfsqltype="cf_sql_varchar");
		instanceQuery.addParam(name="instancePasskey", value=arguments.instance.getInstancePasskey(), cfsqltype="cf_sql_varchar");
		
		return instanceQuery.execute().getResult();
	}
	
	public any function delete(required any instance) {
		var instanceQuery = new Query();
		instanceQuery.setSQL("
			DELETE FROM MuraManagerInstance	WHERE instanceID = :instanceID
		");
		instanceQuery.addParam(name="instanceID", value=arguments.instance.getInstanceID(), cfsqltype="cf_sql_varchar");
		instanceQuery.execute();
		return true;
	}
} 