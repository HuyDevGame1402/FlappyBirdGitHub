extends Area2D

var speed = 100

func _process(delta: float) -> void:
	if get_parent().state:
		var movement = Vector2(-speed * delta,0)
		position += movement

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.

func _on_body_entered(body):
	body.state = false
	get_parent().state = false
	pass # Replace with function body.
