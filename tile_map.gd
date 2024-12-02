extends TileMap

# Called when the node enters the scene tree for the first time.
var player_in_gerobak = false
var player_in_pohon = false
var player_in_jamur = false
var player_in_batas = false

var player_interact_batas = true

func _ready():
	$"../Gerobak/Label".visible = false
	$"../Pohon raksasa/Label".visible = false

func _process(delta):
	if player_in_gerobak:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("gerobak")
	if player_in_pohon:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("pohon")
	if player_in_jamur:
		if Input.is_action_just_pressed("interact"):
			run_dialogue("jamur")
	if player_in_batas:
		if Input.is_anything_pressed() and player_interact_batas:
			run_dialogue("batas_lvl_2")
			player_interact_batas = false
			Dialogic.emit_signal("signal_event", "masuk_ke_hutan")

func run_dialogue(dialogue_string):
	Dialogic.timeline_ended.connect(ended)
	Dialogic.start(dialogue_string)
	
func ended():
	Dialogic.timeline_ended.disconnect(ended)


func _on_gerobak_body_entered(body):
	if body.has_method("player"):
		player_in_gerobak = true
		$"../Gerobak/Label".visible = true

func _on_gerobak_body_exited(body):
	if body.has_method("player"):
		player_in_gerobak = false
		$"../Gerobak/Label".visible = false


func _on_pohon_raksasa_body_entered(body):
	if body.has_method("player"):
		player_in_pohon = true
		$"../Pohon raksasa/Label".visible = true


func _on_pohon_raksasa_body_exited(body):
	if body.has_method("player"):
		player_in_pohon = false
		$"../Pohon raksasa/Label".visible = false


func _on_jamur_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_jamur = true

func _on_jamur_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_jamur = false


func _on_batas_lvl_2_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_batas = true


func _on_batas_lvl_2_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_batas = false
