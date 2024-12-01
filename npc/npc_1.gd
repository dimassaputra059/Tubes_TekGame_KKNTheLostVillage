extends CharacterBody2D

var player_is_area = false
var quest_started = false
var item_collected = false
var quest_done = false

func _ready():
	$AnimatedSprite2D.play("idle")
	$chatDetection/Label.visible = false
	Dialogic.signal_event.connect(DialogicSignal)

func _process(delta):
	if player_is_area:
		if Input.is_action_just_pressed("interact"):
			if quest_started:
				if item_collected:  # Jika item sudah diambil
					run_dialogue("npc1_questComplete")
					complete_quest()
				else:
					run_dialogue("npc1_questIncomplete")
			elif quest_done:
				run_dialogue("timelines/npc1_questEnd")
			else:
				run_dialogue("npc1_questStart")
				quest_started = true 

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func DialogicSignal(arg: String):
	if arg == "start_quest":
		print("signal recieved")
	elif arg == "item_collected":
		print("Item berhasil diambil!")
		item_collected = true
	elif arg == "quest_end":
		quest_done = true

func complete_quest():
	quest_started = false
	item_collected = false

func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true
		$chatDetection/Label.visible = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
		$chatDetection/Label.visible = false
