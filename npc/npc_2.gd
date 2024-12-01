extends CharacterBody2D

var player_is_area = false
var dialog_done = false

func _ready():
	$AnimatedSprite2D.play("idle")
	$chatDetection/Label.visible = false
	$".".visible = false
	Dialogic.signal_event.connect(DialogicSignal)

func _process(delta):
	if player_is_area:
		if Input.is_action_just_pressed("interact") and $".".visible == true:
			if dialog_done:
				run_dialogue("npc2_dialogDone")
			else:
				run_dialogue("npc2_dialog")
				Dialogic.emit_signal("signal_event", "open_mapLvl3")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func DialogicSignal(arg: String):
	if arg == "kakek_di_danau":
		$".".visible = true
	elif arg == "npc2_dialogEnd":
		dialog_done = true

func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true
		$chatDetection/Label.visible = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
		$chatDetection/Label.visible = false
