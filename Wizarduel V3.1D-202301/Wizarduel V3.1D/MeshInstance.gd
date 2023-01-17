extends MeshInstance

func _ready():
	pass

var BASECOLOUR = get_surface_material(0).albedo_color
func _process(delta):
	if get_parent().Frost > 0:
		get_surface_material(0).albedo_color = Color(109,239,233,255)/255
	else:
		get_surface_material(0).albedo_color = BASECOLOUR

		