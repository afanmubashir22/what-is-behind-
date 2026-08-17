extends Area3D




func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.has_method("collect_eye"):
			body.collect_eye()
			queue_free()
