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

    val loop : Core.t -> unit
  end

module Pixel :
  sig
    val put : Core.t -> Window.t -> int -> int -> int
  end
