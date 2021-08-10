extends KinematicBody2D

const FLAP_FORCE = 200
const GRAVITY = 10
const MAX_FALL_SPEED = 200
var velocity = Vector2()


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func _physics_process(delta):
	manage_gravity()
	manage_flap()
	move_and_slide(velocity, Vector2.UP)

func manage_gravity():
	velocity.y += GRAVITY
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED

func manage_flap():
	if Input.is_action_just_pressed("flap"):
		velocity.y = -FLAP_FORCE
		flap()

func flap():
	$AnimationPlayer.play("flap")
	yield( $AnimationPlayer, "animation_finished" )

