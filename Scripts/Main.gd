extends Node2D


# Signals
signal new_game
signal game_over
signal moving_numbers
signal exit_game
signal save_player_data

#export (PackedScene) var CurNumber 
var number_scene = preload("res://Scenes/Number.tscn")
var ads_scene = preload("res://Scenes/ADs.tscn")
var gui_scene = preload("res://Scenes/GUI.tscn")

# Variables
const game_field_size = 5 

var screenSize = Vector2(0,0)
#const game_window_width = 480
#const game_window_heigth = 720
const game_window_margin = 0

const game_field_draw_size = 480
const game_field_width = 480
const game_field_heigth = 480
const game_field_margin = 0

var number_scene_size = game_field_width / game_field_size

# Touch Variables
var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var target = Vector2(0, 0)
var last_direction = 0
var swipe = 1

# Game Hard Level
# количество цифр за ход
# начальное количество цифр на доске
# размер доски 4х4 / 6х6 / 8х8
var hard_level = 3
var iq_level = 0
var new_game_numbers = 3


var summ = 0
var eend = 4
var koldop = 2



var game_field = [[],[]]

var randgen = RandomNumberGenerator.new()

var current_score = 0
var total_score = 0
var best_score = 0

var new_game = 0

var number_rect_size = Vector2(number_scene_size, number_scene_size)
var number_scene_pos = Vector2(0,0)	

func _ready():	
	print("_ready()")	
	#setup()
	
	
func _process(_delta):
	#if	new_game != 0:
		#print("_process(_delta)")
		#touch_input()
		#draw_field()
	pass

func start_new_game():
	print("new_game()")
	randgen.randomize()
		
	setup()
	#$Music.play()	
	
	$GUI.show_message("Get Ready")

	

func setup():
	print("setup()")
	randgen.randomize()
	game_field = make_2d_array()
	summ = 0
	#CurNumber = number
	create_numbers_on_game_field()
	fill_field_with_numbers()
	reasign_numbers_to_field()
	setup_window()
	
	
func setup_window():
	print("setup_window()")
	#set_size(get_tree().get_root().get_rect().size) 
	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	print(screenSize)
	#Get the scale
#	var newH = get_size().y
#	var scale = newH / defH
	
#	var options = get_node("options") #Get the buttons to resize
	
#	options.set_scale(scale * options.get_scale()) #Scale to new resolution
	#Scale the margin so it keeps the proportions
	
#	options.set_margin(MARGIN_LEFT, options.get_margin(MARGIN_LEFT) * scale)
#	options.set_margin(MARGIN_TOP, options.get_margin(MARGIN_TOP) * scale)

	
	
func show_ads():
	print("show_ads()")


func game_over():
	
	print("game_over()")
	randgen.randomize()
	$GameField/VBoxContainer/ColorRect.get_children().clear()
	#$Music.stop()
	#$Sound.play()
	#$Background.color = Color(1, 0, 0, 1)
	#$ScoreTimer.stop()
	#$MobTimer.stop()	
	#$HUD.show_game_over()	
	#get_tree().call_group("mobs", "queue_free")
	#$Background.color = Color(0.098039, 0.823529, 0.501961)	
	#print("КОНЕЦ ИГРЫ", "СУММА =", summ)
	$GUI.show_message("Game Over, Score = %s" % summ)
	show_ads()
	# emit signal?
	summ = 0
	# need pause before change UI
	exit_to_mainmenu()


func exit_game():
	print("exit_game()")
	get_tree().quit()


func exit_to_mainmenu():
	$GUI.show_main_menu(true)
	$GUI.show_ingame_menu(false)	
	$GameField.visible = false
	#get_tree().quit()


func increase_score(amount):
	print("increase_score(amount)")	
	current_score += amount
	total_score += current_score


func make_2d_array():
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
					game_field[rowy][colx] = 1
					summ += 1
	
				else:
					game_field[rowy][colx] = 2
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
	print("blank_space_on_board()")	
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
	#if $GameField/PanelContainer.get_child_count() == null or $GameField/PanelContainer.get_child_count() <= 0:	
	randgen.randomize()	
	
	for colx in range(game_field_size):
		for rowy in range(game_field_size):
			var curr_number = number_scene.instance()			
			$GameField/VBoxContainer/ColorRect.add_child(curr_number)
			#curr_number.window_size = $GameField.get_viewport().get_visible_rect().size
			if game_field[rowy][colx] == null:
				number_scene_pos = curr_number.position
				curr_number.set_xy(rowy, colx)
				curr_number.set_rect_size(number_rect_size)
				curr_number.set_number_text("0")
				curr_number.position.x = number_scene_size * colx + game_field_margin * (colx + 1)
				curr_number.position.y = number_scene_size * rowy + game_field_margin * (rowy + 1)
			else:
				number_scene_pos = curr_number.position
				print("draw_field() %s " % game_field[rowy][colx] as String)
				curr_number.set_xy(rowy, colx)
				curr_number.set_rect_size(number_rect_size)				
				curr_number.set_number_text(game_field[rowy][colx] as String)
				curr_number.position.x = number_scene_size * colx + game_field_margin * (colx + 1)
				curr_number.position.y = number_scene_size * rowy + game_field_margin * (rowy + 1)
				#curr_number.position = Vector2(rand_range(0, window_size.x), rand_range(0, window_size.y))
	#print(game_field)


func reasign_numbers_to_field():
	print("reasign_numbers_to_field()")	
	randgen.randomize()		
	for colx in range(game_field_size):
		for rowy in range(game_field_size):			
			#curr_number.window_size = $GameField.get_viewport().get_visible_rect().size
			var children_mas_number_scene = $GameField/VBoxContainer/ColorRect.get_children()
			for i in range(len(children_mas_number_scene)):
				if children_mas_number_scene[i].curry_row == rowy and children_mas_number_scene[i].currx_col == colx:
					if game_field[rowy][colx] == null: 
						children_mas_number_scene[i].set_number_to_label(0)
					else:
						children_mas_number_scene[i].set_number_to_label(game_field[rowy][colx])
	swipe = 1
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
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)
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
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)
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
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)
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
#			if get_empty(mas) > eend:
#				mas, summ = rand_(mas, summ)
	reasign_numbers_to_field()


func _on_GUI_start_new_game() -> void:
	print("_on_GUI_start_new_game() -> void")	
	$GUI.show_main_menu(false)
	$GUI.show_ingame_menu(true)
	$GUI/GUI_InGamePlay/CenterContainer/Score.visible = false
	randgen.randomize()		
	start_new_game()
	$InputLagTimer.start()


func _on_GUI_exit_to_menu() -> void:
	exit_to_mainmenu()


func _on_InputLagTimer_timeout() -> void:
	# для предотвращения ложного срабатывания перераспределения чисел на поле
	new_game = 1
	$GameField.visible = true
	$GUI/GUI_InGamePlay/CenterContainer/Score.visible = true


func _input(event):
	
	if	new_game != 0:
		if swipe != 0:
			if event is InputEventScreenDrag: 	
				if event.relative.y > 0: 
					print("_input(event) - event.relative.y > 0")
					move_down(game_field)
					swipe = 0
				elif event.relative.y < 0: 					
					move_up(game_field)
					swipe = 0
				elif event.relative.x < 0: 					
					move_left(game_field)
					swipe = 0
				elif event.relative.x > 0: 					 
					move_right(game_field)
					swipe = 0

		elif event is InputEventScreenTouch: # Затем обработаем событие отпускания экрана
			if !event.pressed: # Когда игрок убирает палец с экрана
				swipe = 1
			
#		if(Input.is_action_just_pressed("ui_touch")):
#			print("_input(event) - (Input.is_action_just_PREssed(ui_touch))")
#			first_touch = (get_global_mouse_position())
#		if(Input.is_action_just_released("ui_touch")):
#			print("_input(event) - (Input.is_action_just_REleased(ui_touch))")
#			final_touch = (get_global_mouse_position())
#			calculate_direction()
#		if event is InputEventScreenTouch and event.pressed:
#			print("_input(event) - InputEventScreenTouch", event)
#			first_touch = event.position
#		if event is InputEventScreenTouch and event.pressed:
#			print("_input(event) - InputEventScreenTouch", event)
#			final_touch = event.position
#			calculate_direction()
			#swipe_angle()


func calculate_direction():	
	print("calculate_direction()")
	print("y =", final_touch.y, " x =", final_touch.x)
	if final_touch.x > 336 :
		move_right(game_field)
	elif final_touch.x < 144:
		move_left(game_field)
	elif final_touch.y > 576:
		move_down(game_field)
	elif final_touch.y < 384:
		move_up(game_field)
	# не дожно происходить событий просто по клику по экрану любое случайное нажатие генерирует работу функций
	#else:
	#	fill_field_with_numbers()



func swipe_angle():
	var difference = final_touch - first_touch
	var angle = rad2deg(atan2(difference.x, difference.y))
	print(angle)
