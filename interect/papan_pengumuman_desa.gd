extends Area2D

var player_is_area = false

func _ready():
	$Label.visible = false

func _process(delta):
	if player_is_area:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("papan_pengumuman_desa")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true
		$Label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
		$Label.visible = false
