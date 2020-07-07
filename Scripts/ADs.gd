extends Node

signal ads_done

var screenSize = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()
	#self.visible = false
	#$ADsTimer.start()
	pass # Replace with function body.



func setup():
	print("ADs setup()")
	screenSize = get_viewport().get_visible_rect().size
	$CenterContainer/CanvasLayer/ADImage.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CenterContainer/Label.text = str($ADsTimer.time_left)


func _on_ADsTimer_timeout() -> void:
	Main.show_ads_scene(false)
	Main.show_gui_scene(true)
	


func _on_Button_pressed() -> void:
	emit_signal("ads_done")
