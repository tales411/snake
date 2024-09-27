extends Node2D



func _ready() -> void:
	$"options/speed/speed option".position.y = 52
	$"options/fruits/fruits option".position.y = 49
	$"options/fruits/fruits option".position.x = -39
	$options/modes/mode.position.y = 53
	$options/modes/mode.position.x = 42

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_pressed()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
	
	
	

func _on_speed_1_pressed() -> void:
	Global.move_speed_option = 1
	$"options/speed/speed option".position.x = -36


func _on_speed_2_pressed() -> void:
	Global.move_speed_option = 2
	$"options/speed/speed option".position.x = 34


func _on_speed_3_pressed() -> void:
	Global.move_speed_option = 3
	$"options/speed/speed option".position.x = 104
	

func _on_confirm_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_fruit_1_pressed() -> void:
	Global.fruit_number = 5
	$"options/fruits/fruits option".position.x = -39


func _on_fruit_2_pressed() -> void:
	Global.fruit_number = 3
	$"options/fruits/fruits option".position.x = 31


func _on_fruit_3_pressed() -> void:
	Global.fruit_number = 9
	$"options/fruits/fruits option".position.x = 101


func _on_mode_1_pressed() -> void:
	$options/modes/mode.position.x = 42
	Global.game_mode = 1


func _on_mode_2_pressed() -> void:
	$options/modes/mode.position.x = 112
	Global.game_mode = 2


func _on_mode_3_pressed() -> void:
	$options/modes/mode.position.x = 182
	Global.game_mode = 3
