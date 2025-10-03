extends RigidBody2D
var ballRes = preload("res://ball.tscn")
var coll = false
var speed = 10
var player:Node2D
signal left_col
signal right_col

func _ready() -> void:
	player = get_tree().get_first_node_in_group("pong_left")

func _on_area_2d_body_entered(body: Node2D) -> void:
	player.hit_amount = 0
	var ball_2 = ballRes.instantiate()
	get_tree().root.add_child(ball_2)
	ball_2.position = Vector2(304,145)
	queue_free()


func _on_left_col_body_entered(body: Node2D) -> void:
	set_linear_velocity(Vector2(-(body.position.x-position.x)*speed,-(body.position.y-position.y)*speed*2))
	left_col.emit()


func _on_right_col_body_entered(body: Node2D) -> void:
	set_linear_velocity(Vector2(-(body.position.x-position.x)*speed,-(body.position.y-position.y)*speed*2))
	right_col.emit()
