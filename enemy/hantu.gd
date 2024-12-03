extends CharacterBody2D

const INITIAL_SPEED = 65
const MIN_SPEED = 45
var current_state = IDLE

var dir = Vector2.RIGHT
var start_pos
var speed = INITIAL_SPEED  # Kecepatan yang akan dikurangi

var is_roaming = true
var chasing = false

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
	
	# Timer untuk perubahan status (IDLE, MOVE, NEW_DIR)
	var timer = Timer.new()
	timer.wait_time = 2.0  # Setiap 2 detik akan terjadi pergantian state
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
	# Hubungkan sinyal area deteksi untuk memeriksa keberadaan pemain
	$DetectionArea.body_entered.connect(_on_detection_area_body_entered)
	$DetectionArea.body_exited.connect(_on_detection_area_body_exited)

func _process(delta):
	if chasing and player_in_area:
		chase_player(delta)  # Hantu mengejar pemain
	elif is_roaming and !player_in_area:
		# Animasi dan logika pergerakan saat roaming
		if current_state == IDLE:
			$AnimatedSprite2D.play("idle")
		elif current_state == MOVE:
			$AnimatedSprite2D.play("move")
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
		
		# Atur animasi berdasarkan arah gerakan
		$AnimatedSprite2D.play("run")

		# Mengurangi kecepatan hantu saat mengejar
		if speed > MIN_SPEED:
			speed -= 5 * delta  # Mengurangi kecepatan seiring waktu
		else:
			speed = MIN_SPEED  # Pastikan kecepatan tidak kurang dari 40

		# Deteksi jika hantu menyentuh pemain
		if position.distance_to(player.position) < 10:  # Jarak tertentu dianggap "tersentuh"
			game_over()

func game_over():
	print("Game Over triggered!")  # Debugging untuk memastikan game over dipanggil

	# Cek apakah node GameOver ada
	if has_node("/root/map_lv_3/GameOver/GameOver"):  # Pastikan path ke node GameOver benar
		print("Node GameOver ditemukan!")  # Debugging untuk memastikan node ditemukan
		var game_over_node = get_node("/root/map_lv_3/GameOver/GameOver")  # Mengakses node GameOver
		if game_over_node.has_method("game_over"):
			game_over_node.game_over()  # Memanggil metode game_over() pada node GameOver
		else:
			print("Node GameOver tidak memiliki metode game_over!")
	else:
		print("Node GameOver tidak ditemukan!")

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
	if body == player:
		player_in_area = false
		chasing = false
