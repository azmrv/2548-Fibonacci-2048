extends Node2D

signal change_number

export (PackedScene) var Number 
	
# onready var effect = get_node("move_tween")
# onready var destroy = get_node("destroy_tween")
# onready var alpha = get_node("alpha_tween")
# onready var timer = get_node("destroy_timer")
var exist_number = 0
var number = 0
var mas_coord = 0

var colors = []

var curry_row = 0
var currx_col = 0

var text_label = ""

func set_xy(rowy, colx):
	curry_row = rowy
	currx_col = colx
	

func set_number_to_label(num : int):
	text_label = num as String
	$MarginContainer/CenterContainer/ColorRect/Label.text = str(num)
	if num == 0:
		exist_number = 0
	else:
		exist_number = 1
	number = num 


func set_rect_size(color_rect_size):
	$MarginContainer/CenterContainer/ColorRect.rect_size = color_rect_size


func set_color():
	
	if number == 0:
		#print("set_color() number =", number)
		$MarginContainer/CenterContainer/ColorRect.color = Color("000000")		
	elif number == 1 :
		$MarginContainer/CenterContainer/ColorRect.color = Color("ffffff")
	else:
		$MarginContainer/CenterContainer/ColorRect.color = Color("aaaaaa")
	


# func _ready():
# 	enter_scene()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	set_color()
	


func set_number_text(text):
	$MarginContainer/CenterContainer/ColorRect/Label.text = text
	
	
	
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

# func _on_alpha_tween_tween_completed(object, key):
# 	queue_free()

func set_color_mas():
	colors = [
	"gray = Color( 0.75, 0.75, 0.75, 1 )",
	"aliceblue = Color( 0.94, 0.97, 1, 1 )",
	"antiquewhite = Color( 0.98, 0.92, 0.84, 1 )",
	"aqua = Color( 0, 1, 1, 1 )",
	"aquamarine = Color( 0.5, 1, 0.83, 1 )",
	"azure = Color( 0.94, 1, 1, 1 )",
	"beige = Color( 0.96, 0.96, 0.86, 1 )",
	"bisque = Color( 1, 0.89, 0.77, 1 )",
	"black = Color( 0, 0, 0, 1 )",
	"blanchedalmond = Color( 1, 0.92, 0.8, 1 )",
	"blue = Color( 0, 0, 1, 1 )",
	"blueviolet = Color( 0.54, 0.17, 0.89, 1 )",
	"brown = Color( 0.65, 0.16, 0.16, 1 )",
	"burlywood = Color( 0.87, 0.72, 0.53, 1 )",
	"cadetblue = Color( 0.37, 0.62, 0.63, 1 )",
	"chartreuse = Color( 0.5, 1, 0, 1 )",
	"chocolate = Color( 0.82, 0.41, 0.12, 1 )",
	"coral = Color( 1, 0.5, 0.31, 1 )",
	"cornflower = Color( 0.39, 0.58, 0.93, 1 )",
	"cornsilk = Color( 1, 0.97, 0.86, 1 )",
	"crimson = Color( 0.86, 0.08, 0.24, 1 )",
	"cyan = Color( 0, 1, 1, 1 )",
	"darkblue = Color( 0, 0, 0.55, 1 )",
	"darkcyan = Color( 0, 0.55, 0.55, 1 )",
	"darkgoldenrod = Color( 0.72, 0.53, 0.04, 1 )",
	"darkgray = Color( 0.66, 0.66, 0.66, 1 )",
	"darkgreen = Color( 0, 0.39, 0, 1 )",
	"darkkhaki = Color( 0.74, 0.72, 0.42, 1 )",
	"darkmagenta = Color( 0.55, 0, 0.55, 1 )",
	"darkolivegreen = Color( 0.33, 0.42, 0.18, 1 )",
	"darkorange = Color( 1, 0.55, 0, 1 )",
	"darkorchid = Color( 0.6, 0.2, 0.8, 1 )",
	"darkred = Color( 0.55, 0, 0, 1 )",
	"darksalmon = Color( 0.91, 0.59, 0.48, 1 )",
	"darkseagreen = Color( 0.56, 0.74, 0.56, 1 )",
	"darkslateblue = Color( 0.28, 0.24, 0.55, 1 )",
	"darkslategray = Color( 0.18, 0.31, 0.31, 1 )",
	"darkturquoise = Color( 0, 0.81, 0.82, 1 )",
	"darkviolet = Color( 0.58, 0, 0.83, 1 )",
	"deeppink = Color( 1, 0.08, 0.58, 1 )",
	"deepskyblue = Color( 0, 0.75, 1, 1 )",
	"dimgray = Color( 0.41, 0.41, 0.41, 1 )",
	"dodgerblue = Color( 0.12, 0.56, 1, 1 )",
	"firebrick = Color( 0.7, 0.13, 0.13, 1 )",
	"floralwhite = Color( 1, 0.98, 0.94, 1 )",
	"forestgreen = Color( 0.13, 0.55, 0.13, 1 )",
	"fuchsia = Color( 1, 0, 1, 1 )",
	"gainsboro = Color( 0.86, 0.86, 0.86, 1 )",
	"ghostwhite = Color( 0.97, 0.97, 1, 1 )",
	"gold = Color( 1, 0.84, 0, 1 )",
	"goldenrod = Color( 0.85, 0.65, 0.13, 1 )",
	"green = Color( 0, 1, 0, 1 )",
	"greenyellow = Color( 0.68, 1, 0.18, 1 )",
	"honeydew = Color( 0.94, 1, 0.94, 1 )",
	"hotpink = Color( 1, 0.41, 0.71, 1 )",
	"indianred = Color( 0.8, 0.36, 0.36, 1 )",
	"indigo = Color( 0.29, 0, 0.51, 1 )",
	"ivory = Color( 1, 1, 0.94, 1 )",
	"khaki = Color( 0.94, 0.9, 0.55, 1 )",
	"lavender = Color( 0.9, 0.9, 0.98, 1 )",
	"lavenderblush = Color( 1, 0.94, 0.96, 1 )",
	"lawngreen = Color( 0.49, 0.99, 0, 1 )",
	"lemonchiffon = Color( 1, 0.98, 0.8, 1 )",
	"lightblue = Color( 0.68, 0.85, 0.9, 1 )",
	"lightcoral = Color( 0.94, 0.5, 0.5, 1 )",
	"lightcyan = Color( 0.88, 1, 1, 1 )",
	"lightgoldenrod = Color( 0.98, 0.98, 0.82, 1 )",
	"lightgray = Color( 0.83, 0.83, 0.83, 1 )",
	"lightgreen = Color( 0.56, 0.93, 0.56, 1 )",
	"lightpink = Color( 1, 0.71, 0.76, 1 )",
	"lightsalmon = Color( 1, 0.63, 0.48, 1 )",
	"lightseagreen = Color( 0.13, 0.7, 0.67, 1 )",
	"lightskyblue = Color( 0.53, 0.81, 0.98, 1 )",
	"lightslategray = Color( 0.47, 0.53, 0.6, 1 )",
	"lightsteelblue = Color( 0.69, 0.77, 0.87, 1 )",
	"lightyellow = Color( 1, 1, 0.88, 1 )",
	"lime = Color( 0, 1, 0, 1 )",
	"limegreen = Color( 0.2, 0.8, 0.2, 1 )",
	"linen = Color( 0.98, 0.94, 0.9, 1 )",
	"magenta = Color( 1, 0, 1, 1 )",
	"maroon = Color( 0.69, 0.19, 0.38, 1 )",
	"mediumaquamarine = Color( 0.4, 0.8, 0.67, 1 )",
	"mediumblue = Color( 0, 0, 0.8, 1 )",
	"mediumorchid = Color( 0.73, 0.33, 0.83, 1 )",
	"mediumpurple = Color( 0.58, 0.44, 0.86, 1 )",
	"mediumseagreen = Color( 0.24, 0.7, 0.44, 1 )",
	"mediumslateblue = Color( 0.48, 0.41, 0.93, 1 )",
	"mediumspringgreen = Color( 0, 0.98, 0.6, 1 )",
	"mediumturquoise = Color( 0.28, 0.82, 0.8, 1 )",
	"mediumvioletred = Color( 0.78, 0.08, 0.52, 1 )",
	"midnightblue = Color( 0.1, 0.1, 0.44, 1 )",
	"mintcream = Color( 0.96, 1, 0.98, 1 )",
	"mistyrose = Color( 1, 0.89, 0.88, 1 )",
	"moccasin = Color( 1, 0.89, 0.71, 1 )",
	"navajowhite = Color( 1, 0.87, 0.68, 1 )",
	"navyblue = Color( 0, 0, 0.5, 1 )",
	"oldlace = Color( 0.99, 0.96, 0.9, 1 )",
	"olive = Color( 0.5, 0.5, 0, 1 )",
	"olivedrab = Color( 0.42, 0.56, 0.14, 1 )",
	"orange = Color( 1, 0.65, 0, 1 )",
	"orangered = Color( 1, 0.27, 0, 1 )",
	"orchid = Color( 0.85, 0.44, 0.84, 1 )",
	"palegoldenrod = Color( 0.93, 0.91, 0.67, 1 )",
	"palegreen = Color( 0.6, 0.98, 0.6, 1 )",
	"paleturquoise = Color( 0.69, 0.93, 0.93, 1 )",
	"palevioletred = Color( 0.86, 0.44, 0.58, 1 )",
	"papayawhip = Color( 1, 0.94, 0.84, 1 )",
	"peachpuff = Color( 1, 0.85, 0.73, 1 )",
	"peru = Color( 0.8, 0.52, 0.25, 1 )",
	"pink = Color( 1, 0.75, 0.8, 1 )",
	"plum = Color( 0.87, 0.63, 0.87, 1 )",
	"powderblue = Color( 0.69, 0.88, 0.9, 1 )",
	"purple = Color( 0.63, 0.13, 0.94, 1 )",
	"rebeccapurple = Color( 0.4, 0.2, 0.6, 1 )",
	"red = Color( 1, 0, 0, 1 )",
	"rosybrown = Color( 0.74, 0.56, 0.56, 1 )",
	"royalblue = Color( 0.25, 0.41, 0.88, 1 )",
	"saddlebrown = Color( 0.55, 0.27, 0.07, 1 )",
	"salmon = Color( 0.98, 0.5, 0.45, 1 )",
	"sandybrown = Color( 0.96, 0.64, 0.38, 1 )",
	"seagreen = Color( 0.18, 0.55, 0.34, 1 )",
	"seashell = Color( 1, 0.96, 0.93, 1 )",
	"sienna = Color( 0.63, 0.32, 0.18, 1 )",
	"silver = Color( 0.75, 0.75, 0.75, 1 )",
	"skyblue = Color( 0.53, 0.81, 0.92, 1 )",
	"slateblue = Color( 0.42, 0.35, 0.8, 1 )",
	"slategray = Color( 0.44, 0.5, 0.56, 1 )",
	"snow = Color( 1, 0.98, 0.98, 1 )",
	"springgreen = Color( 0, 1, 0.5, 1 )",
	"steelblue = Color( 0.27, 0.51, 0.71, 1 )",
	"tan = Color( 0.82, 0.71, 0.55, 1 )",
	"teal = Color( 0, 0.5, 0.5, 1 )",
	"thistle = Color( 0.85, 0.75, 0.85, 1 )",
	"tomato = Color( 1, 0.39, 0.28, 1 )",
	"turquoise = Color( 0.25, 0.88, 0.82, 1 )",
	"violet = Color( 0.93, 0.51, 0.93, 1 )",
	"webgray = Color( 0.5, 0.5, 0.5, 1 )",
	"webgreen = Color( 0, 0.5, 0, 1 )",
	"webmaroon = Color( 0.5, 0, 0, 1 )",
	"webpurple = Color( 0.5, 0, 0.5, 1 )",
	"wheat = Color( 0.96, 0.87, 0.7, 1 )",
	"white = Color( 1, 1, 1, 1 )",
	"whitesmoke = Color( 0.96, 0.96, 0.96, 1 )",
	"yellow = Color( 1, 1, 0, 1 )",
	"yellowgreen = Color( 0.6, 0.8, 0.2, 1 )",
	]

	

