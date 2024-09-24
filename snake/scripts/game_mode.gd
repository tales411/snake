extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"options/speed/speed option".position.y = 52
	$"options/fruits/fruits option".position.y = 49

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_pressed()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
	
	
	

func _on_speed_1_pressed() -> void:
	Global.move_speed_timer = 0.2
	$"options/speed/speed option".position.x = -36


func _on_speed_2_pressed() -> void:
	Global.move_speed_timer = 0.13
	$"options/speed/speed option".position.x = 34


func _on_speed_3_pressed() -> void:
	Global.move_speed_timer = 0.35
	$"options/speed/speed option".position.x = 104
	

func _on_confirm_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_fruit_1_pressed() -> void:
	$"options/fruits/fruits option".position.x = -39


func _on_fruit_2_pressed() -> void:
	$"options/fruits/fruits option".position.x = 31


func _on_fruit_3_pressed() -> void:
	$"options/fruits/fruits option".position.x = 101
