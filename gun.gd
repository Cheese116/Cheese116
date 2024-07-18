extends Area2D
@onready var timer_3 = %Timer3
var  axe

@onready var timer = %Timer
signal  thrown
var reload = 0
func _ready():
	print("GUN")
	self.set_process_input(true)
func _physics_process(delta):
	var enemy_range = get_overlapping_bodies()
	
	look_at(get_global_mouse_position())
	if Money.pause == false:
		if Input.is_action_pressed("shoot") and reload == 0:
			shoot()
			timer.start()

func shoot():
	reload = 1
	const BULLET = preload("res://bullet.tscn")
	var new_BULLET = BULLET.instantiate()
	new_BULLET.global_position = %shootpoint.global_position
	new_BULLET.global_rotation = %shootpoint.global_rotation
	thrown.emit()
	new_BULLET.axe = axe
	get_parent().get_parent().add_child(new_BULLET)







func _on_timer_timeout():
	reload = 0
