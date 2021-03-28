extends Reference

const Bitboard = preload("res://src/Bitboard.gd")

# Bitboard Functions Class
# This class implements static helper functions for the Bitboard class

static func LOGICAL_OR(first_bitboard, second_bitboard): 
    var new_msb = first_bitboard.get_msb() || second_bitboard.get_msb()
    var new_state = first_bitboard.get_board_state() | second_bitboard.get_board_state()
    var new_board = Bitboard.new()
    new_board.set_state(new_msb, new_state)
    return new_board

static func LOGICAL_AND(first_bitboard, second_bitboard): 
    var new_msb = first_bitboard.get_msb() && second_bitboard.get_msb()
    var new_state = first_bitboard.get_board_state() & second_bitboard.get_board_state()
    var new_board = Bitboard.new()
    new_board.set_state(new_msb, new_state)
    return new_board

