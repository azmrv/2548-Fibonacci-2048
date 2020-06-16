extends Node2D


export (PackedScene) var Number 

var current_number = 0
var number = 0
var mas_coord = 0

var currx_row = 0
var curry_col = 0

var text_label = ""

func set_xy(x,y):
	currx_row = x
	curry_col = y
	

func set_text(text : String):
	text_label = text
	$MarginContainer/CenterContainer/ColorRect/Label.text = text
	if text == "0":
		current_number = 0
	else:
		current_number = 1

# onready var effect = get_node("move_tween")
# onready var destroy = get_node("destroy_tween")
# onready var alpha = get_node("alpha_tween")
# onready var timer = get_node("destroy_timer")

# func _ready():
# 	enter_scene()

# #func _process(delta):
# #	# Called every frame. Delta is time since last frame.
# #	# Update game logic here.
# #	pass

# func enter_scene():
# 	effect.interpolate_property(self, "scale", Vector2(.3, .3), Vector2(1, 1), .6, Tween.TRANS_CIRC, Tween.EASE_OUT)
# 	effect.start()

# func move(new_position):
# 	effect.interpolate_property(self, "position", position, new_position, .3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
# 	effect.start()

# func start_timer():
# 	destroy_piece()

# func destroy_piece():
# 	#Use a tween to make the piece larger
# 	destroy.interpolate_property(self, "scale", Vector2(1, 1), Vector2(1.4, 1.4), .6, Tween.TRANS_CUBIC, Tween.EASE_OUT)
# 	destroy.start()
# 	#Use a tween to make the piece disappear
# 	alpha.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), .6, Tween.TRANS_SINE, Tween.EASE_OUT)
# 	alpha.start()

# func _on_destroy_timer_timeout():
# 	destroy_piece()

func set_number_text(text):
	$MarginContainer/CenterContainer/ColorRect/Label.text = text
	

# func _on_alpha_tween_tween_completed(object, key):
# 	queue_free()


