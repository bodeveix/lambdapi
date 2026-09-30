open Term

module type S = sig
  val app : term -> term list -> term
  val sym : Term.sym -> term
end
