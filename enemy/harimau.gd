extends CharacterBody2D


const speed = 40
var current_state = IDLE

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var chasing = false
var attacking = false

var player
var player_in_area = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
	
	var timer = Timer.new()
	timer.wait_time = 2.0  # Setiap 2 detik akan terjadi pergantian state
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
	$DetectionArea.body_entered.connect(_on_player_touched)
	$DetectionArea.body_exited.connect(_on_player_exited)

func _process(delta):
	if chasing and player_in_area:
		chase_player(delta)
	elif is_roaming and !player_in_area:
		if current_state == IDLE:
			$AnimatedSprite2D.play("idle")
		elif current_state == MOVE:
			if dir.x == -1:
				$AnimatedSprite2D.play("move")
				$AnimatedSprite2D.flip_h = false
			elif dir.x == 1:
				$AnimatedSprite2D.play("move")
				$AnimatedSprite2D.flip_h = true
			elif dir.y == -1:
				$AnimatedSprite2D.play("move_up")
			elif dir.y == 1:
				$AnimatedSprite2D.play("move_down")
			move(delta)
					
func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if is_roaming and current_state == MOVE:
		position += dir * speed * delta

func chase_player(delta):
	if player:
		# Tentukan arah ke pemain
		var direction_to_player = (player.position - position).normalized()
		position += direction_to_player * speed * delta
		
		# Atur animasi berdasarkan arah
		if direction_to_player.x < 0:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = false
		elif direction_to_player.x > 0:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = true

func _on_timer_timeout():
	if !player_in_area and is_roaming:
		match current_state:
			IDLE:
				current_state = NEW_DIR
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
				current_state = MOVE
			MOVE:
				current_state = IDLE

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true
		player = body
		chasing = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false
		chasing = false

func _on_player_touched(body: Node2D) -> void:
	if body == player:
		attacking = true  # Mulai mode serangan
		$AnimatedSprite2D.play("attack")
		$AnimatedSprite2D.animation_finished.connect(_on_attack_finished)

func _on_player_exited(body: Node2D) -> void:
	if body == player:
		attacking = false

func _on_attack_finished() -> void:
	$AnimatedSprite2D.animation_finished.disconnect(_on_attack_finished)
	attacking = false
