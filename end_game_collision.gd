extends Area2D

@onready var game_over_ui = $"GameOver/GameOver"  # Sesuaikan path dengan node layar Game Over

# Fungsi untuk menangani peristiwa ketika body masuk ke dalam area
func _on_body_entered(body: Node) -> void:
	# Periksa apakah body adalah pemain
	if body.is_in_group("player"):  # Pastikan objek ini adalah pemain
		print("Game Over! Player entered the area.")  # Debugging output
		game_over()

# Fungsi untuk mengakhiri permainan dan menampilkan Game Over
func game_over() -> void:
	print("End Game triggered!")  # Debugging output
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://typing/Dialogue_end.tscn")
