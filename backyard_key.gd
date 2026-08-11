extends Area3D
func _ready() -> void:
		monitoring = true
		body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node3D) -> void:
		if body is StaticBody3D:
				return
		print("KEY TOUCHED BY: ", body.name)
		var door = get_node_or_null("/root/House/BackyardDoor")
		if door:
				door.queue_free()
		else:
			door = get_node_or_null("/root/House/BackyardDoor")
			if door:
					door.queue_free()
		var task_label = get_node_or_null("/root/house/CanvasLayer/Label")
		if not task_label:
				task_label = get_node_or_null("/root/House/CanvasLayer/Label")
		if task_label:
			task_label.text = "Objective: Go to the Backyard"
		var msg_label = get_node_or_null("/root/house/CanvasLayer/MessageLabel")
		if not msg_label:
				msg_label = get_node_or_null("/root/House/CanvasLayer/MessageLabel")
		if msg_label:
				msg_label.text = "BACKYARD DOOR UNLOCKED!"
				await get_tree().create_timer(2.5).timeout
				msg_label.text = ""
		queue_free()
				
