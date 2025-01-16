extends CharacterBody2D

# Exported vars

@export_category("Game Settings")
@export_subgroup("Controller")
@export var gravity : float = 2000.0
@export var speed : float = 400.0
@export var jump_force : float = 800

@export_subgroup("Visual")
@export var color : String = "purple"

# Normal vars

var can_double_jump = false
var animating = false
var is_falling = false

#region Color Dict

var colors : Dictionary = {
	"red" : [
		Color(0.431, 0.153, 0.153),
		Color(0.702, 0.220, 0.192),
		Color(0.918, 0.310, 0.212),
		Color(0.961, 0.490, 0.290)
	],
	"purple" : [
		Color(0.271, 0.161, 0.247),
		Color(0.420, 0.243, 0.459),
		Color(0.565, 0.369, 0.663),
		Color(0.659, 0.518, 0.953)
	],
	"green" : [
		Color(0.086, 0.353, 0.298),
		Color(0.137, 0.565, 0.388),
		Color(0.118, 0.737, 0.451),
		Color(0.569, 0.859, 0.412)
	],
	"pink" : [
		Color(0.514, 0.110, 0.365),
		Color(0.765, 0.141, 0.329),
		Color(0.941, 0.310, 0.471),
		Color(0.961, 0.506, 0.506)
	],
	"orange" : [
		Color(0.620, 0.271, 0.224),
		Color(0.804, 0.408, 0.239),
		Color(0.902, 0.565, 0.306),
		Color(0.984, 0.725, 0.329)
	],
	"yellow" : [
		Color(0.298, 0.239, 0.141),
		Color(0.933, 0.722, 0.353),
		Color(0.984, 0.812, 0.373),
		Color(0.939, 0.890, 0.388)
	],
	"blue" : [
		Color(0.196, 0.203, 0.329),
		Color(0.284, 0.290, 0.467),
		Color(0.302, 0.400, 0.709),
		Color(0.302, 0.608, 0.902)
	],
	"gray" : [
		Color(0.180, 0.137, 0.188), 
		Color(0.246, 0.208, 0.271), 
		Color(0.384, 0.337, 0.398),  
		Color(0.588, 0.424, 0.424)  
	]
}
#endregion

func _ready():
#region defining color
	var shader = preload("res://assets/shaders/color.gdshader")
	var material = ShaderMaterial.new()
	material.shader = shader
	var i = 1
	for item in colors[color]:
		material.set_shader_parameter("replace" + str(i), item)
		i += 1
	$AnimatedSprite2D.material = material
#endregion




func _physics_process(delta):
	var horizontal_input = Input.get_axis("left", "right")
	velocity.x = horizontal_input * speed

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			can_double_jump = true
			jump_anim()
			velocity.y = -jump_force
		elif can_double_jump:
			velocity.y = -jump_force
			can_double_jump = false

	if not is_on_floor():
		velocity.y += gravity * delta
	
	is_falling = velocity.y > 0 and not is_on_floor()

	rotate_sprite(horizontal_input)
	jump_end_anim()
	move_and_slide()

func rotate_sprite(direction):
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction > 0:
		$AnimatedSprite2D.flip_h = false

func jump_anim():
	$AnimatedSprite2D.play("jumpingstart")

func jump_end_anim():
	if is_on_floor():
		animating = false
	if $RayCast2D.is_colliding() and not animating and is_falling:
		$AnimatedSprite2D.play("jumpingend")
