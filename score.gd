extends Label
var player:Node2D
var scoreFilePath = "user://score.cfg"
var best_score = 0
var timer = 0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("pong_left")
	loadBscore()
func _process(delta: float) -> void:
	text = "score: "+str(player.hit_amount)
	if timer <= 0:
		if player.hit_amount > best_score:
			saveBScore()
			
		timer = 2
	else:
		timer -= delta
	
func saveBScore():
	var config = ConfigFile.new()
	best_score = player.hit_amount
	config.set_value('main','best_score',best_score)
	config.save(scoreFilePath)

func loadBscore():
	var config= ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error != OK:
		best_score = 0
		return
	best_score = config.get_value('main','best_score')
	print(best_score)


func _on_counterpong_broken() -> void:
	$intro.visible = true


func _on_pong_hit_after_broken() -> void:
	$intro.visible = false
