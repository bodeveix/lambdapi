open Term

module type S = sig
  val app : term -> term list -> term
  val sym : Term.sym -> term
end

(** This adapter is intentionally small. Confirm [mk_Symb] and [add_args]
    against the exact Lambdapi checkout being used. *)
module Make () : S = struct
  let app f args = Term.add_args f args
  let sym s = Term.mk_Symb s
end
