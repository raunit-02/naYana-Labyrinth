extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera
var anim_player
var character

const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5

func _ready():
	anim_player = get_node("AnimationPlayer")
	character = get_node(".")

func _physics_process(delta):
	
	camera = get_node("Target/ClippedCamera").get_global_transform()
	var dir = Vector3()
	
	var is_moving = false

	if(Input.is_action_pressed("move_fw")):
		dir += -camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("move_bw")):
		dir += camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("move_l")):
		dir += -camera.basis[0]
		is_moving = true
	if(Input.is_action_pressed("move_r")):
		dir += camera.basis[0]
		is_moving = true
		
	dir.y = 0
	dir = dir.normalized()
	
	velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	
	var new_pos = dir * SPEED
	var accel = DE_ACCELERATION
	
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
		
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
			
	velocity = move_and_slide(velocity, Vector3(0,1,0))	
	
	var anim_to_play = 'idle'
	
	if is_moving:
		
		# Rotate the player to direction
		var angle = atan2(hv.x, hv.z)
		
		var char_rot = character.get_rotation()
		
		char_rot.y = angle
		character.set_rotation(char_rot)
	
	var speed = hv.length() / SPEED
	
	anim_to_play = 'run-loop'
	var current_animation = anim_player.get_current_animation() 
	if current_animation != anim_to_play:
		anim_player.play(anim_to_play)
