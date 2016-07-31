let () =
  let i = Minilibx.mlx_init () in
  let w = Minilibx.mlx_new_window i 640 480 "Hello, World" in
  Minilibx.mlx_loop i
