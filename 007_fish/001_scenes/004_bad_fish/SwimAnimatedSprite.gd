extends AnimatedSprite

func _process(delta):
	if frame == 0:
		play("swim", false)
	elif frame == frames.get_frame_count("swim") - 1:  # 0-indexed
		play("swim", true)
