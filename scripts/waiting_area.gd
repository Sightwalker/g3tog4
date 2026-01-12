extends Area3D

# For 'annotations', most of them received an '@' prefix to differentiate from code keywords, so
# export and onready became:
@export var material_change: StandardMaterial3D
@onready var mesh: MeshInstance3D = $"MeshInstance3D"

var is_activated = false

func _ready() -> void:
	# In Godot 3 we used to connect signals like:
	#	 connect(button, "pressed", self, "_on_button_pressed");
	# Now we can do it much more straightforward like the example below, where we call the
	# connect() function from the object and directly pass the 'Callable', which is the method we want
	# to connect:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D):
	if body is CharacterBody3D and not is_activated:
		is_activated = true
		
		# In Godot 3 we used to wait for things to happen like:
		#	yield(get_tree().create_timer(1.0), "timeout") <- If you needed to wait for some time
		# or
		#	yield(object, "signal_name");
		# Now we use the keyword 'await' just like in the example below:
		await get_tree().create_timer(1.1).timeout
		#...and then after what we waited is over we get to run the rest of the code.
		
		# For Callables, which used to be called FuncRef, it's almost the same. Used to be:
		#	var my_ref: FuncRef = funcref(self, "my_function")
		#	my_ref.call_func()
		# And now it's:
		var my_callable: Callable = _change_material_color
		my_callable.call()


func _change_material_color() -> void:
	mesh.material_override = material_change
	print("Done!!")
