extends Node2D

#const Bitboard = preload("res://src/Bitboard.gd")
#const BoardFunctions = preload("res://src/BitboardFunctions.gd")

var DarkSquare = preload("res://obj/DarkSquare.tscn") 
var LightSquare = preload("res://obj/LightSquare.tscn")

export(PackedScene) var Piece

# Called when the node enters the scene tree for the first time.
func _ready():
	#var bitboard = Bitboard.new()
	#var second = Bitboard.new()
	#bitboard.set_state(false,   0x7fff00ff00000000 )
	#second.set_state(false, 0x00ffffffff000000)
	#var new_board = BoardFunctions.LOGICAL_AND(bitboard, second)
	#print("new board: ", new_board.to_string() )
	#print("new     : ", bitboard.to_string())
	#print("key     : 0123456789abcdef")
	# for i in range(64):
	#   print("string: ", bitboard.to_string())
	#   bitboard.shift_right()
	#create_board()
	#save_scene()
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event): 
	if (event.is_action_pressed("Left Click")): 
		#print("button clicked!")
		pass


const SQUARE_SIZE = 32



# ONLY USED TO CREATE THE BOARD
func create_board():
	for rank in range(8): 
		for file in range(8): 
			#square.scale = Vector2(2, 2)
			var square
			if ((rank + file) % 2 == 0): 
				square = DarkSquare.instance()
			else: 
				square = LightSquare.instance() 
			square.position = Vector2(file * square.scale.x * SQUARE_SIZE, ( 7 - rank ) * square.scale.y * 32)
			$GameBoard.add_child(square)
			square.set_owner($GameBoard)

func save_scene():
	var packed_scene = PackedScene.new()
	packed_scene.pack($GameBoard)
	print(ResourceSaver.save("res://obj/Gameboard.tscn", packed_scene))


