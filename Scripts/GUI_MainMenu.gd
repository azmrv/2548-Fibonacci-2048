extends Control

signal start_new_game
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var screenSize = Vector2(0,0)



func _ready() -> void:
	setup()


func setup():
	print("GUI_InGamePlay script setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	self.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)



func _on_StartGame_pressed() -> void:	
	# $CentContButtons/VBoxButtons/Credits.hide()
	# $CentContButtons/VBoxButtons/ExitGame.hide()
	# $CentContButtons/VBoxButtons/Options.hide()
	# $CentContButtons/VBoxButtons/StartGame.hide()
	# $CentContLabel/BestScore.hide()
	# $CentContLabel2/GameName.hide()
	emit_signal("start_new_game")
	


func _on_ExitGame_pressed() -> void:
	get_tree().quit()


func _on_Options_pressed() -> void:
	pass # Replace with function body.


