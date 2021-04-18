extends "res://src/Piece.gd"


func compute_is_valid_move(new_rank, new_file, dark_pieces_bitboard, light_pieces_bitboard): 
    print("light side: ", light_pieces_bitboard.to_string())
    var new_index: int = (8 * new_rank) + new_file
    var shifted_piece_table = bitboardFunctions.PIECE_TABLE[new_index]

    var valid_moves = compute_dark_piece_valid_moves(dark_pieces_bitboard, light_pieces_bitboard)
    var is_valid = BoardFunctions.multiple_shift_right(BoardFunctions.LOGICAL_AND(shifted_piece_table, valid_moves), new_index)
    if (is_valid.get_board_state() == 1 && is_valid.get_msb() == false): 
        return true
    return false 


# uses a series of logical operations in order to find the valid moves 
# returns: a bitboard containing the valid moves 
func compute_dark_piece_valid_moves(own_side_bitboard, enemy_bitboard): 
    var piece_loc_bitboard = BoardFunctions.copy_bitboard(bitboardFunctions.PIECE_TABLE[piece_index])
    var piece_clip_file_h = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[7])
    var piece_clip_file_a = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[0])
    
    # Get the representation for each valid move by shifting the position of 
    # the current piece for each spot and OR'ing the results
    var left_spot = BoardFunctions.multiple_shift_left(piece_clip_file_a, 7)
    var right_spot = BoardFunctions.multiple_shift_left(piece_clip_file_h, 9)
    var possible_moves = BoardFunctions.LOGICAL_OR(left_spot, right_spot)
    
    # Remove any positions which already have pieces on them by AND'ing the 
    # board with the compliment of each side 
    var inverted_board = BoardFunctions.LOGICAL_NOT(own_side_bitboard)
    var inverted_enemy = BoardFunctions.LOGICAL_NOT(enemy_bitboard)
    
    var temp_valid_moves = BoardFunctions.LOGICAL_AND(possible_moves, inverted_board)
    var valid_moves = BoardFunctions.LOGICAL_AND(temp_valid_moves, inverted_enemy)
    return valid_moves



