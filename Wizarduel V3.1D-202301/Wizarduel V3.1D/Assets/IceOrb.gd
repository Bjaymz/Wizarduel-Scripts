extends KinematicBody

func _ready():
	set_process(true)

var Damage = 3
var Lifetime = 0
var PNAME = "ICEORB"
export(float) var MOVESPEED = 16
export(Vector3) var velocity = Vector3(0,0,0)
export(int) var Owner = 0
func _physics_process(delta):
	var collision = move_and_collide(velocity*MOVESPEED*delta)
	Lifetime += 1
	if Lifetime > 300:
		free()
	elif collision:
		if collision.collider.PNAME != Owner:
			if collision.collider.has_method("takedmg"):
				collision.collider.takedmg(Damage)
			if collision.collider.has_method("takecc"):
				collision.collider.takecc("frost")
				print (str(collision.collider.PNAME)+"has"+ str(collision.collider.HP))
			print("BAM")
			free()