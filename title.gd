extends Node2D
var main_game_ref= preload("res://world.tscn")
var scoreFilePath = "user://score.cfg"
var high_score = 0

func _ready() -> void:
	loadBscore()
	if high_score != 0:
		$CanvasLayer/highscore.text = "highscore: "+str(high_score)
	else:
		$CanvasLayer/highscore.text = "no highscore"

func loadBscore():
	var config= ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error != OK:
		high_score = 0
		return
	high_score = config.get_value('main','best_score')
	print(high_score)

func _on_button_pressed() -> void:
	$CanvasLayer/AudioStreamPlayer2D.play()
	var main_game =main_game_ref.instantiate()
	$CanvasLayer.visible = false
	add_child(main_game)
