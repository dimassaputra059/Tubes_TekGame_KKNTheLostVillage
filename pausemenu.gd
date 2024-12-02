extends Control

var is_scene_switching = false  # Penanda untuk mencegah transisi cepat

func _focus_first_button():
	$Button.grab_focus()  # Atur elemen fokus ke tombol pertama
	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().is_paused():
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().is_paused():
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	if is_scene_switching:
		return  # Hindari penggantian scene ganda
	is_scene_switching = true  # Tandai bahwa scene akan diubah
	$AnimationPlayer.play_backwards("blur")
	get_tree().paused = false
	await_animation_and_change_scene("res://map_lv_1.tscn")

func _on_quit_pressed():
	if is_scene_switching:
		return
	is_scene_switching = true
	$AnimationPlayer.play_backwards("blur")
	await_animation_and_change_scene("res://main_menu.tscn")

func _process(delta):
	testEsc()

# Fungsi untuk menunggu animasi selesai sebelum mengganti scene
func await_animation_and_change_scene(scene_path: String) -> void:
	# Tunggu hingga animasi selesai dimainkan
	await $AnimationPlayer.animation_finished
	is_scene_switching = false  # Reset penanda
	get_tree().change_scene_to_file(scene_path)  # Ganti scene
