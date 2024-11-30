extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var player_is_area = false
var quest_started = false 

func _ready():
	$AnimatedSprite2D.play("idle")
	Dialogic.signal_event.connect(DialogicSignal)

func _process(delta):
	if player_is_area:
		if Input.is_action_just_pressed("interact"):
			if quest_started:
				run_dialogue("npc1_questEnd")
			else:
				run_dialogue("npc1_questStart")
				quest_started = true 

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func DialogicSignal(arg: String):
	if arg == "start_quest":
		print("signal recieved")

func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
