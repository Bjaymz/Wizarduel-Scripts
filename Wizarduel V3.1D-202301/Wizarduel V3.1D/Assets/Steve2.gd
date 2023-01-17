extends KinematicBody

const FIREBALLSCENE = preload("res://Assets/Fireball.tscn")
const ICEORBSCENE = preload("res://Assets/IceOrb.tscn")
var PNAME = "Player 2"
var COLOUR = "RED"
var velocity = Vector3(0,0,0)
var facing = Vector3(-1,0,0)
var SPEED = 5
var JUMPNESS = 14
var gravity = 0.6
var HP = 100
var ID = 1178
var ro = get_rotation()
var position = get_global_transform().origin

#Status Effects
var Frost = 0

slave func setPosition(pos):
  set_translation(pos)

func _ready():
	pass

func _physics_process(delta):
	if velocity.y < -JUMPNESS:
		if Input.is_action_pressed("ui_jump2"):
			velocity.y = JUMPNESS
	else:
		velocity.y = velocity.y - gravity

	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_right"):
		velocity.z = -1
	elif Input.is_action_pressed("ui_left"):
		velocity.z = 1
	else:
		velocity.z = 0

	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 1
	else:
		velocity.x = 0

	if Input.is_action_pressed("2tLeft"):
		ro += Vector3(0,sin(PI/80),0)
		set_rotation(ro)
	elif Input.is_action_pressed("2tRight"):
		ro -= Vector3(0,sin(PI/80),0)
		set_rotation(ro)

	if Input.is_action_just_pressed("ui_spell21"):
		var fireball = FIREBALLSCENE.instance()
		get_parent().add_child(fireball)
		fireball.set_translation(get_node("Castpoint2").get_global_transform().origin)
		fireball.velocity = facing
		fireball.Owner = PNAME

	if Input.is_action_just_pressed("spell22"):
		var iceorb = ICEORBSCENE.instance()
		get_parent().add_child(iceorb)
		iceorb.set_translation(get_node("Castpoint2").get_global_transform().origin)
		iceorb.velocity = facing
		iceorb.Owner = PNAME

	var angle = ro.y-PI/2
	facing = Vector3(sin(angle),0,cos(angle))

	var MOVE = Vector3((velocity.z*sin(ro.y)+velocity.x*cos(ro.y))*SPEED,velocity.y,(velocity.z*cos(ro.y)-velocity.x*sin(ro.y))*SPEED)
	#SLOWING MOVEMENT
	if Frost > 0:
		MOVE = MOVE*Vector3(.4,.4,.4)
		Frost -= 1
	move_and_slide(MOVE)
	#Sync
	if globals.Testing == false:
		position = get_global_transform().origin
		rpc_unreliable("setPosition",position)

func takedmg(amount):
	HP -= amount

func takecc(id):
	if id == "frost":
		Frost = 2*60