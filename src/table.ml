open Csv

type t = string list list

let rec transpose_table (table : Csv.t) (n : int) : Csv.t =
  if n = List.length (List.nth table 0) then []
  else
    List.map (fun x -> List.nth x n) table
    :: transpose_table table (n + 1)

let select table (col_names : string list) =
  transpose_table
    (List.filter
       (fun x -> List.mem (List.nth x 0) col_names)
       (transpose_table table 0))
    0

let select_all tables name =
  List.find (fun x -> fst x = name) tables |> snd

let create_table fname =
  Csv.save ("data" ^ Filename.dir_sep ^ fname ^ ".csv") []

let drop_table tables name = List.filter (fun x -> fst x <> name) tables

let update t col vals cond =
  raise (Stdlib.Failure "Unimplemented: Table.update_table")

let load_table fname =
  Csv.load ("data" ^ Filename.dir_sep ^ fname ^ ".csv")

let insert (fname : string) (cols : string list) (vals : string list) =
  if List.length cols = List.length vals then
    Csv.save
      ("data" ^ Filename.dir_sep ^ fname ^ ".csv")
      (load_table fname @ [ vals ])
  else raise (Stdlib.Failure "Columns do not match values")

let swap_rows t =
  raise (Stdlib.Failure "Unimplemented: Table.drop_table")

let swap_cols t =
  raise (Stdlib.Failure "Unimplemented: Table.drop_table")
