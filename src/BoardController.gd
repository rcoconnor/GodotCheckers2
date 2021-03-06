extends Node2D

const Bitboard = preload("res://src/Bitboard.gd")
const BoardFunctions = preload("res://src/BitboardFunctions.gd")

const ClickableSprite = preload("res://src/ClickableSprite.gd")
const Piece = preload("res://src/Piece.gd")
const LightPiece = preload("res://src/LightPiece.gd")
const DarkPiece = preload("res://src/DarkPiece.gd")

var KingPiece = preload("res://src/KingPiece.gd")
#var DarkSquare = preload("res://obj/DarkSquare.tscn") 
#var LightSquare = preload("res://obj/LightSquare.tscn")

const Lookup = preload("res://src/LookupTables.gd")

export(PackedScene) var HighLightSquare

#var DarkPiece = preload("res://obj/DarkPiece.tscn") 
#var LightPiece = preload("res://obj/LightPiece.tscn") 

var target_piece = Node2D 

var old_target_piece_loc = Bitboard
var should_check_for_double_jump = false

var has_target = false
var original_pos = Vector2()
var should_move = false

var board_functions
var index = 0

var is_current_turn_white: bool

#var move_to_show = null

# Called when the node enters the scene tree for the first time.
func _ready():
    #var lookup = Lookup.new()
    #print("looup: ", lookup.CLEAR_RANK[0].to_string())
    board_functions = BoardFunctions.new()
    has_target = false
    is_current_turn_white = false
    for each_child in $GameBoard.get_children(): 
        if each_child is ClickableSprite: 
            each_child.connect("selected", self, "selected_signal_received")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if(should_check_for_double_jump == true): 
        #print("should check now")
        #print("has target: ", has_target)
        should_check_for_double_jump = false
        #check_double_jump()
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

# called when a piece has been selected 
# node: the node of the piece which has been selected 
func select_piece_received(node):
    if (has_target == false): 
        #if is_current_turn_white ==  node.get_is_white():
        original_pos = node.global_position
        has_target = true
        target_piece = node
        highlight_valid_moves()        


func _on_pieces_refreshed_screen(): 
    for each_child in $PieceManager.get_children(): 
        if each_child is Piece: 
            each_child.connect("piece_selected", self, "select_piece_received")

# called when a square has been clicked, if there is a target piece and the 
# selected square is a valid move, this method will update the board 
# accordingly
# square_rank: the rank of the square which has been selected 
# square_file: the file of the square which has been selected
func selected_signal_received(square_rank, square_file): 
    if (has_target):
        if (target_piece.get_rank() != square_rank && target_piece.get_file() != square_file):
            var is_valid_move = target_piece.compute_is_valid_move(square_rank, square_file, $PieceManager.get_dark_piece_state(), $PieceManager.get_light_piece_state())
            #move_to_show = valid_moves
            if(is_valid_move): 
                #is_current_turn_white = ( not is_current_turn_white )
                if target_piece is LightPiece: 
                    $PieceManager.move_pieces(target_piece.get_rank(), target_piece.get_file(), square_rank, square_file, true, false, target_piece)
                    has_target = false
                    $PieceManager.refresh_board()
                elif target_piece is DarkPiece: 
                    $PieceManager.move_pieces(target_piece.get_rank(), target_piece.get_file(), square_rank, square_file, false, false, target_piece)
                    #if(square_rank - target_piece.get_rank() == 2):
                        #print("this is also a jump")
                    has_target = false
                    $PieceManager.refresh_board()
                elif target_piece is KingPiece:
                    $PieceManager.move_pieces(target_piece.get_rank(), target_piece.get_file(), square_rank, square_file, target_piece.get_is_white(), true, target_piece)
                    has_target = false 
                    $PieceManager.refresh_board()
            # un-highlight all the valid moves 
            else:
                has_target = false
                $PieceManager.refresh_board()
            clear_valid_moves()

#const SQUARE_SIZE = 32


func highlight_valid_moves(): 
    # get the valid moves for the selected piece 
    var valid_moves = target_piece.get_valid_moves($PieceManager.dark_piece_state, $PieceManager.light_piece_state)
    # highlight those valid moves 
    var old_valid_moves = Bitboard.new()
    old_valid_moves.set_state(valid_moves.get_msb(), valid_moves.get_board_state())
    var cur_index = 0
    while cur_index < 64:
        if (valid_moves.get_lsb() == 1):
            var square_to_highlight = $GameBoard.get_child(cur_index)
            # FIXME: should not have to check if it is a clickable sprite
            if square_to_highlight is ClickableSprite:
                square_to_highlight.highlight_square()
            else: 
                print("this is an error should not be happening")
        cur_index += 1
        valid_moves.shift_right()

func clear_valid_moves(): 
    for each_child in $GameBoard.get_children(): 
        if each_child is ClickableSprite: 
            each_child.un_highlight_square()


func jumped_signal_received(_target_piece_bitboard): 
    old_target_piece_loc = _target_piece_bitboard
    should_check_for_double_jump = true


func _check_double_jump():
    for each_piece in $PieceManager.get_children():
        var index: int = each_piece.get_piece_index()
        var val_to_compare = board_functions.PIECE_TABLE[index]
        if(val_to_compare.get_board_state() == old_target_piece_loc.get_board_state()):
            if(val_to_compare.get_msb() == old_target_piece_loc.get_msb()):
                # we have found the piece which  we want, now we shall move it 
                var valid_moves = each_piece.get_valid_moves()
                
                # get the pieces to mask them out 
               #var piece_loc_bitboard = BoardFunctions.copy_bitboard(bitboardFunctions.PIECE_TABLE[piece_index])
               #var piece_clip_file_h = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[7])
               #var piece_clip_file_a = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[0]) 

               #var top_left = BoardFunctions.multiple_shift_left(piece_clip_file_a, 7)
               #var bot_left = BoardFunctions.multiple_shift_right(piece_clip_file_a, 9)
               #var top_right = BoardFunctions.multiple_shift_left(piece_clip_file_h, 9)
               #var bot_right = BoardFunctions.multiple_shift_right(piece_clip_file_h, 7)
               #var possible_moves = BoardFunctions.LOGICAL_OR(top_left, top_right)
               #possible_moves = BoardFunctions.LOGICAL_OR(possible_moves, bot_right)
               #possible_moves = BoardFunctions.LOGICAL_OR(possible_moves, bot_left)


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


