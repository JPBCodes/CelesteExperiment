extends "state.gd"


@onready var CoyoteTimer = $CoyoteTime
@export var coyote_duration = 0.2

var can_jump = true

func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.is_on_floor():
		return STATES.IDLE

	if Player.dash_input and Player.can_dash:
		return STATES.DASH

	if Player.get_next_to_wall() != null:
		return STATES.WALLSLIDE

	if Player.jump_input_actuation and can_jump:
		return STATES.JUMP

	return null

func enter_state():
	if Player.previous_state == STATES.MOVE or Player.previous_state == STATES.WALLSLIDE:
		can_jump = true
		CoyoteTimer.start(coyote_duration)
	else:
		can_jump = false


func _on_coyote_time_timeout():
	can_jump = false
