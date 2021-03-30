extends Node2D

const Bitboard = preload("res://src/Bitboard.gd")


var _irst

var CLEAR_RANK = {  }

func _init(): 
    print("clear rank constructorr called")
    var first = Bitboard.new()
    first.set_state(true, 0x7FFFFFFFFFFFF00)
    print("first: ", first.to_string())
    CLEAR_RANK[0] = first
    print("clear: ", CLEAR_RANK[0].to_string())
    print("first: ", first.to_string())
    #var bitboard = Bitboard.new()
    #print("bitboard: ", bitboard.to_string())
    #CLEAR_RANK[0] = Bitboard.new().set_state(true, 0x7FFFFFFFFFFFF00)
    #CLEAR_RANK[0] = 1
    #print("clear: ", CLEAR_RANK[0])
