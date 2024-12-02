extends Node2D

var messages = [
	"Budiono akhirnya berhasil keluar dari Desa Misterius",
	"Teman - teman dan warga desa yang mencarinya",
	"Berhasil menemukannya di depan pintu Desa Alur Jambu",
]

var typing_speed = .1
var read_time = 0.5

var current_message = 0
var display = ""
var current_char = 0

func _ready():
	start_dialogue()
	
func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	$next_char.set_wait_time(typing_speed)
	$next_char.start()

func stop_dialogue():
	# get_parent().remove_child(self)
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_next_char_timeout():
	if (current_char < len(messages[current_message])):
		var next_char = messages[current_message][current_char]
		display += next_char
		
		$Label.text = display
		current_char += 1
	else:
		$next_char.stop()
		$next_message.one_shot = true
		$next_message.set_wait_time(read_time)
		$next_message.start()

func _on_next_message_timeout():
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		$next_char.start()
