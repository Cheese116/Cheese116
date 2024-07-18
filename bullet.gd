extends Area2D
@onready var animation_player = %AnimationPlayer
var axe
var distance = 0
const speed = 1111
const  RANGE = 1000
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation) * speed * delta
	position += direction
	distance += speed * delta
	if distance > 500:
		animation_player.play("fade")
	if distance > RANGE:
		AXEE()
		
		

func AXEE():
	
	var axee = axe.duplicate()
	axee.global_position = global_position
	axee.request_ready()
	get_parent().add_child(axe)
	
	
	
	queue_free()

func _on_body_entered(body):
	AXEE()
	
	
	if body.has_method("take_damage"):
		body.take_damage(2, )
