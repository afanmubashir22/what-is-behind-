extends Area3D
@export var message_label: Label
@export var House: Node3D
func _ready() -> void:
	if message_label:
		message_label.hide()
func _on_body_entered(body: Node3D) -> void:
	if body.name =="Player":
		_collect_key()
func _collect_key() -> void:
	if House:
		House.queue_free()
	if message_label:
			message_label.text = "backyard door unocked!"
			message_label.show()
	visible = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	await get_tree().create_timer(2.0)
	if message_label:
		message_label.hide()
		queue_free()
