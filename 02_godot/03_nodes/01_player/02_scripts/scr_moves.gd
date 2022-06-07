extends KinematicBody2D

# VARIABLES
const GRAVITY = 40
const SPEED = 500
const JUMP_FORCE = -850
const FLOOR = Vector2(0, -1)
const AIR_ACC = 20 # Air acceleration
const FLOOR_ACC = 50 # Floor acceleration
const DECC = 0.2 # Deceleration 

var velocity = Vector2()
var is_on_ground = false
#

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Name: _physic_process
# Description: Called during the physics processing step of the main loop
#
# Args:
# - delta (float): Time since the previous frame
func _physics_process(_delta):
	is_on_ground = is_on_floor()
	apply_forces()
#

# Name: apply_force
# Description: Apply forces to the player
func apply_forces():
	var acc = FLOOR_ACC if is_on_ground else AIR_ACC
	
	if Input.is_action_pressed("right"):
		velocity.x = min(velocity.x + acc, SPEED)
	elif Input.is_action_pressed("left"):
		velocity.x = max(velocity.x - acc, -SPEED)
	else:
		velocity.x = lerp(velocity.x, 0, DECC)
	
	if Input.is_action_just_pressed("jump") and is_on_ground:
		velocity.y = JUMP_FORCE
	
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
#
