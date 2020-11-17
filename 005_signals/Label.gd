extends Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_text("Signal received, timer started: \n" + str($Timer.get_time_left()))


func _on_CustomSignals_my_custom_signal():
	# This is fired only at the beginning, on '_ready'
	$Timer.start()
