extends Node2D

#const Bitboard = preload("res://src/Bitboard.gd")
const BoardFunctions = preload("res://src/BitboardFunctions.gd")

const ClickableSprite = preload("res://src/ClickableSprite.gd")
const Piece = preload("res://src/Piece.gd")

#var DarkSquare = preload("res://obj/DarkSquare.tscn") 
#var LightSquare = preload("res://obj/LightSquare.tscn")

const Lookup = preload("res://src/LookupTables.gd")


var DarkPiece = preload("res://obj/DarkPiece.tscn") 
var LightPiece = preload("res://obj/LightPiece.tscn") 

var target_piece = Node2D  
var has_target = false
var original_pos = Vector2()
var should_move = false

var board_functions
var index = 0

#var move_to_show = null

# Called when the node enters the scene tree for the first time.
func _ready():
    #var lookup = Lookup.new()
    #print("looup: ", lookup.CLEAR_RANK[0].to_string())
    board_functions = BoardFunctions.new()
    print("BoardController: ", board_functions.CLEAR_RANK[1].to_string())
    has_target = false
    for each_child in $GameBoard.get_children(): 
        if each_child is ClickableSprite: 
            each_child.connect("selected", self, "selected_signal_received")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if(has_target): 
        var mouse_pos = get_viewport().get_mouse_position()
        target_piece.set_new_global_pos(mouse_pos)
        #target_piece.set_new_global_position(mouse_pos)
        

func _input(event):
    if event.is_action_pressed("ui_accept"):  # space bar
        $PieceManager.clear_board()
        #print("rank 0: ", lookup.CLEAR_RANK)
        #$PieceManager.instance_pieces($PieceManager.DarkPiece, board_functions.MASK_FILE[index])
        #if (move_to_show != null): 
            #$PieceManager.instance_pieces($PieceManager.DarkPiece, move_to_show)
    if(event.is_action_pressed("Left Click")): 
        pass 
        #   if (event.is_action_pressed("Left Click")): 
#       if (has_target && target_piece is Piece):
#           print("target piece is piece")
#           print("this shouldn't be calling on empty squares")
#           target_piece.set_new_global_pos(original_pos)
#           has_target = false


func select_piece_received(node):
#   print("the piece has been received")
#   print("rank: ", node.get_rank())
#   print("file: ", node.get_file())
    if (has_target == false): 
        original_pos = node.global_position
        has_target = true
        target_piece = node
    pass


func _on_pieces_refreshed_screen(): 
    for each_child in $PieceManager.get_children(): 
        if each_child is Piece: 
            each_child.connect("piece_selected", self, "select_piece_received")

# called when a square has been clicked 
func selected_signal_received(square_rank, square_file): 
    #   print("a square has been clicked")
    if (has_target):
        if (target_piece.get_rank() != square_rank && target_piece.get_file() != square_file):
            var is_valid_move = target_piece.compute_is_valid_move(square_rank, square_file, $PieceManager.get_dark_piece_state())
            #move_to_show = valid_moves
            print("is_valid: ", is_valid_move)
            if(is_valid_move): 
                has_target = false
                $PieceManager.refresh_board()
            else:
                has_target = false
                $PieceManager.refresh_board()


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


