extends Camera2D


onready var player:Node2D = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	global_position = lerp(global_position,player.global_position,.7)
