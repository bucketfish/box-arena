extends Area2D


func _ready():
	pass # Replace with function body.


func _on_hurtbox_area_entered(area):
	if area.is_in_group("hitbox"):
		get_parent().take_damage(area.damage)
		
func start_invincibility(time):
	set_deferred("monitoring", false)
	yield(get_tree().create_timer(time), "timeout")
	set_deferred("monitoring", true)
