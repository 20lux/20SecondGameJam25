extends CharacterBody3D

@onready var camera_3D = $Camera3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const CAMERA_SENS = 0.003

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event.is_action_pressed("quit"): get_tree().quit()

	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * CAMERA_SENS
		rotation.x -= event.relative.y * CAMERA_SENS

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
