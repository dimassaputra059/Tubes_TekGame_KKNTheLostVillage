extends CharacterBody2D

@export var speed = 50
@onready var animations = $AnimationPlayer	

func handleInput():
	var moreDirection = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = moreDirection*speed
	
func updateAnimation():
	var direction = "Idle"
	if velocity.x < 0: direction = "Left"
	elif velocity.x > 0: direction = "Right"
	elif velocity.y < 0: direction = "Up"
	elif velocity.y > 0: direction = "Down"
	
	animations.play("walk" + direction)
	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
