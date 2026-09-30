type linear_constraint = {
  coeffs : (string * Z.t) list;
  bound : Z.t;
}

type result =
  | Sat of (string * Z.t) list
  | Unsat of (string * Z.t) list list
  | Unknown

let normalize_assignment bounds assignment =
  List.map
    (fun (name, _, _) ->
      match List.assoc_opt name assignment with
      | Some v -> (name, v)
      | None -> invalid_arg ("missing variable: " ^ name))
    bounds

let eval_constraint assignment c =
  let lhs =
    List.fold_left
      (fun acc (name, coeff) ->
        let value =
          match List.assoc_opt name assignment with
          | Some v -> v
          | None -> invalid_arg ("missing variable: " ^ name)
        in
        Z.add acc (Z.mul coeff value))
      Z.zero c.coeffs
  in
  Z.compare lhs c.bound <= 0

let satisfies assignment constraints =
  List.for_all (eval_constraint assignment) constraints

let rec enumerate_bounds bounds =
  match bounds with
  | [] -> [[]]
  | (name, lo, hi) :: rest ->
      if Z.compare lo hi > 0 then []
      else
        let rec range n =
          if Z.compare n hi > 0 then []
          else n :: range (Z.succ n)
        in
        let tails = enumerate_bounds rest in
        List.concat_map
          (fun value ->
            List.map (fun tail -> (name, value) :: tail) tails)
          (range lo)

let decide_bounded ~bounds constraints =
  let names = List.map (fun (n, _, _) -> n) bounds in
  let duplicates =
    let sorted = List.sort String.compare names in
    let rec has_dup = function
      | a :: (b :: _ as rest) -> a = b || has_dup rest
      | _ -> false
    in
    has_dup sorted
  in
  if duplicates then invalid_arg "duplicate variable in bounds";
  let bounded_names = List.sort String.compare names in
  let used_names =
    constraints
    |> List.concat_map (fun c -> List.map fst c.coeffs)
    |> List.sort_uniq String.compare
  in
  if List.exists (fun n -> not (List.mem n bounded_names)) used_names then
    invalid_arg "constraint references a variable without bounds";
  if List.exists (fun (_, lo, hi) -> Z.compare lo hi > 0) bounds then
    Unsat []
  else
    let assignments = enumerate_bounds bounds in
    match List.find_opt (fun a -> satisfies a constraints) assignments with
    | Some a -> Sat (normalize_assignment bounds a)
    | None -> Unsat assignments
