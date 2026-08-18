extends Area3D

func _on_body_entered(body):
	if body.is_in_group("player"):
		
		if body.eyes_collected>=3:
			print("Domain Expansion... Game Over! (You Win!)")
			get_tree().quit()
		else:
			print("The shrine demands more. You only have: ", body.eyes_collected)
