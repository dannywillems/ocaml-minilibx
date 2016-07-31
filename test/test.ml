let () =
  let i = Minilibx.Core.init () in
  let w = Minilibx.Window.new_ i 640 480 "Hello, World" in
  Minilibx.Window.loop i
