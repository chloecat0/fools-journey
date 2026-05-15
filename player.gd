extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var weapon : Node2D = preload("res://sword.tscn").instantiate()

func _ready() -> void:
	add_child(weapon)

func _physics_process(delta: float) -> void:
	weapon.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("attack"):
		weapon.rotate(PI/4)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
