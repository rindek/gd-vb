extends KinematicBody2D

const RUN_SPEED = 200
var velocity = Vector2.ZERO
const GRAVITY = 500
const JUMP_SPEED = -500
var jumping = false

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
  if !jumping:
    velocity.x = 0
    
  var right = Input.is_action_pressed('ui_right')
  var left = Input.is_action_pressed('ui_left')
  var jump = Input.is_action_just_pressed("ui_up")
    
  if right and !jumping:
    velocity.x += RUN_SPEED
    animationState.travel("RunRight")

  if left and !jumping:
    velocity.x -= RUN_SPEED
    animationState.travel("RunLeft")

  if !right && !left && !jumping:
    animationState.travel("Idle")

  if jump and is_on_floor():
    jumping = true
    velocity.y = JUMP_SPEED
    animationState.travel("JumpStart")
        
  velocity.y += GRAVITY * delta;
  
  velocity = move_and_slide(velocity, Vector2(0, -1))

  if jumping and is_on_floor():
    jumping = false
    animationState.travel("JumpEnd")
    
