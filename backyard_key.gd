extends Area3D
var player_near: bool = false
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node3D) -> void:
		if body.is_in_group("player") or body.name == "Player":
				player_near = true
func _on_body_exited(body: Node3D) -> void:
		if body.is_in_group("player") or body.name == "Player":
				player_near = false
func _unhandled_input(event: InputEvent) -> void:
		if player_near and (event.is_action_pressed("ui_accept") or (event is InputEventKey and event.pressed and event.keycode == KEY_E)):
				pick_up_key()
func pick_up_key() -> void:
		var door = get_node_or_null("/root/House/BackyardDoor")
		if door:
				door.st_meta("is_unlocked", true)
		var task_label = get_node_or_null("/root/House/CanvasLayer/Label")
		if task_label:
				task_label.text = "Backyard Door Unlocked!"
				await get_tree().create_timer(1.5).timeout
				task_label.text = "Objective: Go to the backyard"
				queue_free()
				
