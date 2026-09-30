type linear_constraint = {
  coeffs : (string * Z.t) list;
  bound : Z.t;
}

type result =
  | Sat of (string * Z.t) list
  | Unsat of (string * Z.t) list list
  | Unknown

(** Decide a conjunction of linear inequalities over variables with finite
    inclusive bounds. This is exhaustive enumeration, not a general unbounded
    Presburger decision procedure. *)
val decide_bounded :
  bounds:(string * Z.t * Z.t) list ->
  linear_constraint list ->
  result
