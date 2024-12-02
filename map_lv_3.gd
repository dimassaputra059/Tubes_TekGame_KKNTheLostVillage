extends Node2D

@export var date_time: DateTime
var player_is_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PapanDesa/NinePatchRect.visible = false
	var date_time = $TimeSystem.date_time  # Ambil instance DateTime
	if date_time:
		date_time.connect("time_expired", Callable($GameOver/GameOver, "game_over"))
		print("Signal connected successfully!")
	else:
		print("Error: No DateTime resource found in Time_GUI")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_is_area:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("desa_alur_jambu")

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true
		$PapanDesa/NinePatchRect.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_is_area = true
		$PapanDesa/NinePatchRect.visible = false
