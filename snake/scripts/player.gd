extends CharacterBody2D


@export var move_speed_timer = 0.2 # velocidade da cobra
var grid_size = 32 # Tamanho do grid 


var direction = Vector2.RIGHT # direção inicial (começa indo para a direita)


var move_timer: Timer # timer para controlar o intervalo de movimentação

func _ready():
	move_timer = $Timer
	move_timer.wait_time = move_speed_timer  
	

func _process(delta):
	if Input.is_action_just_pressed("ui_up") and direction != Vector2.DOWN:
		direction = Vector2.UP
	elif Input.is_action_just_pressed("ui_down") and direction != Vector2.UP:
		direction = Vector2.DOWN
	elif Input.is_action_just_pressed("ui_left") and direction != Vector2.RIGHT:
		direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right") and direction != Vector2.LEFT:
		direction = Vector2.RIGHT
		move_timer.start() # começa o movimento



func _on_timer_timeout() -> void:
	position += direction * grid_size # atualiza a posição da cobra
