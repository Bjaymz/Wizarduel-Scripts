extends KinematicBody

const FIREBALLSCENE = preload("res://Assets/Fireball.tscn")
const ICEORBSCENE = preload("res://Assets/IceOrb.tscn")
const TREEOFLIFESCENE = preload("res://Assets/TreeOfLife.tscn")
var PNAME = "Player 1"
var COLOUR = "WHITE"
var velocity = Vector3(0,0,0)
var facing = Vector3(1,0,0)
var SPEED = 5
var JUMPNESS = 14
var gravity = 0.6
var HP = 100
var MANA = 100
var tick = 0
var manaregen = 10
var ID = 1171
var ro = get_rotation()
var position = get_global_transform().origin

#Status Effects
var Frost = 0

#mana
func Mana(amount):
	if -amount < MANA:
		MANA += amount
		return true
	else:
		return false


slave func setPosition(pos):
  set_translation(pos)

func _ready():
	pass

func _physics_process(delta):
	#Mana shenanigans
	
	tick += 1
	if tick == 60:
		Mana(manaregen)
		tick = 0
	if MANA > 100:
		MANA = 100
	
	#Movement Shenanigans
	if velocity.y < -JUMPNESS:
		if Input.is_action_pressed("ui_accept"):
			velocity.y = JUMPNESS
	else:
		velocity.y = velocity.y - gravity

	if Input.is_action_pressed("ui_left2") and Input.is_action_pressed("ui_right2"):
		velocity.z = 0
	elif Input.is_action_pressed("ui_right2"):
		velocity.z = 1
	elif Input.is_action_pressed("ui_left2"):
		velocity.z = -1
	else:
		velocity.z = 0

	if Input.is_action_pressed("ui_up2") and Input.is_action_pressed("ui_down2"):
		velocity.x = 0
	elif Input.is_action_pressed("ui_up2"):
		velocity.x = 1
	elif Input.is_action_pressed("ui_down2"):
		velocity.x = -1
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("1tLeft"):
		ro += Vector3(0,sin(PI/80),0)
		set_rotation(ro)
	elif Input.is_action_pressed("1tRight"):
		ro -= Vector3(0,sin(PI/80),0)
		set_rotation(ro)
	
#ROTATION DOES NOT = FACING
	if Input.is_action_just_pressed("ui_spell11"):
		if Mana(-globals.fireballcost):
			var fireball = FIREBALLSCENE.instance()
			get_parent().add_child(fireball)
			fireball.set_translation(get_node("Castpoint2").get_global_transform().origin)
			fireball.velocity = facing
			fireball.Owner = PNAME
		
	if Input.is_action_just_pressed("spell12"):
		if Mana(-globals.iceorbcost):
			var iceorb = ICEORBSCENE.instance()
			get_parent().add_child(iceorb)
			iceorb.set_translation(get_node("Castpoint2").get_global_transform().origin)
			iceorb.velocity = facing
			iceorb.Owner = PNAME
	
	if Input.is_action_just_pressed("spell13"):
		if Mana(-globals.treeOfLifecost):
			var lifetree = TREEOFLIFESCENE.instance()
			get_parent().add_child(lifetree)
			lifetree.set_translation(get_node("Castpoint2").get_global_transform().origin+Vector3(0,-1,0))
			lifetree.Owner = PNAME
			print(lifetree.Owner)
	
	var angle = ro.y+PI/2
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
		    # ^Tell the other computer about our new position so it can update       

func takedmg(amount):
	HP -= amount
	if HP < 0:
		HP = 0
	elif HP > 100:
		HP = 100



func takecc(id):
	if id == "frost":
		Frost = 2*60


##FOR POTENTIAL DOUBLE QUIT BUTTON
#master func shutItDown():
#  #Send a shutdown command to all connected clients, including this one
#  rpc("shutDown")
#
#sync func shutDown():
#  get_tree().quit()
 


