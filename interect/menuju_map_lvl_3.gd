extends Area2D

var player_is_area = false

func _ready():
	$Label.visible = false
	$".".visible = false
	Dialogic.signal_event.connect(DialogicSignal)

func _process(delta):
	if player_is_area:
		if Input.is_action_just_pressed("interact") and $".".visible == true:
			run_dialogue("masuk_ke_mapLvl3")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	
func DialogicSignal(arg: String):
	if arg == "next_mapLvl3":
		change_scene()
	elif arg == "open_mapLvl3":
		$".".visible = true
		
func change_scene():
	get_tree().change_scene_to_file("res://map_lv_3.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true
		$Label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = false
		$Label.visible = false
