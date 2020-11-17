extends Panel


# Declare member variables here.
var sum_delta : float = 0
var paused : bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not paused:
		get_node("delta").set_text("delta: " + str(delta))
		get_node("sum(delta)").text = "sum(delta): \n" + str(sum_delta) # Alternatively
		sum_delta += delta
		get_node("framerate").text = "framerate" + str(Engine.get_frames_per_second())

# It's important to bear in mind that the frequency with which _process() will 
# be called depends on how many frames per second (FPS) your application is 
# running at. This rate can vary over time and devices.
#
# To help manage this variability, the delta parameter contains the time elapsed 
# in seconds as a floating-point number since the previous call to _process().
#
# This parameter can be used to make sure things always take the same amount of 
# time, regardless of the game's FPS.
#
# For example, movement is often multiplied with a time delta to make movement 
# speed both constant and independent of the frame rate.
#
# The function _process(), however, is not synced with physics. Its frame rate 
# is not constant and is dependent on hardware and game optimization. 
# Its execution is done after the physics step on single-threaded games.


func _on_Button_toggled(button_pressed):
	paused = button_pressed
