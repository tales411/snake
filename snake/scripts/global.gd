extends Node

var move_speed_timer = 0.2 # velocidade da cobra

var grid_size = 32 # Tamanho do grid 
var direction = Vector2.RIGHT # direção inicial (começa indo para a direita)
var fruit_entered: bool = false

var snake_body: Array = [] # lista do corpo da cobra
var initial_length = 5 # tamanho inicial da cobra

var record = 0



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
