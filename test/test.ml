let () =
  let i = Minilibx.Core.init () in
  let w = Minilibx.Window.new_ i 1020 480 "Hello, World" in
  Minilibx.String.put i w ~x:100 ~y:100 ~color:0xFF0000 "Hello World";
  Minilibx.Pixel.draw_horizontal_line
    i w ~x:10 ~y:10 ~length:100 ~color:0x00FFFF;
  Minilibx.Pixel.draw_vertical_line
    i w ~x:10 ~y:10 ~length:100 ~color:0x00FFFF;
  Minilibx.Pixel.draw_rectangle
    i w ~x:150 ~y:150 ~length_x:100 ~length_y:100 ~color:0x0000FF;
  Minilibx.Pixel.draw_square
    i w ~x:250 ~y:250 ~length:100 ~color:0xFF00FF;
  Minilibx.Event.loop i
