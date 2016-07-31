open Ctypes
open Foreign

type mlx_ptr = unit ptr
type mlx_win = unit ptr

let mlx_ptr : mlx_ptr typ = ptr void
let mlx_win : mlx_win typ = ptr void

let mlx_init =
  foreign "mlx_init" (void @-> returning mlx_ptr)

let mlx_new_window =
  foreign "mlx_new_window" (mlx_ptr @-> int @-> int @-> string @-> returning mlx_win)

let mlx_loop =
  foreign "mlx_loop" (mlx_ptr @-> returning void)
