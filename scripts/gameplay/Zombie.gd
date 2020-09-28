extends KinematicBody2D
class_name Zombie

export var speed:float = 300
var path:Array = []
var follow:bool = false
var navigation:Navigation2D
var target:Node2D
var health:float = 100

func _ready():
	navigation = get_tree().get_nodes_in_group("NAV")[0]
	target = get_tree().get_nodes_in_group("player")[0]

func _process(delta):
	if Input.is_action_just_pressed("cmd_accept"):
		follow = true
		path = navigation.get_simple_path(global_position,target.global_position,false)
		print(path)
	if follow == false: return
	
	
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
	if path.size() <= 0: follow = false

func on_shooted(damage:float=10):
	decrease_health(damage)
	for blood in get_node("Bloods").get_children():
		if blood.playing:
			continue
		else:
			blood.show()
			break

func decrease_health(damage:float):
	health -= damage
	if health <= 0:
		queue_free()
