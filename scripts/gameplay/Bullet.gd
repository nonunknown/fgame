extends Node2D

var direction

func _ready():
	set_process(false)
	yield(get_tree().create_timer(.3,false),"timeout")
	queue_free()

func dispare():
	direction = global_position.direction_to(get_global_mouse_position())
	rotation = direction.angle()
	set_process(true)
	pass

func _process(delta):
	position += direction * 100
