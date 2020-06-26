extends Control

signal exit_to_menu_button


var screenSize = Vector2(0,0)



func _ready() -> void:
	setup()


func setup():
	print("GUI script setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	self.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)

	

func update_score(text):
	
	pass
	


func _on_MessageTimer_timeout() -> void:
	#$CentContMessage/Message.text = ""
	$VBoxContainer/CentContMessage/Message.hide()


func _on_ExitToMainMenu_pressed() -> void:
	emit_signal("exit_to_menu_button")
