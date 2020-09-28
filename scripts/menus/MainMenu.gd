extends Control


var menu_data = ["new","opt","exit"]
onready var options = $VBoxContainer.get_children()
var menu:MenuManager = MenuManager.new(self,true)
var string = ["%s","[color=yellow][center][shake rate=20 level=20]%s[/shake][/center][/color]"]
func _ready():
	_on_cursor_moved(0)
	pass

func _process(delta):
	menu.update()

func _on_cursor_moved(index):
	for i in range(options.size()):
		options[i].bbcode_text = string[0] % tr(menu_data[i])
	options[index].bbcode_text = string[1] % tr(menu_data[index])
	$sfx.play()
	pass
