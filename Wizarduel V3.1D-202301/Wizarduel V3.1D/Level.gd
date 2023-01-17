extends Spatial

func _ready():
	if globals.cameraAngle == 2:
		var Cam2 = get_node("InterpolatedCamera2")
		Cam2.make_current()
	  #First create ourself
#	if globals.cameraAngle != 2:
#		get_node("Steve").set_name(str(get_tree().get_network_unique_id()))
#		set_network_master(get_tree().get_network_unique_id())
#		print(get_node("Steve").get_name())
#		get_node("Steve2").set_name(str(globals.otherPlayerId))
#		get_node("Steve2").set_network_master(globals.otherPlayerId)
#	else:
#		get_node("Steve2").set_name(str(get_tree().get_network_unique_id()))
#		set_network_master(get_tree().get_network_unique_id())
#		print(get_node("Steve2").get_name())
#		get_node("Steve").set_name(str(globals.otherPlayerId))
#		get_node("Steve").set_network_master(globals.otherPlayerId)

		
		
#  var thisPlayer = preload("res://Assets/Steve.tscn").instance()
#  thisPlayer.set_name(str(get_tree().get_network_unique_id()))
#  thisPlayer.set_network_master(get_tree().get_network_unique_id())
#  add_child(thisPlayer)
#
  #Now create the other player
#  var otherPlayer = preload("res://Assets/Steve.tscn").instance()
#  otherPlayer.set_name(str(globals.otherPlayerId))
#  otherPlayer.set_network_master(globals.otherPlayerId)
#  add_child(otherPlayer)
#	pass
	