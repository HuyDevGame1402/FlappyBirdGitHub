extends CharacterBody2D

const JUMP_VELOCITY = -300.0

var state : bool = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if state:
		if not is_on_floor():
			velocity.y += gravity * 0.8 * delta
		# Handle jump.
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_VELOCITY
		move_and_slide()
