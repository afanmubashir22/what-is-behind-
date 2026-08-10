extends StaticBody3D
var player_near: bool =false
func _ready() -> void:
		set_meta("is_unlocked", false)
func _unhandled_input(event: InputEvent) -> void:
		if player_near and (event.is_action_pressed("ui_accept")or(event is InputEventKey and event.pressed and event.keycode == KEY_E)):
				try_open_door()
func try_open_door() -> void:
		if get_meta("is_unlocked") == true:
				queue_free()
		else:
			var task_label = get_node_or_null("/root/House/CanvasLayer/Label")
			if task_label:
					task_label.text = "Door is locked! Find the key."
func _on_door_area_body_entered(body: Node3D) -> void:
		if body.is_in_group("player") or body.name == "Player":
				player_near = true
func _on_door_area_body_exited(body: Node3D) -> void:
		if body.is_in_group("player") or body.name == "Player":
			player_near = false
