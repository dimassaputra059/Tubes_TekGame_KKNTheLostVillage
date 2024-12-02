extends Node2D

@export var date_time: DateTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var date_time = $TimeSystem.date_time  # Ambil instance DateTime
	if date_time:
		date_time.connect("time_expired", Callable($GameOver/GameOver, "game_over"))
		print("Signal connected successfully!")
	else:
		print("Error: No DateTime resource found in Time_GUI")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
