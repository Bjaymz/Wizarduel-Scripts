extends MeshInstance

func _ready():
	pass
	

func _physics_process(delta):
	var health = get_parent().get_parent().HP
	var hscale = float(health)/100
	set_scale(Vector3(1.1,1.05,hscale))
	set_translation(Vector3(0,0,hscale-1))


