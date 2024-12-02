extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()  # Menyembunyikan layar Game Over di awal
	print("Game Over screen is ready.")

# Fungsi untuk menangani proses setiap frame
func _process(delta: float) -> void:
	pass


# Fungsi untuk menampilkan layar Game Over
func game_over():
	print("Game Over triggered!")  # Debugging untuk memastikan game over dipanggil
	# Menjeda permainan
	get_tree().paused = true
	self.show()  # Menampilkan layar Game Over


func _on_quit_pressed() -> void:
	print("Quit button pressed!")  # Debugging untuk memastikan tombol quit ditekan
	get_tree().change_scene_to_file("res://main_menu.tscn")
