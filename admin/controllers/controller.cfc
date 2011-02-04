component extends="mura.cfobject" accessors="true" {
	
	property name="fw";
	
	public any function init(required any fw) {
		setFW(arguemtns.fw);
	}
}