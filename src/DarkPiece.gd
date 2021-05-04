extends "res://src/Piece.gd"


func compute_is_valid_move(new_rank, new_file, dark_pieces_bitboard, light_pieces_bitboard): 
    var new_index: int = (8 * new_rank) + new_file
    var shifted_piece_table = bitboardFunctions.PIECE_TABLE[new_index]

    var valid_moves = compute_dark_piece_valid_moves(dark_pieces_bitboard, light_pieces_bitboard)
    var is_valid = BoardFunctions.multiple_shift_right(BoardFunctions.LOGICAL_AND(shifted_piece_table, valid_moves), new_index)
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

    # check if the other side has a piece we can jump 
    var left_spot_shifted = BoardFunctions.multiple_shift_right(left_spot, piece_index + 7)
    print("left_spot: ", left_spot_shifted.to_string())
    print("lsb: ", left_spot_shifted.get_lsb())

    # Remove any positions which already have pieces on them by AND'ing the 
    # board with the compliment of each side 
    var inverted_board = BoardFunctions.LOGICAL_NOT(own_side_bitboard)
    var inverted_enemy = BoardFunctions.LOGICAL_NOT(enemy_bitboard)
    
    var temp_valid_moves = BoardFunctions.LOGICAL_AND(possible_moves, inverted_board)
    var valid_moves = BoardFunctions.LOGICAL_AND(temp_valid_moves, inverted_enemy)
   
    # handle the jumps 
    #var val = handle_jumping(piece_loc_bitboard, own_side_bitboard, enemy_bitboard)
#   var l_spot = BoardFunctions.multiple_shift_left(piece_loc_bitboard, 7)
#   print("lspt: ", l_spot.to_string())

#   # mask all positions except the position we care about 
#   var left_is_occupied = BoardFunctions.LOGICAL_AND(enemy_bitboard, l_spot)
#   # shift it right x positions
#   left_is_occupied = BoardFunctions.multiple_shift_right(left_is_occupied, 7 + piece_index)
#   print("left: ", left_is_occupied.to_string())
#   if(left_is_occupied.get_lsb() == 1): 
#       print("there should be a jump")
#       var temp = BoardFunctions.LOGICAL_OR(left_is_occupied, BoardFunctions.multiple_shift_left(left_spot, 7))
#       valid_moves = BoardFunctions.LOGICAL_OR(temp, valid_moves)
    print("valid moves before: ", valid_moves.to_string())
    valid_moves = BoardFunctions.LOGICAL_OR(valid_moves, handle_jumping(piece_loc_bitboard, own_side_bitboard, enemy_bitboard))
    print("valid moves after: ", valid_moves.to_string())
    return valid_moves

## @method handle_jumping - calculates the valid jump moves for a given position
## and further possible jumps
## @param pos_bitboard: Bitboard - the bitboard representing the position of the
## jumping piece 
## @param enemy_bitboard: Bitboard - the bitboard representing the position of
## the enemy piece 
## @returns the valid jumps the player can do 
func handle_jumping(pos_bitboard, own_side_bitboard, enemy_bitboard): 
    var val_to_return = Bitboard.new()
    val_to_return.set_state(false, 0)
    var left_spot = BoardFunctions.multiple_shift_left(pos_bitboard, 7)
    var right_spot = BoardFunctions.multiple_shift_left(pos_bitboard, 9)
    # the player can only jump enemies so mask everyone but the enemies 
    var is_left = BoardFunctions.LOGICAL_AND(enemy_bitboard, left_spot)
    var is_right = BoardFunctions.LOGICAL_AND(enemy_bitboard, right_spot)
    # shift it so we can check if it is occupied
    is_left = BoardFunctions.multiple_shift_right(is_left, 7 + piece_index)
    is_right = BoardFunctions.multiple_shift_right(is_right, 9 + piece_index)

    if is_left.get_lsb() == 1: 
        left_spot = BoardFunctions.multiple_shift_left(left_spot, 7)
        var temp = BoardFunctions.LOGICAL_OR(is_left, left_spot)
        val_to_return = BoardFunctions.LOGICAL_OR(temp, val_to_return)
    if is_right.get_lsb() == 1: 
        right_spot = BoardFunctions.multiple_shift_left(right_spot, 9)
        var temp = BoardFunctions.LOGICAL_OR(is_right, right_spot)
        val_to_return = BoardFunctions.LOGICAL_OR(temp, val_to_return)

    return val_to_return




