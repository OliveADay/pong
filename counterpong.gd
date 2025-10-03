extends RigidBody2D
var timer = 0
var ball:RigidBody2D
var mov:Vector2
var speed = 2
var player:Node2D
var best_score = 0
var scoreFilePath = "user://score.cfg"
var broken_pong_ref= preload("res://broken_c_pong.tscn")
var frame_1_change_happened = false
var frame_2_change_happened = false
var broken_change_happened = false
signal broken

func _ready() -> void:
	player = get_tree().get_first_node_in_group("pong_left")
	loadBscore()
	if best_score >= 15:
		$Sprite2D.frame = 2

func _physics_process(delta: float) -> void:
	if timer == 60:
		position.x = 619
		timer = 0
	else:
		timer+=1
		
	if ball == null:
		ball = get_tree().get_first_node_in_group("ball")
	mov = Vector2(0,ball.position.y-position.y)
	move_and_collide(mov)

func loadBscore():
	var config= ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error != OK:
		best_score = 0
		return
	best_score = config.get_value('main','best_score')
	print(best_score)

func _on_ball_right_col() -> void:
	if (player.hit_amount == 5 and not frame_1_change_happened and not frame_2_change_happened):
		$Sprite2D.frame = 1
		frame_1_change_happened = true
	if (player.hit_amount == 10 and not frame_2_change_happened):
		$Sprite2D.frame = 2
		frame_2_change_happened = true
	if (player.hit_amount == 15 and not broken_change_happened) or (best_score >= 15):
		$AudioStreamPlayer2D.play()
		
func brake():
	broken_change_happened = true
	broken.emit()
	var broken_pong = broken_pong_ref.instantiate()
	add_child(broken_pong)
	broken_pong.reparent(get_tree().root)
	queue_free()
