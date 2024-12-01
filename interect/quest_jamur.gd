extends Area2D

var player_is_area = false

func _ready():
	$Label.visible = false
	$".".visible = false
	Dialogic.signal_event.connect(DialogicSignal)

func _process(delta):
	if player_is_area:
		if Input.is_action_just_pressed("interact") and $".".visible == true:
			Dialogic.emit_signal("signal_event", "item_collected")  # Kirim sinyal bahwa item diambil
			queue_free()

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func DialogicSignal(arg: String):
	if arg == "start_quest":
		$".".visible = true

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true
		$Label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
		$Label.visible = false
