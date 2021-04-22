extends RigidBody2D

const DEFAULT_GRAVITY = 3


func set_gravity():
  gravity_scale = DEFAULT_GRAVITY


func _on_RigidBody2D_body_entered(body):
  if body.is_in_group("player"):
    body.get_parent().ball_touched(self)
