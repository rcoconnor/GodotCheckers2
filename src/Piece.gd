extends Node2D

signal piece_selected(piece) 

var mouse_is_over_collider = false
var is_target = false
var old_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

export(int) var speed = 500


func _process(_delta): 
    pass 


func set_new_global_pos(new_pos):
    set_global_position(new_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
    pass
    #if (is_target):
        #var vec = get_viewport().get_mouse_position() #- self.position
        #vec = vec.normalized() * delta * speed
        #set_global_position(vec) 


func get_rank(): 
    return (position.x / 32)

func get_file(): 
    return (7 - (position.y / 32))

func _input(event): 
    if event.is_action_pressed("Left Click"):
        if mouse_is_over_collider:
            old_pos = position
            emit_signal("piece_selected", self)

func _on_mouse_entered(): 
    mouse_is_over_collider = true

func _on_mouse_exit(): 
    mouse_is_over_collider = false
