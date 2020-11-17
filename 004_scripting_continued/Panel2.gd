extends Panel


# Declare member variables here.
var sum_delta : float = 0
var paused : bool = false

func _physics_process(delta):
	if not paused:
		get_node("delta").set_text("delta: " + str(delta))
		get_node("sum(delta)").text = "sum(delta): \n" + str(sum_delta) # Alternatively
		sum_delta += delta
		get_node("framerate").text = "framerate" + str(Engine.get_frames_per_second())


func _on_Button_toggled(button_pressed):
	paused = button_pressed

# Physics processing (like collisions) with _physics_process() is similar, but it should be used 
# for processes that must happen before each physics step, such as controlling 
# a character. It always runs before a physics step and it is called at fixed 
# time intervals: 60 times per second by default. You can change the interval 
# from the Project Settings, under Physics -> Common -> Physics Fps.
