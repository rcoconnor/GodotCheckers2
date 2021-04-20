class_name ClickableSprite

extends Node2D

signal selected(x_val, y_val)

var mouse_is_over_collider = false

var rank = 0
var file = 0

func _ready(): 
    file = position.x / 32
    rank = 7 - ( position.y / 32 )

func _input(event): 
    if (event.is_action_pressed("Left Click")): 
        if mouse_is_over_collider: 
            emit_signal("selected", rank, file)

func _on_mouse_entered():
    mouse_is_over_collider = true

func _on_mouse_exit():
    mouse_is_over_collider = false


func highlight_square(): 
    $AnimatedSprite.play("Medium")

func un_highlight_square():
    $AnimatedSprite.play("Dark")
