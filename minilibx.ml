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

module Color =
  struct
    type t =
      {
        r : int;
        g : int;
        b : int
      }

    let of_rgb r g b = {r = r; g = g; b = b}

    (* TODO *)
    let to_int x = x.r

    let red x = x.r
    let green x = x.g
    let blue x = x.b
  end

module Event =
  struct
    let loop =
      foreign "mlx_loop" (Core.t @-> returning void)
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

module Pixel =
  struct
    let put =
      foreign
        "mlx_pixel_put"
        (Core.t @-> Window.t @-> int @-> int @-> int @-> returning int)

    let put_string =
      foreign
        "mlx_string_put"
        (Core.t @-> Window.t @-> int @-> int @-> int @-> returning int)

    let get_color_value_internal =
      foreign
        "mlx_get_color_value"
        (Core.t @-> int @-> returning uint)

    let get_color_value ptr color =
        get_color_value_internal ptr (Color.to_int color)
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
