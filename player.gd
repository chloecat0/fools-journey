extends CharacterBody2D

const SPEED = 300.0
const DASH_SPEED = 1000.0
const JUMP_VELOCITY = -400.0

var speed_multiplier: float = 1.0
var jump_multiplier : float = 1.0
var double_jumped : bool = false

@export var weapon1 : Node2D = preload("res://sword.tscn").instantiate()
@export var weapon2 : Node2D = preload("res://sword.tscn").instantiate()

func _ready() -> void:
	add_child(weapon1)
	add_child(weapon2)

func _physics_process(delta: float) -> void:
	weapon1.look_at(get_global_mouse_position())
	weapon2.look_at(-get_global_mouse_position())
	if Input.is_action_just_pressed("attack1"):
		weapon1.rotate(PI/4)
	if Input.is_action_just_pressed("attack2"):
		weapon2.rotate(PI/4)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or not double_jumped):
		velocity.y = JUMP_VELOCITY*jump_multiplier
		double_jumped = true
	
	if is_on_floor():
		double_jumped = false
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	var dashed := Input.is_action_just_pressed("dash")
	if direction:
		velocity.x = direction * (SPEED + (DASH_SPEED if dashed else 0)) * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED*speed_multiplier)
	move_and_slide()
	
