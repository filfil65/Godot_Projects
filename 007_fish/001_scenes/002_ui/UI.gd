extends CanvasLayer

signal start_game

var skeletons_displayed: int = 0
var skeletons = []

func _ready():
	skeletons = [$Skeleton1, $Skeleton2, $Skeleton3, $Skeleton4, $Skeleton5, $Skeleton6, $Skeleton7, $Skeleton8, $Skeleton9, $Skeleton10, $Skeleton11, $Skeleton12, $Skeleton13]


func show_ui():
	$Title.show()
	$StartButton.show()


func _hide_ui():
	$Title.hide()
	$StartButton.hide()
	get_tree().call_group("Skeletons", "hide")
	skeletons_displayed = 0


func update_score(score: int):
	$Score.text = str(score)


func _on_StartButton_pressed():
	_hide_ui()
	update_score(0)
	emit_signal("start_game")


func _on_Player_display_skeletons():
	if skeletons_displayed < len(skeletons):
		skeletons[skeletons_displayed].show()
		skeletons_displayed += 1
