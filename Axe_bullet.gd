extends "res://item.gd"
@onready var player = get_parent().get_child(0)
@onready var cat = %Sprite2D
var using = false
var inventory_node
var axe_node
var value
@onready var timer = %Timer

func _ready():
	print(get_parent())
	timer.start()
	cat.self_modulate = "ffffff"
	region = cat.region_rect
	consumable = false
	item_texture = preload("res://pixil-frame-0.png")
	print(item_texture)
	print("EDRY")

func use(last_in_stack, ):
	
	print("collect")
	if not using:
		
		if player:
			print("FOUND_PLAYER")
			const AXE = preload("res://gun.tscn")
			var axe = AXE.instantiate()
			axe.set_process_input(true) 
			axe_node = axe
			axe_node.set_process_input(true) 
			print(axe)
			axe.axe = self.duplicate()
			axe.thrown.connect(_on_axe_thrown)
			player.add_child(axe)
			
			
			using = true
	else:
		axe_node.queue_free()
		using = false
	
func buy():
	var clone = self.duplicate()
	clone.item_texture = self.item_texture
	clone.consumable = self.consumable
	clone.player = self.player
	inventory_node = $"../player/Inventory"
	clone.inventory_node = self.inventory_node
	Money.pickup_item(clone, cat)
	print(inventory_node)
	if inventory_node:
		inventory_node.update_UI()
		queue_free()
	else:
		print("no inventory")
		

func _on_axe_thrown():
	
	if inventory_node:
		print("node")
		for i in range(len(inventory_node.slots)):
			if inventory_node.slots[i].item_texture == item_texture:
				
				inventory_node.stack_amount[i] -= 1
				inventory_node.update_UI()
				if inventory_node.stack_amount[i] == 0:
					
					
					print("get rid item")
					inventory_node.slots[i].item_texture = null
					inventory_node.slots[i] = null
					inventory_node.slot_pic[i].texture = null
					
					use(0,)
					queue_free()



func _on_body_entered(body):
	print("UHYEAH")
	if body.is_in_group("player"):
		print("YEEES")
		buy()



func _on_timer_timeout():
	queue_free()
