extends Node2D

func _on_Timer_timeout():
	# Note: the `$` operator is a shorthand for `get_node()`,
	# so `$Sprite` is equivalent to `get_node("Sprite")`.
	$Sprite.visible = !$Sprite.visible
	# This will cause the timer to blink on and off every second. 
	# This is because the timers are set to restart themselves, unless 
	# you tick their 'oneshot' property.
