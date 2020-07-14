extends Node2D


var screenSize = Vector2(0,0)
var game_window_width_x = 500
var game_window_heigth_y = 800
var game_window_margin = 0

var game_field_width_x = 500
var game_field_margin = 0

var eend = 4
var koldop = 2
var game_field_size = 5


var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var swipe_start = null
var minimum_drag = 100
var swipe = null



func _ready() -> void:
	setup()
	Main.new_game()


func setup():
	print("MainWindow setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
#	$MainWindow.rect_min_size = screenSize
	game_field_size = Main.game_field_size
	game_window_width_x = screenSize.x
	game_window_heigth_y = screenSize.y
	game_field_width_x = game_window_width_x
	eend = Main.eend
	koldop = Main.koldop
	print("set screen size = %s" %  screenSize)



func move_down(mas):
	print("func move_down(mas)")
	Main.randgen.randomize()
	Main.undo_game_field = mas
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
				# после окончания игры прододжает выполнять fill_field_with_numbers()
#				Main.game_over()
				Main.fill_field_with_numbers()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			Main.fill_field_with_numbers()
	if Main.gui_node != null && Main.new_game != 0:
		Main.gui_node.reasign_numbers_to_field()
	Main.update_score()

func move_up(mas):
	print("func move_up(mas)")
	Main.randgen.randomize()
	Main.undo_game_field = mas
	var kodx2 = 1
	while kodx2 == 1:
		var sempty = 0
		for colx in range(Main.game_field_size):
			
			for rowy in range(1, Main.game_field_size):
				
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
				Main.fill_field_with_numbers()
#				Main.game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			Main.fill_field_with_numbers()
	if Main.gui_node != null && Main.new_game != 0:
		Main.gui_node.reasign_numbers_to_field()
	Main.update_score()
	
func move_right(mas):
	print("func move_right(mas)")
	Main.randgen.randomize()
	Main.undo_game_field = mas
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
				Main.fill_field_with_numbers()
#				Main.game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			Main.fill_field_with_numbers()
	if Main.gui_node != null && Main.new_game != 0:
		Main.gui_node.reasign_numbers_to_field()
	Main.update_score()

func move_left(mas):
	print("func move_left(mas)")
	Main.randgen.randomize()
	Main.undo_game_field = mas
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
				Main.fill_field_with_numbers()
#				Main.game_over()
			elif sempty <= 4:
				koldop = 1
			else:
				koldop = 2
			Main.fill_field_with_numbers()
	if Main.gui_node != null && Main.new_game != 0:
		Main.gui_node.reasign_numbers_to_field()
	Main.update_score()

func _input(event):
	if (Main.new_game != 0) && (Main.clickInput == true):
		#print("_input(event)", event)
		if(Input.is_action_just_pressed("ui_touch")):
			print("_input(event) - (Input.is_action_just_PREssed(ui_touch))")
			first_touch = (get_global_mouse_position())
		if(Input.is_action_just_released("ui_touch")):
			print("_input(event) - (Input.is_action_just_REleased(ui_touch))")
			final_touch = (get_global_mouse_position())
			calculate_direction()
	elif (Main.new_game != 0) && (Main.clickInput == false):
		if event is InputEventScreenTouch:
			if event.pressed:
			  swipe_start = event.get_position()
			else:
			  _calculate_swipe(event.get_position())

#func _unhandled_input(event):
#	if (Main.new_game != 0) && (Main.clickInput == false):
#		if event is InputEventScreenTouch:
#			if event.pressed:
#			  swipe_start = event.get_position()
#			else:
#			  _calculate_swipe(event.get_position())

func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			move_right(Main.game_field)
		if swipe.x < 0:
			move_left(Main.game_field)
	if abs(swipe.y) > minimum_drag:
		if swipe.y > 0:
			move_down(Main.game_field)
		if swipe.y < 0:
			move_up(Main.game_field)

func calculate_direction():
	var k_scr = (game_window_heigth_y - game_window_width_x)/2
	print("calculate_direction()")
	print("y =", final_touch.y, " x =", final_touch.x)	
	if final_touch.x > final_touch.y-k_scr:		
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			move_up(Main.game_field)
		else:
			move_right(Main.game_field)
	else:
		if final_touch.x + final_touch.y-k_scr < game_window_width_x:
			move_left(Main.game_field)
		else:
			move_down(Main.game_field) 
