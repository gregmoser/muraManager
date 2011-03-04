component extends="mura.cfobject" accessors="true" {
	
	property name="fw";
	
	public any function init(required any fw) {
		setFW(arguments.fw);
	}
	
	public any function subSystemBefore(required any rc) {
		rc.sectionTitle = "";
		rc.itemTitle = "";
	}
}