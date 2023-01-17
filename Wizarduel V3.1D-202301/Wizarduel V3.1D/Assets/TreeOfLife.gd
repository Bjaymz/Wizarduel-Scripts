extends KinematicBody

func _ready():
	var Lifetime = 0
	pass

var Lifetime = 0
var healstrength = 1
var velocity = Vector3(0,-1,0)
var heal = false
var wavelength = 1
var totalhealing = 0
var PNAME = "TREE"
export var Owner = ""

func _physics_process(delta):
	Lifetime += 1
	var collision = move_and_collide(velocity*delta)
	if fmod(Lifetime,wavelength) == 0:
		heal = true
		print(str(Lifetime)+" "+str(wavelength))
	else:
		heal = false
	if Lifetime > 300:
		Lifetime = 0
		free()
		
	if collision:
		if collision.collider.PNAME == "FLOOR":
			velocity.y = 0
		elif collision.collider.PNAME == "FIREBALL":
			Lifetime = 0
			free()
	
	#needs fixing.
		elif collision.collider.PNAME == Owner:
			if heal:
				collision.collider.takedmg(-healstrength)
				totalhealing += healstrength
				print(totalhealing)

	