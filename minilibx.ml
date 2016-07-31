open Ctypes
open Foreign

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

    let loop =
      foreign "mlx_loop" (Core.t @-> returning void)
  end

module Pixel =
  struct
    let put =
      foreign
        "mlx_pixel_put"
        (Core.t @-> Window.t @-> int @-> int @-> returning int)
  end
(*
module Color =
  struct
    type t = int
    let t_of_int x = x
    let int_to_t x = x
  end
*)
