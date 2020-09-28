extends Node2D

enum weapons {Punch,Knife,Glock,SMG,ak47,Molotov}
var ps_bullet = preload("res://resources/gameplay/obj_bullet.tscn")
var resources_path = "res://resources/weapons/RWeapon_%s.tres"
var inventory = [weapons.Glock]
var current_weapon:RWeapon
var current_rate:float = 0.0
var bullets:int
var clip:int
var reloading:bool = false

var indexes = [weapons.Glock,weapons.SMG,weapons.ak47]
var selected:int = 0
func _ready():
	change_weapon(indexes[0])

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_WHEEL_UP:
			if selected + 1 >= indexes.size(): selected = 0
			else: selected += 1
			change_weapon(indexes[selected])

func change_weapon(index:int):
	current_weapon = load(resources_path % weapons.keys()[index]) as RWeapon
	current_weapon.rate = current_weapon.rate
	bullets = current_weapon.capacity
	clip = current_weapon.clip_size
	$sfx_shoot.stream = current_weapon.stream_shoot
	$sfx_reload.stream = current_weapon.stream_reload

func _on_shoot():
	if current_rate > 0 or reloading: return
	if clip <= 0 and bullets <=0: 
		print("FINISHED")
		return
	current_rate = current_weapon.rate
	bullets -= 1
	var bullet = ps_bullet.instance()
	get_tree().root.add_child(bullet)
	bullet.position = global_position
	bullet.dispare()
	$sfx_shoot.play()
	if bullets > 0 and $RayCast2D.is_colliding():
		check_shoot($RayCast2D.get_collider())
	
	if bullets <= 0 and clip > 0:
		reload()

func _process(delta):
	ScreenDebugger.dict["rate"] = current_rate
	ScreenDebugger.dict["bulets"] = bullets
	ScreenDebugger.dict["clip"] = clip
	if current_rate > 0: 
		current_rate -= delta

func reload():
	reloading = true
	
	$sfx_reload.play()
	yield(get_tree().create_timer(current_weapon.stream_reload.get_length(),false),"timeout")
	if clip - current_weapon.capacity <= 0:
		bullets = clip
		clip = 0
	else:
		clip -= current_weapon.capacity
		bullets = current_weapon.capacity
	reloading = false

func check_shoot(collider):
	if collider.is_in_group("ENEMY"):
		collider.on_shooted(current_weapon.base_damage)
		
		return
