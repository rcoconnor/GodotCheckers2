extends "res://src/Piece.gd"

# returns whether or not a given move is legal from the current position 
# new_rank: the rank of where we are moving 
# new_file: the file of where we are moving 
# own_side_bitboard: the map of all allied pieces 
# enemy_bitboard: the map of all enemies
func compute_is_valid_move(new_rank, new_file, dark_pieces_bitboard, light_pieces_bitboard): 
    # Get the bitbaord representation of the move the player would like to make 
    #print("light piece calling!")
    var new_index: int = (8 * new_rank) + new_file
    var shifted_piece_table = bitboardFunctions.PIECE_TABLE[new_index]

    # Get the valid moves from the targets current position
    var valid_moves = compute_light_piece_valid_moves(light_pieces_bitboard, dark_pieces_bitboard)
    var is_valid = BoardFunctions.multiple_shift_right(BoardFunctions.LOGICAL_AND(shifted_piece_table, valid_moves), new_index) 
    if is_valid.get_board_state() == 1 && is_valid.get_msb() == false: 
        return true
    return false

func get_valid_moves(dark_pieces_bitboard, light_pieces_bitboard): 
    return compute_light_piece_valid_moves(light_pieces_bitboard, dark_pieces_bitboard)


func compute_light_piece_valid_moves(own_side_bitboard, enemy_bitboard):
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
    var inverted_enemy = BoardFunctions.LOGICAL_NOT(enemy_bitboard)

    var temp_valid_moves = BoardFunctions.LOGICAL_AND(possible_moves, inverted_board)
    var valid_moves = BoardFunctions.LOGICAL_AND(temp_valid_moves, inverted_enemy)

    return valid_moves


func handle_jumping(pos_bitboard, own_side_bitboard, enemy_bitboard): 
    var val_to_return = Bitboard.new()
    val_to_return.set_state(false, 0)
    var left_spot = BoardFunctions.multiple_shift_right(pos_bitboard, 9)
    var right_spot = BoardFunctions.multiple_shift_right(pos_bitboard, 7)
    
    # the player can only jump enemies so mask everyone but the enemies 
    var is_left = BoardFunctions.LOGICAL_AND(enemy_bitboard, left_spot)
    var is_right = BoardFunctions.LOGICAL_AND(enemy_bitboard, right_spot)

    is_left = BoardFunctions.multiple_shift_right(is_left, piece_index - 9)
    is_right = BoardFunctions.multiple_shift_right(is_right, piece_index - 7)

    if is_left.get_lsb() == 1:
        print("there should be a left jump")
        left_spot = BoardFunctions.multiple_shift_right(left_spot, 9)
        var temp = BoardFunctions.LOGICAL_OR(is_left, left_spot)
        val_to_return = BoardFunctions.LOGICAL_OR(temp, val_to_return)
    if is_right.get_lsb() == 1: 
        print("there hsould be a right jump")
        right_spot = BoardFunctions.multiple_shift_right(right_spot, 7)
        var temp = BoardFunctions.LOGICAL_OR(is_right, right_spot)
        val_to_return = BoardFunctions.LOGICAL_OR(temp, val_to_return)

    return val_to_return 




