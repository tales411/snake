extends CharacterBody2D


var move_timer: Timer # timer para controlar o intervalo de movimentação
var direction_queue: Array = [] # armazena os inputs de direção

func _ready():
	move_timer = $"../Timer"
	move_timer.wait_time = Global.move_speed_timer  
	
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		direction_queue.append(Vector2.UP)
	elif Input.is_action_just_pressed("ui_down"):
		direction_queue.append(Vector2.DOWN)
	elif Input.is_action_just_pressed("ui_left"):
		direction_queue.append(Vector2.LEFT)
	elif Input.is_action_just_pressed("ui_right"):
		direction_queue.append(Vector2.RIGHT)
		if move_timer.is_stopped():
			move_timer.start() # começa o movimento



func _on_timer_timeout() -> void:
	var new_direction
	# atualiza a direção usando o proximo comando da fila
	if direction_queue.size() > 0:
		new_direction = direction_queue.pop_front()
		if new_direction != -Global.direction and Global.direction:
			Global.direction = new_direction
		
	position += Global.direction * Global.grid_size # atualiza a posição da cobra


func _on_wall_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/home_menu.tscn")
	
