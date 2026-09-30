open Term

module type S = sig
  (** Return a proof term of the negation of the conjunction of the input
      constraints under a concrete assignment. *)
  val excluded_assignment :
    assignment:(string * Z.t) list -> term

  (** Given proofs excluding every assignment in the finite box, return a
      term proving False from the original constraints. This requires a
      genuine finite-domain exhaustion theorem in the target theory. *)
  val finite_exhaustion :
    bounds:(string * Z.t * Z.t) list ->
    exclusions:term list ->
    term
end
