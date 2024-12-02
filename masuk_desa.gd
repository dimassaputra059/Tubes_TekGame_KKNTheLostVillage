extends Area2D

var player_is_area = false
var player_interect_batas = true

func _process(delta):
	if player_is_area:
		if Input.is_anything_pressed() and player_interect_batas:
			Dialogic.emit_signal("signal_event", "masuk_ke_desa")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
