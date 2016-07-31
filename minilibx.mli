type mlx_ptr
type mlx_win

val mlx_ptr : mlx_ptr Ctypes.typ
val mlx_win : mlx_win Ctypes.typ

val mlx_init : unit -> mlx_ptr
val mlx_new_window : mlx_ptr -> int -> int -> string -> mlx_win

val mlx_loop : mlx_ptr -> unit
