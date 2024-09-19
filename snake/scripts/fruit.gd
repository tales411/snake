extends Area2D


func _on_body_entered(body) -> void:
	if body.name == "player":
		queue_free()
