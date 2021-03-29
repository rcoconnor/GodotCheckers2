extends Node2D

const Bitboard = preload("res://src/Bitboard.gd")
const BoardFunctions = preload("res://src/Bitboard.gd")

export(PackedScene) var LightPiece
export(PackedScene) var DarkPiece

var dark_piece_state = Bitboard.new()
var light_piece_state = Bitboard.new()

# Member variables
var pieces = Array()



func _ready():
    dark_piece_state.set_state(false, 0x000000000055AA55)
    light_piece_state.set_state(true, 0x2A55AA0000000000)
    instance_pieces(DarkPiece, dark_piece_state)
    instance_pieces(LightPiece, light_piece_state)

func _process(_delta):
    pass


func instance_pieces(node_to_instance, state): 
    var temp_board = Bitboard.new()
    temp_board.set_state(state.get_msb(), state.get_board_state())
    for rank in range(8): 
        for file in range(8): 
            #print("getLSB: ", temp_board.get_lsb())
            if (temp_board.get_lsb() == 1): 
                var new_piece = node_to_instance.instance()
                new_piece.position = Vector2(file * new_piece.scale.x * 32, (7-rank) * new_piece.scale.y * 32)
                add_child(new_piece)
                new_piece.set_owner(self)
            temp_board.shift_right()
        
        


