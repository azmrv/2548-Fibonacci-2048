extends Node2D


# Signals
signal new_game
signal game_over
signal moving_numbers
signal exit_game
signal save_player_data

#Scenes
var number_scene = preload("res://Scenes/Number.tscn")
var ads_scene = preload("res://Scenes/ADs.tscn")
var gamefield_scene = preload("res://Scenes/GameField.tscn")
var background_scenes = preload("res://Scenes/Background.tscn")

# GUI Scenes
var gui_scene = preload("res://Scenes/GUI.tscn")
#var gui_mainmenu_scene = preload("res://Scenes/GUI_MainMenu.tscn")
#var gui_ingameplay_scene = preload("res://Scenes/GUI_InGamePlay.tscn")
var gui_gameover_scene = preload("res://Scenes/GUI_GameOver.tscn")

#Nodes
var inputLagTimer = null



var screenSize = Vector2(0,0)
var game_window_width_x = 500
var game_window_heigth_y = 800
var game_window_margin = 0

var game_field_width_x = 500
var game_field_margin = 0

var number_size = 80

var clickInput = false

var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var swipe_start = null
var minimum_drag = 100
var swipe = null

const game_field_size = 5 

var hard_level = 3
var iq_level = 0
var new_game_numbers = 3

var curr_color_them = "light"
var main_background_color ="73947A"
var plate_background_color ="5E7478"
var menu_machground = "A5B48C"
var text_color = "363636"


var summ = 0
var eend = 4
var koldop = 2

# for testing old value = 1, 2
var number_one = 123456
var number_two = 123456
var number_three = 3
var number_four = 4
var number_five = 5


var game_field = [[],[]]

var randgen = RandomNumberGenerator.new()

var current_score = 0
var total_score = 0
var best_score = 0

var show_ads = false

var new_game = 1

var number_rect_size = null
var number_scene_pos = 0

func _ready():
	print("_ready()")
	setup()
	new_game()

func setup_nodes():
	print("setup_nodes()")
	inputLagTimer = Timer.new()
	inputLagTimer.wait_time = 1.2
	inputLagTimer.one_shot = true
	inputLagTimer.name = "InputLagTimer"
	self.add_child(inputLagTimer)	
	self.add_child(gui_scene.instance())

func setup_scenes():
	print("setup_scenes()")

func setup_signals():
	print("setup_signals()")
#	gui_scene.connect("gui_mm_start_new_game", self, "_on_GUI_start_new_game")
#	gui_scene.connect("gui_mm_options", self, "_on_GUI_options")
#	gui_scene.connect("gui_mm_help", self, "_on_GUI_help")
	pass

func _process(_delta):
	#if	new_game != 0:
		#print("_process(_delta)")
		#touch_input()
		#draw_field()
	pass

func new_game():
	print("new_game()")
	randgen.randomize()	
	$GUI.visible = true
	game_field = make_matrix()
	summ = 0
	create_numbers_on_game_field()
	fill_field_with_numbers()
	reasign_numbers_to_field()
	#inputLagTimer.start()
	new_game = 1

func setup():
	print("setup()")
	randgen.randomize()
	setup_scenes()
	setup_nodes()
	setup_window()
	setup_signals()
	setup_thems()
	#$Music.play()
	#$GUI.show_message("Get Ready")

func setup_thems():
	$GUI/VBoxC/Menu/VBox/Score/Best
	pass


func setup_window():
	print("setup_window()")
	#set_size(get_tree().get_root().get_rect().size) 
	#screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
	#screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	print(screenSize)
	
	number_scene_pos = Vector2(0,0)
	
	game_window_width_x = screenSize.x
	game_window_heigth_y = screenSize.y
	game_window_margin = 0
		
	game_field_width_x = game_window_width_x
	game_field_margin = 0
	
	number_size = game_field_width_x / game_field_size
	number_rect_size = Vector2(number_size, number_size)

func show_ads(show : bool):
	print("show_ads()")
	$GUI.visible = false
	show_ads = show
	self.add_child(ads_scene.instance())
	$ADs/ADsTimer.start()
	#$GUI.show_message("ADs, Money blwe $$$$$$$" )
	$ADs.visible = true


func show_gui():
	self.visible = true
	$GUI.visible = true


func game_over():
	print("game_over()")
	new_game = 0
	randgen.randomize()
	$GUI.visible = false
	self.add_child(gui_gameover_scene.instance())
	#$GUI.show_ingame_menu(false)
	#$GameField.visible = false
	$GUI/VBoxC/GFContainer/GameField.get_children().clear()
	#$Music.stop()
	#$Sound.play()
	#$Background.color = Color(1, 0, 0, 1)
	#$ScoreTimer.stop()
	#$MobTimer.stop()
	#$HUD.show_game_over()
	#get_tree().call_group("mobs", "queue_free")
	#$Background.color = Color(0.098039, 0.823529, 0.501961)
	#print("КОНЕЦ ИГРЫ", "СУММА =", summ)
	#$GUI.show_message("Game Over, Score = %s" % summ)
	#$GUI.show_gameover_menu(true)
	
	$GUI.update_score(summ)

func exit_game():
	print("exit_game()")
	get_tree().quit()

func exit_to_mainmenu():
	$GUI.show_ingame_menu(false)
	$GameField.visible = false
	$GUI.show_main_menu(true)

func make_matrix():
	print("make_2d_array()")
	var array = []
	for colx in game_field_size:
		array.append([])
		for rowy in game_field_size:
			array[colx].append(null)
	return array

func show_message(text):
	print("show_message(text)")
	$GUI/GUI_InGamePlay/Message.text = text
	$GUI/GUI_InGamePlay/Message.show()
	$GUI/GUI_InGamePlay/MessageTimer.start()

func generate_new_numbers_in_array():
	print("generate_new_numbers_in_array()")
	randgen.randomize()
	var kodn = koldop
	while kodn > 0:
		#var nx = randgen.randf()
		#var ny = randgen.randf()
		#var x = int(nx * game_field_size % 1)
		#var y = int(ny * game_field_size % 1)
		# вот теперь не зависает в этом месте при попытке разместить числа на поле доп проверка на свободное место
		if blank_space_on_board():
			var colx = randgen.randi_range(0,game_field_size - 1)
			var rowy = randgen.randi_range(0,game_field_size - 1)
			#print(rowy, colx)
			if game_field[rowy][colx] == null:
				kodn = kodn - 1
				var num = randgen.randf()
				if num <= 0.618:
					game_field[rowy][colx] = number_one
					summ += 1
				else:
					game_field[rowy][colx] = number_two
					summ += 2
	#			if num <= 0.5:
	#				game_field[rowy][colx] = 1
	#				summ += 1
	#			elif num <= 0.8:
	#				game_field[rowy][colx] = 2
	#				summ += 2
	#			else:
	#				game_field[rowy][colx] = 3
	#				summ += 3	
		else:
			return

func blank_space_on_board():
	#print("blank_space_on_board()")
	for colx in game_field_size:
		for rowy in game_field_size:
			if game_field[rowy][colx] == null or game_field[rowy][colx] == 0:
				return true
	return false

func fill_field_with_numbers():
	print("fill_board()")
	if blank_space_on_board():
		generate_new_numbers_in_array()
	else:
		game_over()

func create_numbers_on_game_field():
	print("create_numbers_on_game_field()")
	randgen.randomize()
	for colx in range(game_field_size):
		for rowy in range(game_field_size):
			var curr_number = number_scene.instance()
			#$GUI/VBoxC/GFContainer/GameField/VBoxContainer/ColorRect
			$GUI/VBoxC/GFContainer/GameField.add_child(curr_number)
			if game_field[rowy][colx] == null:
				curr_number.set_xy(rowy, colx)
				curr_number.setup_number_rect(number_rect_size)
				curr_number.set_number_text("")
				curr_number.position.x = number_size * colx + game_field_margin * (colx + 1)
				curr_number.position.y = number_size * rowy + game_field_margin * (rowy + 1)
			else:
				print("draw_field() %s " % game_field[rowy][colx] as String)
				curr_number.set_xy(rowy, colx)
				curr_number.setup_number_rect(number_rect_size)
				curr_number.set_number_to_label(game_field[rowy][colx])
				curr_number.position.x = number_size * colx + game_field_margin * (colx + 1)
				curr_number.position.y = number_size * rowy + game_field_margin * (rowy + 1)

func reasign_numbers_to_field():
	print("reasign_numbers_to_field()")
	randgen.randomize()
	for colx in range(game_field_size):
		for rowy in range(game_field_size):
			#curr_number.window_size = $GameField.get_viewport().get_visible_rect().size
			var children_mas_number_scene =  $GUI/VBoxC/GFContainer/GameField.get_children()
			for i in range(len(children_mas_number_scene)):
				if children_mas_number_scene[i].curry_row == rowy and children_mas_number_scene[i].currx_col == colx:
					if game_field[rowy][colx] == null: 
						children_mas_number_scene[i].set_number_text("")
					else:
						children_mas_number_scene[i].set_number_to_label(game_field[rowy][colx])	
	$GUI.update_score(summ)

func move_down(mas):
	print("func move_right(mas)")
	randgen.randomize()
 
	var kodx1 = 1
	while kodx1 == 1:
		var sempty = 0
		for colx in range(game_field_size):
			
			for rowy in range(game_field_size-1):
				
				if mas[rowy][colx] != null:
					if mas[rowy+1][colx] == null:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy+1][colx] == 1:
						if mas[rowy][colx] == 1 or mas[rowy][colx] == 2:
							kodx1 += 1
							mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
							mas[rowy][colx] = null
					elif mas[rowy+1][colx] > mas[rowy][colx] and mas[rowy+1][colx] <= 2 * mas[rowy][colx]:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy+1][colx] < mas[rowy][colx] and mas[rowy][colx] <= 2 * mas[rowy+1][colx]:
						kodx1 += 1
						mas[rowy+1][colx] = mas[rowy+1][colx]+mas[rowy][colx]
						mas[rowy][colx] = null
				else:
					sempty += 1					
		if kodx1 > 1:
			kodx1 = 1
		else:
			kodx1 = 0
			if sempty == 0:
				game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	reasign_numbers_to_field()

func move_up(mas):
	print("func move_up(mas)")
	randgen.randomize()
		
	var kodx2 = 1
	while kodx2 == 1:
		var sempty = 0
		for colx in range(game_field_size):
			
			for rowy in range(1, game_field_size):
				
				if mas[game_field_size-rowy][colx] != null:
					if  mas[game_field_size-rowy-1][colx] == null:
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] == 1:
						if  mas[game_field_size-rowy][colx] == 1 or  mas[game_field_size-rowy][colx] == 2:
							kodx2+=1
							mas[game_field_size-rowy-1][colx] = mas[game_field_size-rowy-1][colx]+ mas[game_field_size-rowy][colx]
							mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] > mas[game_field_size-rowy][colx]  and  mas[game_field_size-rowy-1][colx] <= 2 * mas[game_field_size-rowy][colx] :
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy-1][colx]+ mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
					elif  mas[game_field_size-rowy-1][colx] <  mas[game_field_size-rowy][colx] and  mas[game_field_size-rowy][colx] <= 2 *  mas[game_field_size-rowy-1][colx]:
						kodx2+=1
						mas[game_field_size-rowy-1][colx] =  mas[game_field_size-rowy-1][colx] +  mas[game_field_size-rowy][colx]
						mas[game_field_size-rowy][colx] = null
				else:
					sempty += 1

		if kodx2 > 1:
			kodx2 = 1
		else:
			kodx2 = 0
			if sempty == 0:
				game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	reasign_numbers_to_field()

func move_right(mas):
	print("func move_down(mas)")
	randgen.randomize()

	var kody1 = 1
	while kody1 == 1:
		var sempty = 0
		for rowy in range(game_field_size):
			
			for colx in range(game_field_size-1):
				
				if mas[rowy][colx] != null:
					if mas[rowy][colx+1] == null:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy][colx+1] == 1:
						if mas[rowy][colx] == 1 or mas[rowy][colx] == 2:
							kody1+=1
							mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
							mas[rowy][colx] = null
					elif mas[rowy][colx+1] > mas[rowy][colx] and mas[rowy][colx+1] <= 2 * mas[rowy][colx]:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
						mas[rowy][colx] = null
					elif mas[rowy][colx+1] < mas[rowy][colx] and mas[rowy][colx] <= 2 * mas[rowy][colx+1]:
						kody1+=1
						mas[rowy][colx+1] = mas[rowy][colx+1]+mas[rowy][colx]
						mas[rowy][colx] = null	
				else:
					sempty += 1					
		if kody1 > 1:
			kody1 = 1
		else:
			kody1 = 0
			if sempty == 0:
				game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()
	reasign_numbers_to_field()	

func move_left(mas):
	print("func move_left(mas)")
	randgen.randomize()
		
	var kody2 = 1
	while kody2 == 1:
		var sempty = 0
		for rowy in range(game_field_size):
			
			for colx in range(1, game_field_size):
				
				if mas[rowy][game_field_size-colx] != null:
					if mas[rowy][game_field_size-colx-1]== null:
						kody2+=1
						mas[rowy][game_field_size-colx-1] =  mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] = null
					elif mas[rowy][game_field_size-colx-1]  == 1:
						if  mas[rowy][game_field_size-colx] == 1 or  mas[rowy][game_field_size-colx] == 2:
							kody2+=1
							mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
							mas[rowy][game_field_size-colx] = null
					elif  mas[rowy][game_field_size-colx-1] >  mas[rowy][game_field_size-colx] and  mas[rowy][game_field_size-colx-1] <= 2 * mas[rowy][game_field_size-colx]  :
						kody2+=1
						mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] =  null
						
					elif  mas[rowy][game_field_size-colx-1] < mas[rowy][game_field_size-colx] and  mas[rowy][game_field_size-colx] <= 2 * mas[rowy][game_field_size-colx-1] :
						kody2+=1
						mas[rowy][game_field_size-colx-1] = mas[rowy][game_field_size-colx-1] + mas[rowy][game_field_size-colx]
						mas[rowy][game_field_size-colx] =  null
				else:
					sempty += 1
											
		if kody2 > 1:
			kody2 = 1
		else:
			kody2 = 0
			if sempty == 0:
				game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			fill_field_with_numbers()

	reasign_numbers_to_field()

func _on_GUI_new_game() -> void:
	print("_on_GUI_start_new_game() -> void")
	new_game()

func _on_GUI_gui_exit_to_menu() -> void:
	exit_to_mainmenu()

func _on_InputLagTimer_timeout() -> void:
	# для предотвращения срабатывания перераспределения чисел на поле и запуска худа
	new_game = 1
	$GameField.visible = true

func _input(event):
	if	(new_game != 0) && (clickInput == true):
		#print("_input(event)", event)
		if(Input.is_action_just_pressed("ui_touch")):
			print("_input(event) - (Input.is_action_just_PREssed(ui_touch))")
			first_touch = (get_global_mouse_position())
		if(Input.is_action_just_released("ui_touch")):
			print("_input(event) - (Input.is_action_just_REleased(ui_touch))")
			final_touch = (get_global_mouse_position())
			calculate_direction()
	elif new_game != 0:
		if event is InputEventScreenTouch:
			if event.pressed:
			  swipe_start = event.get_position()
			else:
			  _calculate_swipe(event.get_position())


#func _unhandled_input(event):
#	if event.is_action_pressed("click"):
#		swipe_start = event.get_position()
#	if event.is_action_released("click"):
#		_calculate_swipe(event.get_position())
	
func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			move_right(game_field)
		if swipe.x < 0:
			move_left(game_field)
	if abs(swipe.y) > minimum_drag:
		if swipe.y > 0:
			move_down(game_field)
		if swipe.y < 0:
			move_up(game_field)

func calculate_direction():
	# организовать привязку к игровому полю и его параметрам без учета размеров экрана игры и худа
	var k_scr = (game_window_heigth_y - game_window_width_x)/2
	print("calculate_direction()")
	print("y =", final_touch.y, " x =", final_touch.x)	
	if final_touch.x > final_touch.y-k_scr:		
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			move_up(game_field)
		else:
			move_right(game_field)
	else:
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			move_left(game_field)
		else:
			move_down(game_field) 


func _on_ADs_ads_done() -> void:
	print("_on_ADs_ads_done()")
	ads_scene.queue_free()
	gui_gameover_scene.queue_free()

func colors_thems(curr_color_them : String):
	if curr_color_them == "light":
		main_background_color ="73947A"
		plate_background_color ="5E7478"
		menu_machground = "A5B48C"
		text_color = "363636"		
	elif curr_color_them == "dark":
		main_background_color ="011606"
		plate_background_color ="0C1618"
		menu_machground = "1D2411"
		text_color = "9E9E9E"		
	else:
		return
