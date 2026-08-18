extends CanvasLayer
@onready var win_screen: Control = $WinScreen
func _ready() -> void:
	if win_screen:
			win_screen.hide()
func show_win_screen() -> void:
		if win_screen:
				win_screen.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
