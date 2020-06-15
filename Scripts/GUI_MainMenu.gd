extends Control

signal start_new_game
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func setup():	
#	$CentContButtons/VBoxButtons/Credits.show()
#	$CentContButtons/VBoxButtons/ExitGame.show()
#	$CentContButtons/VBoxButtons/Options.show()
#	$CentContButtons/VBoxButtons/StartGame.show()
#	$CentContLabel/BestScore.show()
#	$CentContLabel2/GameName.show()
	pass


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


func _on_Credits_pressed() -> void:
	pass # Replace with function body.


