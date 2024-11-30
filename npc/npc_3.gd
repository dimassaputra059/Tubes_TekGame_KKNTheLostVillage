extends CharacterBody2D

var player_is_area = false

func _ready():
	$AnimatedSprite2D.play("idle")
	$chatDetection/Label.visible = false

func _process(delta):
	if player_is_area:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("npc3_dialog")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true
		$chatDetection/Label.visible = true


func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
		$chatDetection/Label.visible = false
