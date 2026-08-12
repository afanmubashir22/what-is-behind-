extends Area3D
@export var objective_label: Label
@export var House: Node3D
func _on_body_entered(body: Node3D) -> void:
		_collect_key()
func _collect_key() -> void:
		if objective_label:
				objective_label.text = "Objective: Backyard door unlocked"
		if House:
					House.queue_free()
		hide()
		$CollisionShape3D.set_deferred("disabled", true)
		await get_tree().create_timer(3.0).timeout
		queue_free()
		
