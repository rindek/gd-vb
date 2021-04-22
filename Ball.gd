extends RigidBody2D

func _integrate_forces(state):
  if Input.is_action_just_pressed("ui_cancel"):
    state.transform = Transform2D((get_viewport_rect().size / 2), (get_viewport_rect().size / 2), Vector2.ZERO)
