extends CharacterBody2D

const RUN_SPEED = 220
const GRAVITY = 600
const JUMP_SPEED = -400
var jumping = false
var touched_times = 0

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
  velocity.x = 0

  var right = Input.is_action_pressed('p2_right')
  var left = Input.is_action_pressed('p2_left')
  var jump = Input.is_action_just_pressed("p2_up")

  if right:
    velocity.x = RUN_SPEED
    $Sprite2D.flip_h = false
    if !jumping:
      animationState.travel("RunRight")

  if left:
    velocity.x = -RUN_SPEED
    $Sprite2D.flip_h = true
    if !jumping:
      animationState.travel("RunLeft")

  if !right && !left && !jumping:
    animationState.travel("Idle")

  velocity.y += GRAVITY * delta;

  if jump and is_on_floor():
    jumping = true
    velocity.y = JUMP_SPEED
    animationState.travel("JumpStart")
    $JumpSound.play()

  set_velocity(velocity)
  set_up_direction(Vector2.UP)
  set_floor_stop_on_slope_enabled(false)
  set_max_slides(4)
  set_floor_max_angle(PI/4)
  # TODOConverter3To4 infinite_inertia were removed in Godot 4 - previous value `false`
  move_and_slide()
  velocity = velocity

  if jumping and is_on_floor():
    jumping = false
    animationState.travel("JumpEnd")

func ball_touched(_ball):
  get_node("/root/World").reset_player_touched()
  touched_times += 1
  print("Enemy: ", touched_times)
  if (touched_times > 3):
    get_node("/root/World").point_to_player()


func reset_touched():
  touched_times = 0

func _on_StaticBody_body_entered(body):
  if body.is_in_group("ball"):
    body.set_gravity()
