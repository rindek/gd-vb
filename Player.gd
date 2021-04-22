extends KinematicBody2D

const RUN_SPEED = 220
var velocity = Vector2.ZERO
const GRAVITY = 600
const JUMP_SPEED = -400
var jumping = false

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
  velocity.x = 0
    
  var right = Input.is_action_pressed('ui_right')
  var left = Input.is_action_pressed('ui_left')
  var jump = Input.is_action_just_pressed("ui_up")
    
  if right:
    velocity.x = RUN_SPEED
    $Sprite.flip_h = false
    if !jumping:
      animationState.travel("RunRight")

  if left:
    velocity.x = -RUN_SPEED
    $Sprite.flip_h = true
    if !jumping:
      animationState.travel("RunLeft")

  if !right && !left && !jumping:
    animationState.travel("Idle")

  velocity.y += GRAVITY * delta;
  
  if jump and is_on_floor():
    jumping = true
    velocity.y = JUMP_SPEED
    animationState.travel("JumpStart")
    
  velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)

  if jumping and is_on_floor():
    jumping = false
    animationState.travel("JumpEnd")
    
