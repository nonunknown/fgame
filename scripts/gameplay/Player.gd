extends KinematicBody2D

export var max_speed:float = 300
var direction:Vector2
func _process(delta):
	direction.x = int(Input.is_action_pressed("ui_right")) - int( Input.is_action_pressed("ui_left") )
	direction.y = -int(Input.is_action_pressed("ui_up")) + int( Input.is_action_pressed("ui_down") )
	look_at(get_global_mouse_position())
	move_and_slide(direction * max_speed)
	
	if !(Input.is_action_pressed("cmd_shoot")): return
	$Weapon._on_shoot()
