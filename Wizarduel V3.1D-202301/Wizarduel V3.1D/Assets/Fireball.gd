extends KinematicBody

func _ready():
	set_process(true)

var Damage = 40
var Lifetime = 0
var position = get_global_transform().origin
var PNAME = "FIREBALL"
export(float) var MOVESPEED = 20
export(Vector3) var velocity = Vector3(0,0,0)
export var Owner = ""
func _physics_process(delta):
	var collision = move_and_collide(velocity*MOVESPEED*delta)
	Lifetime += 1
	if Lifetime > 300:
		free()
	elif collision:
		if collision.collider.PNAME != Owner:
			if collision.collider.has_method("takedmg"):
				collision.collider.takedmg(Damage)
				print (str(collision.collider.PNAME)+"has"+ str(collision.collider.HP))
				free()
			elif collision.collider.PNAME != "TREE":
				free()

				