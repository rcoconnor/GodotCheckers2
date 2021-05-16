extends "res://src/Piece.gd" 
export var is_white: bool

func compute_is_valid_move(new_rank, new_file, dark_pieces_bitboard, light_pieces_bitboard): 
    var new_index: int = (8*new_rank) + new_file
    var shifted_piece_table = bitboardFunctions.PIECE_TABLE[new_index]

    var valid_moves = get_valid_moves(dark_pieces_bitboard, light_pieces_bitboard)
    
    var is_valid = BoardFunctions.LOGICAL_AND(shifted_piece_table, valid_moves)
    is_valid = BoardFunctions.multiple_shift_right(is_valid, new_index)
    if(is_valid.get_board_state() == 1 && is_valid.get_msb() == false): 
        return true
    return false 

func get_valid_moves(dark_pieces_bitboard, light_pieces_bitboard):
    if is_white: return compute_king_valid_moves(light_pieces_bitboard, dark_pieces_bitboard)
    else: return compute_king_valid_moves(dark_pieces_bitboard, light_pieces_bitboard)


func compute_king_valid_moves(own_side, enemy_side): 
    print("computing king, is_white:", is_white)
    var piece_loc_bitboard = BoardFunctions.copy_bitboard(bitboardFunctions.PIECE_TABLE[piece_index])
    var piece_clip_file_h = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[7])
    var piece_clip_file_a = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[0]) 

    var top_left = BoardFunctions.multiple_shift_left(piece_clip_file_a, 7)
    var bot_left = BoardFunctions.multiple_shift_right(piece_clip_file_a, 9)
    var top_right = BoardFunctions.multiple_shift_left(piece_clip_file_h, 9)
    var bot_right = BoardFunctions.multiple_shift_right(piece_clip_file_h, 7)
    var possible_moves = BoardFunctions.LOGICAL_OR(top_left, top_right)
    possible_moves = BoardFunctions.LOGICAL_OR(possible_moves, bot_right)
    possible_moves = BoardFunctions.LOGICAL_OR(possible_moves, bot_left)

    var inverted_board = BoardFunctions.LOGICAL_NOT(own_side)
    var inverted_enemy = BoardFunctions.LOGICAL_NOT(enemy_side)

    var temp_valid_moves = BoardFunctions.LOGICAL_AND(possible_moves, inverted_board)
    var valid_moves = BoardFunctions.LOGICAL_AND(temp_valid_moves, inverted_enemy)
    print("valid moves: ", valid_moves.to_string())
    return valid_moves

func get_is_white(): 
    return is_white


