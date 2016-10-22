module Core :
  sig
    type t

    val t : t Ctypes.typ

    val init : unit -> t
  end

module Window :
  sig
    type t

    val t : t Ctypes.typ

    val new_ : Core.t -> int -> int -> string -> t

    val clear : t -> Core.t -> int

    val destroy : t -> Core.t -> unit
  end

module Event :
  sig
    module Param :
      sig
        type 'a t

        (*val empty : string -> 'a t Ctypes.typ*)

        (*val create_field : t -> string -> 'a Ctypes.typ -> 'a Ctypes.field*)

        (*val set_field *)
      end

    val loop        :
      Core.t ->
      unit

    val key_hook    :
      Window.t         ->
      (unit -> int)    ->
      'a Param.t       ->
      unit

    val mouse_hook  :
      Window.t      ->
      (unit -> int) ->
      'a Param.t    ->
      unit

    val expose_hook :
      Window.t      ->
      (unit -> int) ->
      'a Param.t    ->
      unit

    val loop_hook   :
      Window.t      ->
      (unit -> int) ->
      'a Param.t    ->
      unit

  end

module String :
  sig
    (* Returns int normally but never used *)
    val put :
      Core.t ->
      Window.t ->
      x:int ->
      y:int ->
      color:int ->
      string    ->
      unit
  end

module Pixel :
  sig
    val put : Core.t -> Window.t -> int -> int -> int -> unit

    val get_color_value : Core.t -> int -> Unsigned.uint

    val draw_horizontal_line :
      Core.t     ->
      Window.t   ->
      x:int      ->
      y:int      ->
      length:int ->
      color:int  ->
      unit

    val draw_vertical_line :
      Core.t     ->
      Window.t   ->
      x:int      ->
      y:int      ->
      length:int ->
      color:int  ->
      unit

    val draw_rectangle          :
      Core.t     ->
      Window.t   ->
      x:int      ->
      y:int      ->
      length_x:int ->
      length_y:int ->
      color:int  ->
      unit

    val draw_square             :
      Core.t      ->
      Window.t    ->
      x:int ->
      y:int ->
      length:int ->
      color:int ->
      unit
  end

module Image :
  sig
    type t

    val t             : t Ctypes.typ

    val new_          :
      Core.t  ->
      int     ->
      int     ->
      t

    val put_to_window :
      Core.t    ->
      Window.t  ->
      t         ->
      int       ->
      int       ->
      int
  end

module Key :
  sig
    type t =
    | MLX_KEY_LEFT
    | MLX_KEY_RIGHT
    | MLX_KEY_UP
    | MLX_KEY_DOWN
    | MLX_KEY_ESC
    | MLX_KEY_TAB
    | MLX_KEY_INS
    | MLX_KEY_HOME
    | MLX_KEY_PGUP
    | MLX_KEY_PGDN
    | MLX_KEY_END
    | MLX_KEY_DEL
    | MLX_KEY_BACKSPACE
    | MLX_KEY_ENTER
    | MLX_KEY_SHIFT
    | MLX_KEY_CAPS
    | MLX_KEY_CTRL
    | MLX_KEY_ALT
    | MLX_KEY_F1
    | MLX_KEY_F2
    | MLX_KEY_F3
    | MLX_KEY_F4
    | MLX_KEY_F5
    | MLX_KEY_F6
    | MLX_KEY_F7
    | MLX_KEY_F8
    | MLX_KEY_F9
    | MLX_KEY_F10
    | MLX_KEY_F11
    | MLX_KEY_F12
    | MLX_KEY_PRINT_SCREEN
    | MLX_KEY_NUM_LOCK
    | MLX_KEY_PAUSE
    | MLX_KEY_WINDOWS
    | MLX_KEY_MINUS
    | MLX_KEY_EQUAL
    | MLX_KEY_SPACE
    | MLX_KEY_0
    | MLX_KEY_1
    | MLX_KEY_2
    | MLX_KEY_3
    | MLX_KEY_4
    | MLX_KEY_5
    | MLX_KEY_6
    | MLX_KEY_7
    | MLX_KEY_8
    | MLX_KEY_9
    | MLX_KEY_A
    | MLX_KEY_B
    | MLX_KEY_C
    | MLX_KEY_D
    | MLX_KEY_E
    | MLX_KEY_F
    | MLX_KEY_G
    | MLX_KEY_H
    | MLX_KEY_I
    | MLX_KEY_J
    | MLX_KEY_K
    | MLX_KEY_L
    | MLX_KEY_M
    | MLX_KEY_N
    | MLX_KEY_O
    | MLX_KEY_P
    | MLX_KEY_Q
    | MLX_KEY_R
    | MLX_KEY_S
    | MLX_KEY_T
    | MLX_KEY_U
    | MLX_KEY_V
    | MLX_KEY_W
    | MLX_KEY_X
    | MLX_KEY_Y
    | MLX_KEY_Z
    | MLX_KEY_TIDLE
    | MLX_MOD_NONE
    | MLX_MOD_SHIFT
    | MLX_MOD_CAPS
    | MLX_MOD_CTRL
    | MLX_MOD_ALT
    | Unknown
  end
