open Term

(** Symbols are terms already resolved from the Lambdapi signature.
    Each field must have the exact type expected by the corresponding rule.
    This module type is a contract; it does not declare the symbols itself. *)
module type S = sig
  (* Logic *)
  val false_ : term
  val true_ : term
  val not_ : term
  val and_ : term
  val or_ : term
  val imp : term
  val iff : term
  val forall : term
  val exists : term

  val false_elim : term
  val not_intro : term
  val not_elim : term
  val and_intro : term
  val and_elim_left : term
  val and_elim_right : term
  val or_intro_left : term
  val or_intro_right : term
  val or_elim : term
  val imp_intro : term
  val imp_elim : term
  val iff_intro : term
  val iff_elim_left : term
  val iff_elim_right : term
  val forall_intro : term
  val forall_elim : term
  val exists_intro : term
  val exists_elim : term

  (* Integers and operations *)
  val zint : term
  val zero : term
  val one : term
  val of_integer : Z.t -> term
  val add : term
  val sub : term
  val mul : term
  val neg : term
  val eq : term
  val le : term
  val lt : term

  (* Equality and order *)
  val eq_refl : term
  val eq_sym : term
  val eq_trans : term
  val eq_subst : term
  val le_refl : term
  val le_trans : term
  val le_antisym : term
  val lt_trans : term
  val lt_irrefl : term
  val lt_le_trans : term
  val le_lt_trans : term
  val le_iff_lt_or_eq : term
  val lt_iff_succ_le : term

  (* Addition and multiplication *)
  val add_zero_left : term
  val add_zero_right : term
  val add_assoc : term
  val add_comm : term
  val add_cancel_left : term
  val add_cancel_right : term
  val add_le_mono : term
  val add_lt_mono : term
  val sub_def : term
  val neg_add_cancel : term
  val mul_zero_left : term
  val mul_zero_right : term
  val mul_one_left : term
  val mul_one_right : term
  val mul_assoc : term
  val mul_comm : term
  val mul_distrib_left : term
  val mul_distrib_right : term
  val mul_le_mono_nonneg : term
  val mul_lt_mono_pos : term
  val square_nonneg : term
  val le_mul_nonneg : term

  (* Integer-specific facts and divisibility *)
  val integer_discreteness : term
  val no_integer_between_consecutive : term
  val integer_unbounded_above : term
  val integer_unbounded_below : term
  val div : term
  val modulo : term
  val divides : term
  val congruent : term
  val div_mod_decomposition : term
  val modulo_bounds : term
  val modulo_zero_iff_divides : term
  val divides_refl : term
  val divides_trans : term
  val divides_add : term
  val divides_mul : term
  val congruent_refl : term
  val congruent_sym : term
  val congruent_trans : term
  val congruent_add : term
  val congruent_mul : term

  (* Cooper-elimination rules: exact theorem statements are theory-specific *)
  val normalize_linear_expression : term
  val normalize_inequality : term
  val normalize_equality : term
  val normalize_congruence : term
  val eliminate_positive_coefficient : term
  val eliminate_negative_coefficient : term
  val eliminate_equality_variable : term
  val cooper_lower_bound_cases : term
  val cooper_upper_bound_cases : term
  val cooper_no_bound_case : term
  val cooper_periodicity : term
  val cooper_finite_residue_cases : term
  val cooper_exists_equivalence : term

  (* Final contradiction and optional certificate soundness *)
  val contradiction_of_negative_bound : term
  val contradiction_of_incompatible_congruences : term
  val contradiction_of_integer_cut : term
  val certificate_soundness : term
  val certificate_unsat : term
end
