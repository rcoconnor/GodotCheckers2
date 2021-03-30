extends Node2D

#const Bitboard = preload("res://src/Bitboard.gd")
#const BoardFunctions = preload("res://src/BitboardFunctions.gd")

const ClickableSprite = preload("res://src/ClickableSprite.gd")
const Piece = preload("res://src/Piece.gd")

#var DarkSquare = preload("res://obj/DarkSquare.tscn") 
#var LightSquare = preload("res://obj/LightSquare.tscn")


var DarkPiece = preload("res://obj/DarkPiece.tscn") 
var LightPiece = preload("res://obj/LightPiece.tscn") 

var target_piece = Node2D  
var has_target = false
var original_pos = Vector2()
var should_move = false
# Called when the node enters the scene tree for the first time.
func _ready():
    has_target = false
    for each_child in $GameBoard.get_children(): 
        if each_child is ClickableSprite: 
            each_child.connect("selected", self, "selected_signal_received")

    for each_child in $PieceManager.get_children(): 
        if each_child is Piece: 
            each_child.connect("piece_selected", self, "select_piece_received")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if(has_target): 
        var mouse_pos = get_viewport().get_mouse_position()
        target_piece.set_new_global_pos(mouse_pos)
        #target_piece.set_new_global_position(mouse_pos)

func _input(event):
    if(event.is_action_pressed("Left Click")): 
        pass 
        #   if (event.is_action_pressed("Left Click")): 
#       if (has_target && target_piece is Piece):
#           print("target piece is piece")
#           print("this shouldn't be calling on empty squares")
#           target_piece.set_new_global_pos(original_pos)
#           has_target = false

        
func select_piece_received(node):
    print("the piece has been received")
    if (has_target == false): 
        original_pos = node.global_position
        has_target = true
        target_piece = node
    pass


func selected_signal_received(x_val, y_val): 
    if (has_target):
        if (target_piece.position.x != x_val && target_piece.position.y): 
            print("received the signal")
            print("targetx: ", target_piece.position.x)
            print("targety: ", target_piece.position.y)
            print("x: ", x_val)
            print("y: ", y_val)

#const SQUARE_SIZE = 32



# ONLY USED TO CREATE THE BOARD
#func create_board():
#    for rank in range(8): 
#        for file in range(8): 
#            #square.scale = Vector2(2, 2)
#            var square
#            if ((rank + file) % 2 == 0): 
#                square = DarkSquare.instance()
#            else: 
#                square = LightSquare.instance() 
#            square.position = Vector2(file * square.scale.x * SQUARE_SIZE, ( 7 - rank ) * square.scale.y * 32)
#            $GameBoard.add_child(square)
#            square.set_owner($GameBoard)

#func save_scene():
#    var packed_scene = PackedScene.new()
#    packed_scene.pack($GameBoard)
#    print(ResourceSaver.save("res://obj/Gameboard.tscn", packed_scene))


