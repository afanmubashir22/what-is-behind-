extends Area3D
@export var message_label: Control
@export var House: Node3D
func _ready() -> void:
		if message_label:
			message_label.hide()
func _on_body_entered(body: Node3D) -> void:
		if body.name == "Player":
				_collect_key()
func _collect_key() -> void:
		if House:
				House.queue_free()
		if message_label:
				message_label.show()
		if has_node("MeshINstance3D"):
			$MeshInstance3D.hide()
		if has_node("CollisionShape3D"):
			$CollisionShape3D.set_deferred("disabled", true)
		await get_tree().create_timer(2.0).timeout
		if message_label:
			message_label.hide()
		queue_free()
