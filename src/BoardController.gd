extends Node2D

const Bitboard = preload("res://src/Bitboard.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    var bitboard = Bitboard.new()
    bitboard.set_state(false, 0x0000000000000001)
    print("new     : ", bitboard.to_string())
    print("key     : 0123456789abcdef")
    for i in range(64):
        print("string: ", bitboard.to_string())
        bitboard.shift_left()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
