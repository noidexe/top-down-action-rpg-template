extends KinematicBody2D

class_name Enemy

export(int) var WALK_SPEED = 350
export(int) var ROLL_SPEED = 1000

var linear_vel = Vector2()
export(String, "up", "down", "left", "right") var facing = "down"

var anim = ""
var new_anim = ""

enum { STATE_IDLE, STATE_WALKING, STATE_ATTACK, STATE_ROLL }

var state = STATE_IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
#	var spawnpoints = get_tree().get_nodes_in_group("spawnpoints")
#	for spawnpoint in spawnpoints:
#		if spawnpoint.name == Globals.spawnpoint:
#			global_position = spawnpoint.global_position
#	pass # Replace with function body.

func _physics_process(_delta):
	
	match state:
		STATE_IDLE:
			new_anim = "idle_" + facing
		STATE_WALKING:
			linear_vel = move_and_slide(linear_vel)
			
			var target_speed = Vector2()
			
			if facing == "down":
				target_speed += Vector2.DOWN
			if facing == "left":
				target_speed += Vector2.LEFT
			if facing == "right":
				target_speed += Vector2.RIGHT
			if facing == "up":
				target_speed += Vector2.UP
			
			target_speed *= WALK_SPEED
			linear_vel = linear_vel.linear_interpolate(target_speed, 0.9)
			
			new_anim = ""
			if abs(linear_vel.x) > abs(linear_vel.y):
				if linear_vel.x < 0:
					facing = "left"
				if linear_vel.x > 0:
					facing = "right"
			if abs(linear_vel.y) > abs(linear_vel.x):
				if linear_vel.y < 0:
					facing = "up"
				if linear_vel.y > 0:
					facing = "down"
			
			if linear_vel != Vector2.ZERO:
				new_anim = "walk_" + facing
			else:
				state = STATE_IDLE
			pass
		STATE_ATTACK:
			new_anim = "slash_" + facing
			pass
		STATE_ROLL:
			linear_vel = move_and_slide(linear_vel)
			var target_speed = Vector2()
			if facing == "up":
				target_speed.y = -1
			if facing == "down":
				target_speed.y = 1
			if facing == "left":
				target_speed.x = -1
			if facing == "right":
				target_speed.x = 1
			target_speed *= ROLL_SPEED
			linear_vel = linear_vel.linear_interpolate(target_speed, 0.9)
			new_anim = "roll"
			pass
	


	if new_anim != anim:
		anim = new_anim
		$anims.play(anim)
	pass


func goto_idle():
	state = STATE_IDLE

func _on_state_changer_timeout():
	$state_changer.wait_time = rand_range(1.0, 5.0)
	state = randi() %3
	facing = ["left", "right", "up", "down"][randi()%3]
	pass # Replace with function body.


func _on_hurtbox_area_entered(area):
	if area.name == "player_sword":
		queue_free()
	pass # Replace with function body.

