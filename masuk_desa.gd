extends Area2D

var player_is_area = false
var player_interact_batas = true

func run_dialogue(dialogue_string):
	Dialogic.timeline_ended.connect(ended)
	Dialogic.start(dialogue_string)
	
func ended():
	Dialogic.timeline_ended.disconnect(ended)
func _process(delta):
	if player_is_area:
		if Input.is_anything_pressed() and player_interact_batas:
			run_dialogue("welcomelvl2")
			player_interact_batas = false
			Dialogic.emit_signal("signal_event", "masuk_ke_desa")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
