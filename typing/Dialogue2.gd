extends Node2D
@onready var transition = $Transition
var messages = [
	"Budiono, segera pergi ke hutan Timur",
	"Dia harus segera menemukan jalan utama Desa Alur Jambu",
	"Sebelum Lentera mati dan berakhir tersesat di hutan selamanya"
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
	transition.play("fade_out")
	
func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://map_lv_3.tscn")
	
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
