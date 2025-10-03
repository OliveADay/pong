extends CharacterBody2D
var vert
@export var speed = 300
var hit_amount = 0
var timer = 0
var default_x = 21
var best_score = 0
var scoreFilePath = "user://score.cfg"
signal hit_after_broken
var has_been_hit_after_broken = false
signal right_hit_after_broken

func _ready() -> void:
	loadBscore()
	if best_score >= 30:
		$Sprite2D.frame = 7

func _physics_process(delta: float) -> void:
	vert = Input.get_axis("down","up");
	if hit_amount == 30:
		$Sprite2D.frame = 7
	if hit_amount >= 15 or best_score >= 15:
		if Input.is_action_just_pressed("right"):
			default_x = 619
			position.x = 619
		if Input.is_action_just_pressed("left"):
			default_x = 21
			position.x = 21
	velocity = Vector2(velocity.x,speed*-vert)
	move_and_slide()
	if timer == 60:
		position.x = default_x
		timer = 0
	else:
		timer+=1

func loadBscore():
	var config= ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error != OK:
		best_score = 0
		return
	best_score = config.get_value('main','best_score')
	print(best_score)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if hit_amount >= 15 or best_score >= 15 and not has_been_hit_after_broken:
		hit_after_broken.emit()
		has_been_hit_after_broken = true
	elif has_been_hit_after_broken:
		right_hit_after_broken.emit()
	hit_amount +=1
		
