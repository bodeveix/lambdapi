(** Abstract certificate syntax. A search procedure may produce this tree;
    a reconstruction backend translates it into Lambdapi terms. *)
type t =
  | Input of int
  | Linear_combination of Z.t list * t list
  | Integer_cut of t
  | Congruence_conflict of t list
  | Split of { variable : string; cases : t list }
  | Cooper_elimination of {
      variable : string;
      modulus : Z.t;
      residues : t list;
    }
  | Contradiction of t list
