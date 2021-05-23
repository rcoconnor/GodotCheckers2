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
    
    # FIXME: handle jumping  
    var jump_bitboard = handle_jumping(piece_loc_bitboard, enemy_side)
    possible_moves = BoardFunctions.LOGICAL_OR(possible_moves, jump_bitboard)

    var inverted_board = BoardFunctions.LOGICAL_NOT(own_side)
    var inverted_enemy = BoardFunctions.LOGICAL_NOT(enemy_side)

    var temp_valid_moves = BoardFunctions.LOGICAL_AND(possible_moves, inverted_board)
    var valid_moves = BoardFunctions.LOGICAL_AND(temp_valid_moves, inverted_enemy)
    return valid_moves

func get_is_white(): 
    return is_white


func handle_jumping(pos_bitboard, enemy_bitboard): 
    var piece_clip_file_h = BoardFunctions.LOGICAL_AND(pos_bitboard, bitboardFunctions.CLEAR_FILE[7])
    var piece_clip_file_a = BoardFunctions.LOGICAL_AND(pos_bitboard, bitboardFunctions.CLEAR_FILE[0])

    var val_to_return = Bitboard.new()
    val_to_return.set_state(false, 0)

    var top_left = BoardFunctions.multiple_shift_left(piece_clip_file_a, 7)
    var bot_left = BoardFunctions.multiple_shift_right(piece_clip_file_a, 9)
    var top_right = BoardFunctions.multiple_shift_left(piece_clip_file_h, 9)
    var bot_right = BoardFunctions.multiple_shift_right(piece_clip_file_h, 7)

    var is_top_left = BoardFunctions.LOGICAL_AND(enemy_bitboard, top_left)
    var is_bot_left = BoardFunctions.LOGICAL_AND(enemy_bitboard, bot_left)
    var is_top_right = BoardFunctions.LOGICAL_AND(enemy_bitboard, top_right)
    var is_bot_right = BoardFunctions.LOGICAL_AND(enemy_bitboard, bot_right)

    is_top_left = BoardFunctions.multiple_shift_right(is_top_left, 7 + piece_index)
    is_bot_left = BoardFunctions.multiple_shift_right(is_bot_left, piece_index - 9)
    is_top_right = BoardFunctions.multiple_shift_right(is_top_right, 9 + piece_index)
    is_bot_right = BoardFunctions.multiple_shift_right(is_bot_right, piece_index - 7)


    if is_top_left.get_lsb() == 1: 
        piece_clip_file_a = BoardFunctions.LOGICAL_AND(piece_clip_file_a, bitboardFunctions.CLEAR_FILE[1])
        top_left = BoardFunctions.multiple_shift_left(piece_clip_file_a, 14)
        val_to_return = BoardFunctions.LOGICAL_OR(top_left, val_to_return)
    if is_top_right.get_lsb() == 1: 
        piece_clip_file_h = BoardFunctions.LOGICAL_AND(piece_clip_file_h, bitboardFunctions.CLEAR_FILE[6])
        top_right = BoardFunctions.multiple_shift_left(piece_clip_file_h, 18)
        val_to_return = BoardFunctions.LOGICAL_OR(top_right, val_to_return)
    if is_bot_left.get_lsb() == 1: 
        piece_clip_file_a = BoardFunctions.LOGICAL_AND(piece_clip_file_a, bitboardFunctions.CLEAR_FILE[1])
        bot_left = BoardFunctions.multiple_shift_right(piece_clip_file_a, 18)
        val_to_return = BoardFunctions.LOGICAL_OR(bot_left, val_to_return)
    if is_bot_right.get_lsb() == 1:
        piece_clip_file_h = BoardFunctions.LOGICAL_AND(piece_clip_file_h, bitboardFunctions.CLEAR_FILE[6])
        bot_right = BoardFunctions.multiple_shift_right(piece_clip_file_h, 14)
        val_to_return = BoardFunctions.LOGICAL_OR(bot_right, val_to_return)
    return val_to_return 


