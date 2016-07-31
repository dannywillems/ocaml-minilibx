module Color :
  sig
    type t

    val of_rgb : int -> int -> int -> t

    val to_int : t -> int

    val red : t -> int
    val green : t -> int
    val blue : t -> int
  end

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
    val loop : Core.t -> unit
  end

module Pixel :
  sig
    val put : Core.t -> Window.t -> int -> int -> int -> int

    val put_string : Core.t -> Window.t -> int -> int -> int -> int

    val get_color_value : Core.t -> Color.t -> Unsigned.uint
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
