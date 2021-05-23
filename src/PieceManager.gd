extends Node2D

const Bitboard = preload("res://src/Bitboard.gd")
const BoardFunctions = preload("res://src/BitboardFunctions.gd")

var board_functions

export(PackedScene) var LightPiece
export(PackedScene) var DarkPiece
export(PackedScene) var DarkKing
export(PackedScene) var LightKing

var dark_piece_state = Bitboard.new()
var light_piece_state = Bitboard.new()

var dark_kings = Bitboard.new()
var dark_pawns = Bitboard.new()
var light_kings = Bitboard.new()
var light_pawns = Bitboard.new()

# Member variables
var pieces_array = Array()


# important constants
const SPRITE_SIZE = 32

signal refreshed_screen
signal jumped(target_piece)

func _ready():
    board_functions = BoardFunctions.new()
    
    dark_pawns.set_state(false, 0x000000000055AA55)
    #dark_pawns.set_state(false, 0x0050A00000000000)
    dark_kings.set_state(false, 0)
    light_pawns.set_state(true, 0x2A55AA0000000000)
    #light_pawns.set_state(false, 0x000000000000AA00)
    light_kings.set_state(false, 0)

    refresh_board()

func _process(_delta):
    pass



func move_pieces(from_rank, from_file, to_rank, to_file, is_white_piece, is_king_piece, target_piece): 
    var new_index: int = ( to_rank * 8 ) + to_file
    var old_index: int = (from_rank * 8) + from_file
    

    var not_old_piece = BoardFunctions.LOGICAL_NOT(board_functions.PIECE_TABLE[old_index])
    var new_piece = board_functions.PIECE_TABLE[new_index]
    
    var did_jump: bool = false
    if is_white_piece: 
        if not is_king_piece: 
            var old_without_piece = BoardFunctions.LOGICAL_AND(light_pawns, not_old_piece)
            var new_light_pieces = BoardFunctions.LOGICAL_OR(old_without_piece, new_piece)
            if (from_rank - to_rank == 2): 
                # there is a jump, so we should 
                var victim_index: int = 0
                if (from_file > to_file): 
                    # we need the value of the piece table for the place we are jumping
                    victim_index = (( from_rank - 1 ) * 8) + ( from_file - 1)
                else: 
                    victim_index = (( from_rank - 1 ) * 8) + (from_file + 1)
                var not_victim = BoardFunctions.LOGICAL_NOT(board_functions.PIECE_TABLE[victim_index])
                var new_enemy_pawns = BoardFunctions.LOGICAL_AND(dark_pawns, not_victim)
                var new_enemy_kings = BoardFunctions.LOGICAL_AND(dark_kings, not_victim)
                set_dark_piece_state(new_enemy_pawns, new_enemy_kings)
                did_jump = true
            set_light_piece_state(new_light_pieces, light_kings)
            if to_rank == 0: king_piece(new_piece, true)
        else: # it is a king piece 
            var old_without_piece = BoardFunctions.LOGICAL_AND(light_kings, not_old_piece)
            var new_light_pieces = BoardFunctions.LOGICAL_OR(old_without_piece, new_piece)
            # FIXME: handle jumping 
            if (to_rank - from_rank == 2) or (from_rank - to_rank == 2): 
                var victim_index: int = 0
                var victim_rank: int = (from_rank + to_rank) / 2
                var victim_file: int = (from_file + to_file) / 2
                victim_index = (victim_rank * 8) + victim_file
                var not_victim = BoardFunctions.LOGICAL_NOT(board_functions.PIECE_TABLE[victim_index])
                var new_enemy_pawns = BoardFunctions.LOGICAL_AND(dark_pawns, not_victim)
                var new_enemy_kings = BoardFunctions.LOGICAL_AND(dark_kings, not_victim)

                set_dark_piece_state(new_enemy_pawns, new_enemy_kings)
                did_jump = true
            set_light_piece_state(light_pawns, new_light_pieces)
    else:
        if not is_king_piece: 
            #print("dark piece moving: ")
            var old_without_piece = BoardFunctions.LOGICAL_AND(dark_pawns, not_old_piece)
            var new_dark_pieces = BoardFunctions.LOGICAL_OR(old_without_piece, new_piece)
            if(to_rank - from_rank == 2):
                var victim_index: int = 0
                if (from_file > to_file): 
                    victim_index = ((from_rank + 1) * 8) + (from_file - 1)
                else: 
                    victim_index = ((from_rank + 1) * 8) + (from_file + 1)
                var not_victim = BoardFunctions.LOGICAL_NOT(board_functions.PIECE_TABLE[victim_index])
                var new_enemy_pawns = BoardFunctions.LOGICAL_AND(light_pawns, not_victim)
                var new_enemy_kings = BoardFunctions.LOGICAL_AND(light_kings, not_victim)
                set_light_piece_state(new_enemy_pawns, new_enemy_kings)
                did_jump = true
            set_dark_piece_state(new_dark_pieces, dark_kings)
            if to_rank == 7: king_piece(new_piece, false)
        else: # it is a king piece 
            var old_without_piece  = BoardFunctions.LOGICAL_AND(dark_kings, not_old_piece)
            var new_dark_pieces = BoardFunctions.LOGICAL_OR(old_without_piece, new_piece)
            # FIXME: handle jumping 
            if(to_rank - from_rank == 2) or (from_rank - to_rank == 2): 
                var victim_index: int = 0
                var victim_rank: int = (from_rank + to_rank) / 2
                var victim_file: int = (from_file + to_file) / 2
                victim_index = ( victim_rank * 8 ) + victim_file
                var not_victim = BoardFunctions.LOGICAL_NOT(board_functions.PIECE_TABLE[victim_index])
                var new_enemy_pawns = BoardFunctions.LOGICAL_AND(light_pawns, not_victim)
                var new_enemy_kings = BoardFunctions.LOGICAL_AND(light_kings, not_victim)
                set_light_piece_state(new_enemy_pawns, new_enemy_kings)
                did_jump = true 
            set_dark_piece_state(dark_pawns, new_dark_pieces)
    if did_jump: 
        emit_signal("jumped", new_piece)
    

# converts the piece indicated by piece_loc into a king
# @param piece_loc - a bitboard with a set bit representing the position of the
# piece we are going to king 
# @param is_white - boolean representing whether the piece is a white or dark 
# piece 
func king_piece(piece_loc, is_white): 
    var not_piece = BoardFunctions.LOGICAL_NOT(piece_loc)
    if (is_white): 
        light_pawns = BoardFunctions.LOGICAL_AND(not_piece, light_pawns)
        light_kings = BoardFunctions.LOGICAL_OR(piece_loc, light_kings)
        light_piece_state = BoardFunctions.LOGICAL_OR(light_pawns, light_kings)
    else: 
        #print("kinging dark: ", piece_loc.to_string())
        dark_pawns = BoardFunctions.LOGICAL_AND(not_piece, dark_pawns)
        #print("not piece: ", not_piece.to_string())
        dark_kings = BoardFunctions.LOGICAL_OR(piece_loc, dark_kings)
        dark_piece_state = BoardFunctions.LOGICAL_OR(dark_pawns, dark_kings)

# clears the board 
func clear_board(): 
    for each_piece in pieces_array:
        remove_child(each_piece)
        each_piece.queue_free()
    pieces_array = Array()


func refresh_board(): 
    clear_board()
    dark_piece_state = BoardFunctions.LOGICAL_OR(dark_pawns, dark_kings)
    light_piece_state = BoardFunctions.LOGICAL_OR(light_pawns, light_kings)
    instance_pieces(DarkPiece, dark_pawns)
    instance_pieces(LightPiece, light_pawns)
    instance_pieces(DarkKing, dark_kings)
    instance_pieces(LightKing, light_kings)
    emit_signal("refreshed_screen") 


func instance_pieces(node_to_instance, state): 
    var temp_board = Bitboard.new()
    temp_board.set_state(state.get_msb(), state.get_board_state())
    for rank in range(8): 
        for file in range(8): 
            #print("getLSB: ", temp_board.get_lsb())
            if (temp_board.get_lsb() == 1): 
                var new_piece = node_to_instance.instance()
                add_child(new_piece)
                new_piece.set_owner(self)
                pieces_array.append(new_piece)
                new_piece.set_file(file)
                new_piece.set_rank(rank)
            temp_board.shift_right()

func set_dark_piece_state(new_pawn_state, new_king_state): 
    dark_pawns = new_pawn_state
    dark_kings = new_king_state
    dark_piece_state = BoardFunctions.LOGICAL_OR(dark_pawns, dark_kings)

func get_dark_piece_state(): 
    return dark_piece_state

func set_light_piece_state(new_pawn_state, new_king_state): 
    light_pawns = new_pawn_state
    light_kings = new_king_state
    light_piece_state = BoardFunctions.LOGICAL_OR(light_pawns, light_kings)

func get_light_piece_state(): 
    return light_piece_state


