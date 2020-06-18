extends Node2D


# Signals
signal new_game
signal game_over
signal moving_numbers
signal exit_game
signal save_player_data


#export (PackedScene) var CurNumber 
var number_scene = preload("res://Scenes/Number.tscn")

# Variables
const game_field_size = 6 

const game_window_width = 480
const game_window_heigth = 720
const game_window_margin = 0

const game_field_draw_size = 480
const game_field_width = 480
const game_field_heigth = 480
const game_field_margin = 0

var number_scene_size = game_field_width / game_field_size

# Touch Variables
var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var last_direction = 0

# Game Hard Level
# количество цифр за ход
# начальное количество цифр на доске
# размер доски 4х4 / 6х6 / 8х8
var hard_level = 3
var iq_level = 0
var new_game_numbers = 3


var summ = 0
var eend = 3

var game_field = [[],[]]

var randgen = RandomNumberGenerator.new()

var current_score = 0
var score = 0
var best_score = 0

var new_game = 0


func _ready():	
	print("_ready()")	
	
	
	
func _process(_delta):
	if	new_game != 0:
		#print("_process(_delta)")
		touch_input()
		#draw_field()		
		
		

func start_new_game():
	print("new_game()")
	randgen.randomize()
	setup()
	#$Music.play()	
	$GUI.update_score(score)
	$GUI.show_message("Get Ready")

	

func setup():
	print("setup()")	
	randgen.randomize()	
	game_field = make_2d_array()
	score = 0
	#CurNumber = number
	create_numbers_on_game_field()
	fill_field_with_numbers()
	reasign_numbers_to_field()
	

func show_ads():
	print("show_ads()")


func game_over():
	print("game_over()")
	randgen.randomize()
	$GameField/PanelContainer.get_children().clear()
	#$Music.stop()
	#$DeathSound.play()
	#$Background.color = Color(1, 0, 0, 1)
	#$ScoreTimer.stop()
	#$MobTimer.stop()	
	#$HUD.show_game_over()	
	#get_tree().call_group("mobs", "queue_free")
	#$Background.color = Color(0.098039, 0.823529, 0.501961)	
	#print("КОНЕЦ ИГРЫ", "СУММА =", summ)
	$GUI.show_message("Game Over, Score = %s" % score)
	# emit signal?
	summ = 0
	# need pause before change UI
	$GameField.visible = false
	$GUI.show_ingame_menu(false)
	$GUI.show_main_menu(true)


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
	score += amount
	


func make_2d_array():
	print("make_2d_array()")
	var array = []
	for i in game_field_size:
		array.append([])
		for j in game_field_size:
			array[i].append(null)
	return array


func show_message(text):
	print("show_message(text)")
	$GUI/GUI_InGamePlay/Message.text = text
	$GUI/GUI_InGamePlay/Message.show()
	$GUI/GUI_InGamePlay/MessageTimer.start()


func generate_new_numbers_in_array():
	print("possible_numbers()")
	randgen.randomize()
	var kodn = 1	
	while kodn == 1:		
		var x = randgen.randi_range(0,game_field_size - 1)
		var y = randgen.randi_range(0,game_field_size - 1)
		print(x, y)
		if game_field[x][y] == null:
			kodn = 0
			var num = randgen.randf()
			if num <= 0.45:
				game_field[x][y] = 1
				summ += 1
			elif num <= 0.73:
				game_field[x][y] = 2
				summ += 2
			elif num <= 0.9:
				game_field[x][y] = 3
				summ += 3
			else:
				game_field[x][y] = 5
				summ += 5	
	


func blank_space_on_board():
	print("blank_space_on_board()")	
	for i in game_field_size:
		for j in game_field_size:
			if game_field[i][j] == null or game_field[i][j] == 0:
				return true
	return false


func fill_field_with_numbers():
	print("fill_field_with_numbers()")
	for x in range(new_game_numbers):
		if blank_space_on_board():
			generate_new_numbers_in_array()
		else:
			game_over()	


func create_numbers_on_game_field():
	print("create_numbers_on_game_field()")
	#if $GameField/PanelContainer.get_child_count() == null or $GameField/PanelContainer.get_child_count() <= 0:	
	randgen.randomize()	
	var number_scene_pos = Vector2(0,0)
	for row in range(game_field_size):
		for col in range(game_field_size):
			var curr_number = number_scene.instance()
			$GameField/PanelContainer/TextureRect.add_child(curr_number)
			#curr_number.window_size = $GameField.get_viewport().get_visible_rect().size
			if game_field[row][col] == null:
				number_scene_pos = curr_number.position
				curr_number.set_xy(row, col)
				curr_number.set_number_text("0")
				curr_number.position.x = number_scene_size * col + game_field_margin * (col + 1)
				curr_number.position.y = number_scene_size * row + game_field_margin * (row + 1)
			else:
				number_scene_pos = curr_number.position
				print("draw_field() %s " % game_field[row][col] as String)
				curr_number.set_number_text(game_field[row][col] as String)
				curr_number.position.x = number_scene_size * col + game_field_margin * (col + 1)
				curr_number.position.y = number_scene_size * row + game_field_margin * (row + 1)
				#curr_number.position = Vector2(rand_range(0, window_size.x), rand_range(0, window_size.y))
	print(game_field)


func reasign_numbers_to_field():
	print("reasign_numbers_to_field()")	
	randgen.randomize()		
	for row in range(game_field_size):
		for col in range(game_field_size):			
			#curr_number.window_size = $GameField.get_viewport().get_visible_rect().size
			var children_mas_number_scene = $GameField/PanelContainer/TextureRect.get_children()
			for i in range(len(children_mas_number_scene)):
				if children_mas_number_scene[i].currx_row == row and children_mas_number_scene[i].curry_col == col:
					if game_field[row][col] == null: 
						children_mas_number_scene[i].set_text("0")
					else:
						children_mas_number_scene[i].set_text(game_field[row][col] as String)
	increase_score(summ)
	

func move_right(mas):
	print("func move_right(mas)")
	randgen.randomize()
	var kodx2 = 1
	while kodx2 == 1:
		for x in range(1, game_field_size):
			for y in range(game_field_size):
				if mas[y][game_field_size-x-1] != null:
					if mas[y][game_field_size-x] == null:
						kodx2 += 1
						mas[y][game_field_size-x] = mas[y][game_field_size-x-1]
						mas[y][game_field_size-x-1] = null
					elif mas[y][game_field_size-x] == 1 and mas[y][game_field_size-x-1] == 1:
						kodx2 += 1
						mas[y][game_field_size-x] = 2
						mas[y][game_field_size-x-1] = null
					elif mas[y][game_field_size-x] < mas[y][game_field_size-x-1] and 2 * mas[y][game_field_size-x] >= mas[y][game_field_size-x-1]:
						kodx2 += 1
						mas[y][game_field_size-x] = mas[y][game_field_size-x] + mas[y][game_field_size-x-1]
						mas[y][game_field_size-x-1] = null
					elif mas[y][game_field_size-x] > mas[y][game_field_size-x-1] and 2 * mas[y][game_field_size-x-1] >= mas[y][game_field_size-x]:
						kodx2 += 1
						mas[y][game_field_size-x] = mas[y][game_field_size-x] + mas[y][game_field_size-x-1]
						mas[y][game_field_size-x-1] = null
		if kodx2 > 1:
			kodx2 = 1
		else:
			kodx2 = 0
			fill_field_with_numbers()			
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)
	reasign_numbers_to_field()		


func move_left(mas):
	print("func move_left(mas)")
	randgen.randomize()
	var kodx1 = 1
	while kodx1 == 1:
		for x in range(1, game_field_size):
			for y in range(game_field_size):
				if mas[y][x] != null:
					if mas[y][x-1] == null:
						kodx1 += 1
						mas[y][x-1] = mas[y][x]
						mas[y][x] = null
					elif mas[y][x-1] == 1 and mas[y][x] == 1:
						kodx1 += 1
						mas[y][x-1] = 2
						mas[y][x] = null
					elif mas[y][x-1] < mas[y][x] and 2 * mas[y][x-1] >= mas[y][x]:
						kodx1 += 1
						mas[y][x-1] = mas[y][x-1] + mas[y][x]
						mas[y][x] = null
					elif mas[y][x-1] > mas[y][x] and 2 * mas[y][x] >= mas[y][x-1]:
						kodx1 += 1
						mas[y][x-1] = mas[y][x-1] + mas[y][x]
						mas[y][x] = null

		if kodx1 > 1:
			kodx1 = 1
		else:
			kodx1 = 0
			fill_field_with_numbers()
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)
	reasign_numbers_to_field()			


func move_up(mas):
	print("func move_up(mas)")
	randgen.randomize()
	var kody1 = 1
	while kody1 == 1:
		for y in range(1, game_field_size):
			for x in range(game_field_size):
				if mas[y][x] != null:
					if mas[y-1][x] == null:
						kody1 += 1
						mas[y-1][x] = mas[y][x]
						mas[y][x] = null
					elif mas[y-1][x] == 1 and mas[y][x] == 1:
						kody1 += 1
						mas[y-1][x] = 2
						mas[y][x] = null
					elif mas[y-1][x] < mas[y][x] and 2 * mas[y-1][x] >= mas[y][x]:
						kody1 += 1
						mas[y-1][x] = mas[y-1][x] + mas[y][x]
						mas[y][x] = null
					elif mas[y-1][x] > mas[y][x] and 2 * mas[y][x] >= mas[y-1][x]:
						kody1 += 1
						mas[y-1][x] = mas[y-1][x] + mas[y][x]
						mas[y][x] = null

		if kody1 > 1:
			kody1 = 1
		else:
			kody1 = 0
			fill_field_with_numbers()
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)
	reasign_numbers_to_field()	


func move_down(mas):
	print("func move_down(mas)")
	randgen.randomize()
	var kody2 = 1
	while kody2 == 1:
		for y in range(1, game_field_size):
			for x in range(game_field_size):
				if mas[game_field_size-y-1][x] != null:
					if mas[game_field_size-y][x] == null:
						kody2 += 1
						mas[game_field_size-y][x] = mas[game_field_size-y-1][x]
						mas[game_field_size-y-1][x] = null
					elif mas[game_field_size-y][x] == 1 and mas[game_field_size-y-1][x] == 1:
						kody2 += 1
						mas[game_field_size-y][x] = 2
						mas[game_field_size-y-1][x] = null
					elif mas[game_field_size-y][x] < mas[game_field_size-y-1][x] and 2 * mas[game_field_size-y][x] >= mas[game_field_size-y-1][x]:
						kody2 += 1
						mas[game_field_size-y][x] = mas[game_field_size-y][x] + mas[game_field_size-y-1][x]
						mas[game_field_size-y-1][x] = null
					elif mas[game_field_size-y][x] > mas[game_field_size-y-1][x] and 2 * mas[game_field_size-y-1][x] >= mas[game_field_size-y][x]:
						kody2 += 1
						mas[game_field_size-y][x] = mas[game_field_size-y][x] + mas[game_field_size-y-1][x]
						mas[game_field_size-y-1][x] = null
		if kody2 > 1:
			kody2 = 1
		else:
			kody2 = 0
			fill_field_with_numbers()
			# if get_empty(mas) > eend:
			# 	mas, summ = rand_(mas, summ)
	reasign_numbers_to_field()	


func _on_GUI_start_new_game() -> void:
	print("_on_GUI_start_new_game() -> void")	
	$GUI.show_main_menu(false)
	$GUI.show_ingame_menu(true)
	randgen.randomize()		
	start_new_game()
	$InputLagTimer.start()


func _on_GUI_exit_to_menu() -> void:
	exit_to_mainmenu()
	


func _on_InputLagTimer_timeout() -> void:
	# для предотвращения ложного срабатывания перераспределения чисел на поле
	new_game = 1
	$GameField.visible = true
	

func touch_input():
	if(Input.is_action_just_pressed("ui_touch")):
		#print("touch_input() - (Input.is_action_just_PREssed(ui_touch))")
		first_touch = (get_global_mouse_position())
	if(Input.is_action_just_released("ui_touch")):
		#print("touch_input() - (Input.is_action_just_REleased(ui_touch))")
		final_touch = (get_global_mouse_position())
		calculate_direction()
		swipe_angle()


func swipe_angle():
	#print("swipe_angle()")
	var difference = final_touch - first_touch
	var angle = rad2deg(atan2(difference.x, difference.y))
	print(angle)


func calculate_direction():
	#print("calculate_direction()")
	var difference = final_touch - first_touch
	if abs(difference.x) > abs(difference.y):
		if difference.x >= 25:
			move_right(game_field)						
		elif difference.x <= -25:
			move_left(game_field)						
	elif abs(difference.x) <= abs(difference.y):
		if difference.y <= -25:
			move_up(game_field)
		elif difference.y >= 25:
			move_down(game_field)
	if abs(difference.x) >= 25 || abs(difference.y) >= 25:
		fill_field_with_numbers()



