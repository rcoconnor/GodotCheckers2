extends "res://src/Piece.gd"

func compute_is_valid_move(new_rank, new_file, own_side_bitboard): 
    # Get the bitbaord representation of the move the player would like to make 
    print("light piece calling!")
    var new_index: int = (8 * new_rank) + new_file
    var shifted_piece_table = bitboardFunctions.PIECE_TABLE[new_index]

    # Get the valid moves from the targets current position
    var valid_moves = compute_light_piece_valid_moves(own_side_bitboard)
    var is_valid = BoardFunctions.multiple_shift_right(BoardFunctions.LOGICAL_AND(shifted_piece_table, valid_moves), new_index) 
    if is_valid.get_board_state() == 1 && is_valid.get_msb() == false: 
        return true
    return false



func compute_light_piece_valid_moves(own_side_bitboard):
    # clear all moves which would go off the board
    var piece_loc_bitboard = BoardFunctions.copy_bitboard(bitboardFunctions.PIECE_TABLE[piece_index]) 
    var piece_clip_file_h = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[7])
    var piece_clip_file_a = BoardFunctions.LOGICAL_AND(piece_loc_bitboard, bitboardFunctions.CLEAR_FILE[0])
    
    # get the possible moves
    var left_spot = BoardFunctions.multiple_shift_right(piece_clip_file_a, 9)
    var right_spot = BoardFunctions.multiple_shift_right(piece_clip_file_h, 7)
    var possible_moves = BoardFunctions.LOGICAL_OR(left_spot, right_spot)
    
    # NOT the whole bitboard in order to clear the old position from the board
    var inverted_board = BoardFunctions.LOGICAL_NOT(own_side_bitboard)
    var valid_moves = BoardFunctions.LOGICAL_AND(possible_moves, inverted_board)
    
    return valid_moves

