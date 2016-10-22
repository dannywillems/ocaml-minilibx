open Ctypes
open Foreign

exception Bad_coordinate

type mlx_core = unit ptr

module Core =
  struct
    type t = unit ptr

    let t : t typ = ptr void

    let init =
      foreign "mlx_init" (void @-> returning t)
  end

module Window =
  struct
    type t = unit ptr

    let t : t typ = ptr void

    let new_ =
      foreign
        "mlx_new_window"
        (Core.t @-> int @-> int @-> string @-> returning t)

    let clear =
      foreign
        "mlx_clear_window"
        (t @-> Core.t @-> returning int)

    let destroy =
      foreign
        "mlx_destroy_window"
        (t @-> Core.t @-> returning void)
  end

module Event =
  struct
    module Param =
      struct
        type 'a t = 'a Ctypes_static.structure Ctypes_static.ptr

        (*let empty struct_name = Ctypes.ptr (structure struct_name)*)

        let create_field param name typ =
          field param name typ

        let set_field param field value =
          Ctypes.setf param field value
      end

    let hook_function = void @-> returning int

    let loop =
      foreign "mlx_loop" (Core.t @-> returning void)

    let key_hook_internal =
      foreign "mlx_key_hook"
      (Window.t @-> funptr hook_function @-> ptr void @-> returning int)

    let key_hook win f param =
      key_hook_internal win f (to_voidp param)

    let mouse_hook_internal =
      foreign "mlx_key_hook"
      (Window.t @-> funptr hook_function @-> ptr void @-> returning int)

    let mouse_hook win f param =
      key_hook_internal win f (to_voidp param)

    let expose_hook_internal =
      foreign "mlx_mouse_hook"
      (Window.t @-> funptr hook_function @-> ptr void @-> returning int)

    let expose_hook win f param =
      key_hook_internal win f (to_voidp param)

    let loop_hook_internal =
      foreign "mlx_loop_hook"
      (Window.t @-> funptr hook_function @-> ptr void @-> returning int)

    let loop_hook win f param =
      key_hook_internal win f (to_voidp param)
  end

module String =
  struct
    let put_internal =
      foreign
        "mlx_string_put"
        (Core.t @-> Window.t @-> int @-> int @-> int @-> string @-> returning void)

    let put core window ~x ~y ~color str =
      put_internal core window x y color str
  end

module Pixel =
  struct
    let put =
      foreign
        "mlx_pixel_put"
        (Core.t @-> Window.t @-> int @-> int @-> int @-> returning void)

    let get_color_value=
      foreign
        "mlx_get_color_value"
        (Core.t @-> int @-> returning uint)

    let draw_horizontal_line core window ~x ~y ~length ~color =
      let rec aux current_x =
        if current_x >= x + length then ()
        else
        (
          ignore (put core window current_x y color);
          aux (current_x + 1)
        )
      in
      if length >= 0 then aux x

    let draw_vertical_line core window ~x ~y ~length ~color =
      let rec aux current_y =
        if current_y >= y + length then ()
        else
        (
          ignore (put core window x current_y color);
          aux (current_y + 1)
        )
      in
      if length >= 0 then aux y

    let draw_rectangle core window ~x ~y ~length_x ~length_y ~color =
      let rec aux current_y =
        if current_y >= y + length_y then ()
        else
        (
          ignore
          (
            draw_horizontal_line
              core
              window
              ~x
              ~y:current_y
              ~length:length_x
              ~color
          );
          aux (current_y + 1)
        )
      in
      if length_x >= 0 && length_y >= 0 then aux y

    let draw_square core window ~x ~y ~length ~color =
      draw_rectangle core window ~x ~y ~length_x:length ~length_y:length ~color

  end

module Image =
  struct
    type t = unit ptr

    let t : t typ = ptr void

    let new_ =
      foreign
        "mlx_new_image"
        (Core.t @-> int @-> int @-> returning t)

    let put_to_window =
      foreign
        "mlx_put_image_to_window"
        (Core.t @-> Window.t @-> t @-> int @-> int @-> returning int)
  end

module Key =
  struct
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

    let to_int = function
    | MLX_KEY_LEFT          -> 65361
    | MLX_KEY_RIGHT         -> 65363
    | MLX_KEY_UP            -> 65362
    | MLX_KEY_DOWN          -> 65364
    | MLX_KEY_ESC           -> 65307
    | MLX_KEY_TAB           -> 65289
    | MLX_KEY_INS           -> 65379
    | MLX_KEY_HOME          -> 65360
    | MLX_KEY_PGUP          -> 65365
    | MLX_KEY_PGDN          -> 65366
    | MLX_KEY_END           -> 65367
    | MLX_KEY_DEL           -> 65535
    | MLX_KEY_BACKSPACE     -> 65288
    | MLX_KEY_ENTER         -> 65293
    | MLX_KEY_SHIFT         -> 65505
    | MLX_KEY_CAPS          -> 65509
    | MLX_KEY_CTRL          -> 65507
    | MLX_KEY_ALT           -> 65513
    | MLX_KEY_F1            -> 65470
    | MLX_KEY_F2            -> 65471
    | MLX_KEY_F3            -> 65472
    | MLX_KEY_F4            -> 65473
    | MLX_KEY_F5            -> 65474
    | MLX_KEY_F6            -> 65475
    | MLX_KEY_F7            -> 65476
    | MLX_KEY_F8            -> 65477
    | MLX_KEY_F9            -> 65478
    | MLX_KEY_F10           -> 65479
    | MLX_KEY_F11           -> 65480
    | MLX_KEY_F12           -> 65481
    | MLX_KEY_PRINT_SCREEN  -> 65377
    | MLX_KEY_NUM_LOCK      -> 65407
    | MLX_KEY_PAUSE         -> 65299
    | MLX_KEY_WINDOWS       -> 65515
    | MLX_KEY_MINUS         -> 45
    | MLX_KEY_EQUAL         -> 61
    | MLX_KEY_SPACE         -> 32
    | MLX_KEY_0             -> 48
    | MLX_KEY_1             -> 49
    | MLX_KEY_2             -> 50
    | MLX_KEY_3             -> 51
    | MLX_KEY_4             -> 52
    | MLX_KEY_5             -> 53
    | MLX_KEY_6             -> 54
    | MLX_KEY_7             -> 55
    | MLX_KEY_8             -> 56
    | MLX_KEY_9             -> 57
    | MLX_KEY_A             -> 97
    | MLX_KEY_B             -> 98
    | MLX_KEY_C             -> 99
    | MLX_KEY_D             -> 100
    | MLX_KEY_E             -> 101
    | MLX_KEY_F             -> 102
    | MLX_KEY_G             -> 103
    | MLX_KEY_H             -> 104
    | MLX_KEY_I             -> 105
    | MLX_KEY_J             -> 106
    | MLX_KEY_K             -> 107
    | MLX_KEY_L             -> 108
    | MLX_KEY_M             -> 109
    | MLX_KEY_N             -> 110
    | MLX_KEY_O             -> 111
    | MLX_KEY_P             -> 112
    | MLX_KEY_Q             -> 113
    | MLX_KEY_R             -> 114
    | MLX_KEY_S             -> 115
    | MLX_KEY_T             -> 116
    | MLX_KEY_U             -> 117
    | MLX_KEY_V             -> 118
    | MLX_KEY_W             -> 119
    | MLX_KEY_X             -> 120
    | MLX_KEY_Y             -> 121
    | MLX_KEY_Z             -> 122
    | MLX_KEY_TIDLE         -> 96
    | MLX_MOD_NONE          -> 0
    | MLX_MOD_SHIFT         -> 1
    | MLX_MOD_CAPS          -> 2
    | MLX_MOD_CTRL          -> 4
    | MLX_MOD_ALT           -> 8
    | Unknown               -> 3

    let of_int = function
      | 65361   -> MLX_KEY_LEFT
      | 65363   -> MLX_KEY_RIGHT
      | 65362   -> MLX_KEY_UP
      | 65364   -> MLX_KEY_DOWN
      | 65307   -> MLX_KEY_ESC
      | 65289   -> MLX_KEY_TAB
      | 65379   -> MLX_KEY_INS
      | 65360   -> MLX_KEY_HOME
      | 65365   -> MLX_KEY_PGUP
      | 65366   -> MLX_KEY_PGDN
      | 65367   -> MLX_KEY_END
      | 65535   -> MLX_KEY_DEL
      | 65288   -> MLX_KEY_BACKSPACE
      | 65293   -> MLX_KEY_ENTER
      | 65505   -> MLX_KEY_SHIFT
      | 65509   -> MLX_KEY_CAPS
      | 65507   -> MLX_KEY_CTRL
      | 65513   -> MLX_KEY_ALT
      | 65470   -> MLX_KEY_F1
      | 65471   -> MLX_KEY_F2
      | 65472   -> MLX_KEY_F3
      | 65473   -> MLX_KEY_F4
      | 65474   -> MLX_KEY_F5
      | 65475   -> MLX_KEY_F6
      | 65476   -> MLX_KEY_F7
      | 65477   -> MLX_KEY_F8
      | 65478   -> MLX_KEY_F9
      | 65479   -> MLX_KEY_F10
      | 65480   -> MLX_KEY_F11
      | 65481   -> MLX_KEY_F12
      | 65377   -> MLX_KEY_PRINT_SCREEN
      | 65407   -> MLX_KEY_NUM_LOCK
      | 65299   -> MLX_KEY_PAUSE
      | 65515   -> MLX_KEY_WINDOWS
      | 45      -> MLX_KEY_MINUS
      | 61      -> MLX_KEY_EQUAL
      | 32      -> MLX_KEY_SPACE
      | 48      -> MLX_KEY_0
      | 49      -> MLX_KEY_1
      | 50      -> MLX_KEY_2
      | 51      -> MLX_KEY_3
      | 52      -> MLX_KEY_4
      | 53      -> MLX_KEY_5
      | 54      -> MLX_KEY_6
      | 55      -> MLX_KEY_7
      | 56      -> MLX_KEY_8
      | 57      -> MLX_KEY_9
      | 97      -> MLX_KEY_A
      | 98      -> MLX_KEY_B
      | 99      -> MLX_KEY_C
      | 100     -> MLX_KEY_D
      | 101     -> MLX_KEY_E
      | 102     -> MLX_KEY_F
      | 103     -> MLX_KEY_G
      | 104     -> MLX_KEY_H
      | 105     -> MLX_KEY_I
      | 106     -> MLX_KEY_J
      | 107     -> MLX_KEY_K
      | 108     -> MLX_KEY_L
      | 109     -> MLX_KEY_M
      | 110     -> MLX_KEY_N
      | 111     -> MLX_KEY_O
      | 112     -> MLX_KEY_P
      | 113     -> MLX_KEY_Q
      | 114     -> MLX_KEY_R
      | 115     -> MLX_KEY_S
      | 116     -> MLX_KEY_T
      | 117     -> MLX_KEY_U
      | 118     -> MLX_KEY_V
      | 119     -> MLX_KEY_W
      | 120     -> MLX_KEY_X
      | 121     -> MLX_KEY_Y
      | 122     -> MLX_KEY_Z
      | 96      -> MLX_KEY_TIDLE
      | 0       -> MLX_MOD_NONE
      | 1       -> MLX_MOD_SHIFT
      | 2       -> MLX_MOD_CAPS
      | 4       -> MLX_MOD_CTRL
      | 8       -> MLX_MOD_ALT
      | _       -> Unknown
  end
