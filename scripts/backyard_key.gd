extends Area3D
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") or body.name == "PLAYER":
		var door = get_node_or_null("/root/House/BackyardDoor")
		if door:
				door.queue_free()
		var task_label = get_node_or_null("/root/House/CanvasLayer/Label")
		if task_label:
				task_label.text = "Objective: FIND THE EYES AND GO TO BACKYARD!"
				queue_free()
				
