extends Node2D

const Bitboard = preload("res://src/Bitboard.gd")
const BoardFunctions = preload("res://src/Bitboard.gd")

export(PackedScene) var LightPiece
export(PackedScene) var DarkPiece

var dark_piece_state = Bitboard.new()
var light_piece_state = Bitboard.new()


# Member variables
var pieces_array = Array()


# important constants
const SPRITE_SIZE = 32

signal refreshed_screen

func _ready():
    dark_piece_state.set_state(false, 0x000000000055AA55)
    light_piece_state.set_state(true, 0x2A55AA0000000000)
    refresh_board()

func _process(_delta):
    pass


func clear_board(): 
    for each_piece in pieces_array:
        remove_child(each_piece)
        each_piece.queue_free()
    pieces_array = Array()


func refresh_board(): 
    clear_board()
    instance_pieces(DarkPiece, dark_piece_state)
    instance_pieces(LightPiece, light_piece_state)
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

func set_dark_piece_state(new_state): 
    print("old state: ", dark_piece_state.to_string())
    dark_piece_state = new_state
    print("new_state: ", dark_piece_state.to_string())

func get_dark_piece_state(): 
    return dark_piece_state
