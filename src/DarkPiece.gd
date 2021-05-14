extends "res://src/Piece.gd"

# @method compute_is_valid_moves
# @param new_rank - 
# @param new_file

func compute_is_valid_move(new_rank, new_file, dark_pieces_bitboard, light_pieces_bitboard): 
    var new_index: int = (8 * new_rank) + new_file
    var shifted_piece_table = bitboardFunctions.PIECE_TABLE[new_index]
    
    # get the board representing all the valid moves 
    var valid_moves = compute_dark_piece_valid_moves(dark_pieces_bitboard, light_pieces_bitboard)
    
    # Bitwise AND the valid moves with the selected moves to ensure the move is valid  
    var is_valid = BoardFunctions.LOGICAL_AND(shifted_piece_table, valid_moves)
    is_valid = BoardFunctions.multiple_shift_right(is_valid, new_index)
    if (is_valid.get_board_state() == 1 && is_valid.get_msb() == false): 
        return true
    return false 


# Public Inherited method, returns all valid moves 
func get_valid_moves(dark_pieces_bitboard, light_pieces_bitboard): 
    return compute_dark_piece_valid_moves(dark_pieces_bitboard, light_pieces_bitboard)

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
    
    # handle the jump bitboard 
    var jump_bitboard = handle_jumping(piece_loc_bitboard, enemy_bitboard)
    possible_moves = BoardFunctions.LOGICAL_OR(possible_moves, jump_bitboard)

    # Remove any positions which already have pieces on them by AND'ing the 
    # board with the compliment of each side 
    var inverted_board = BoardFunctions.LOGICAL_NOT(own_side_bitboard)
    var inverted_enemy = BoardFunctions.LOGICAL_NOT(enemy_bitboard)
    
    
    var temp_valid_moves = BoardFunctions.LOGICAL_AND(possible_moves, inverted_board)
    var valid_moves = BoardFunctions.LOGICAL_AND(temp_valid_moves, inverted_enemy)
    return valid_moves

## @method handle_jumping - calculates the valid jumps for a given position, 
## returns a bitboard representing valid jumps the player can make 
## @param pos_bitboard: Bitboard - the bitboard representing the position of the
## jumping piece 
## @param enemy_bitboard: Bitboard - the bitboard representing the position of
## the enemy piece 
## @returns a bitboard representing the valid jumps the player can do 
func handle_jumping(pos_bitboard, enemy_bitboard): 
    # values to ensure 
    #var piece_clip_file_b = BoardFunctions.LOGICAL_AND(pos_bitboard, bitboardFunctions.PIECE_TABLE[1])
    #var piece_clip_file_g = BoardFunctions.LOGICAL_AND(pos_bitboard, bitboardFunctions.PIECE_TABLE[6])
    var piece_clip_file_h = BoardFunctions.LOGICAL_AND(pos_bitboard, bitboardFunctions.CLEAR_FILE[7])
    var piece_clip_file_a = BoardFunctions.LOGICAL_AND(pos_bitboard, bitboardFunctions.CLEAR_FILE[0])
    
    var val_to_return = Bitboard.new()
    val_to_return.set_state(false, 0)
    
    var left_spot = BoardFunctions.multiple_shift_left(piece_clip_file_a, 7)
    var right_spot = BoardFunctions.multiple_shift_left(piece_clip_file_h, 9)
    # the player can only jump enemies so mask everyone but the enemies 
    var is_left = BoardFunctions.LOGICAL_AND(enemy_bitboard, left_spot)
    var is_right = BoardFunctions.LOGICAL_AND(enemy_bitboard, right_spot)
    # shift it so we can check if it is occupied

    # shift them so we can check if the lsb is equal to 1
    is_left = BoardFunctions.multiple_shift_right(is_left, 7 + piece_index)
    is_right = BoardFunctions.multiple_shift_right(is_right, 9 + piece_index)
    

    if is_left.get_lsb() == 1:
        # there is a piece to the left, we must check if we can jump it 
        # we will AND the piece board to ensure it is not on an overflow row
        piece_clip_file_a = BoardFunctions.LOGICAL_AND(piece_clip_file_a, bitboardFunctions.CLEAR_FILE[1])
        # shift it 14 digits to the left in order to get the jump square
        left_spot = BoardFunctions.multiple_shift_left(piece_clip_file_a, 14)
        val_to_return = BoardFunctions.LOGICAL_OR(left_spot, val_to_return)
    if is_right.get_lsb() == 1:
        piece_clip_file_h = BoardFunctions.LOGICAL_AND(piece_clip_file_h, bitboardFunctions.CLEAR_FILE[6])
        right_spot = BoardFunctions.multiple_shift_left(piece_clip_file_h, 18)
        val_to_return = BoardFunctions.LOGICAL_OR(right_spot, val_to_return)

    return val_to_return


# virtual function inherited from parent class
func get_left_move_piece_board(): 
    var pos_bitboard = bitboardFunctions.PIECE_TABLE[piece_index]
    var piece_clip_file_a = BoardFunctions.LOGICAL_AND(pos_bitboard, bitboardFunctions.CLEAR_FILE[0])
    var left_spot = BoardFunctions.multiple_shift_left(piece_clip_file_a, 7)
    return left_spot

func get_right_move_piece_board():
    var pos_bitboard = bitboardFunctions.PIECE_TABLE[piece_index]
    var piece_clip_file_h = BoardFunctions.LOGICAL_AND(pos_bitboard, bitboardFunctions.CLEAR_FILE[7])
    var right_spot = BoardFunctions.multiple_shift_left(piece_clip_file_h, 9)
    return right_spot





