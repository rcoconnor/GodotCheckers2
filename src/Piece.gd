extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mouse_is_over_collider = false
var is_target = false
var old_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

export(int) var speed = 500


func _process(_delta): 
    pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    if (is_target):
        var vec = get_viewport().get_mouse_position() #- self.position
        #vec = vec.normalized() * delta * speed
        set_global_position(vec) 


func _input(event): 
    if event.is_action_pressed("Left Click"):
        if is_target == false: 
            print("clicking ")
            if mouse_is_over_collider:
                print("setting target!")
                is_target = true
                old_pos = position
        else: 
            is_target = false
            set_position(old_pos) 


func _on_mouse_entered(): 
    print("mouse entered")
    mouse_is_over_collider = true

func _on_mouse_exit(): 
    print("leaving")
    mouse_is_over_collider = false
