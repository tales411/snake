extends Area2D


func _on_body_entered(body) -> void:
	if body.name == "player":
		Global.fruit_entered = true
		queue_free()
