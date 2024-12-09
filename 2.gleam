import gleam/io
import gleam/list
import gleam/int
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("2.txt")
  
  let lines = content
    |> string.trim()
    |> string.split(on: "\n")
  
  let formatted_reports = lines
    |> list.map(fn(line) {
      line
      |> string.split(on: " ")
      |> list.map(int.parse)
      |> list.filter_map(fn(x) { x })
    })

  let nb_of_reports_safe = formatted_reports
    |> list.fold(0, fn(acc, report) {
      case is_valid_report(report) {
        True -> acc + 1
        False -> acc
      }
    })

  io.println(int.to_string(nb_of_reports_safe))
}

fn is_valid_report(report) {
  case report {
    [] -> True
    [_] -> True
    [x, ..rest] -> {
      let pairs = list.window_by_2(report)
      let diffs = list.map(pairs, fn(pair) {
        case pair {
          #(a, b) -> b - a
        }
      })
      
      case check_diffs(diffs, None) {
        True -> True 
        False -> False
      }
    }
  }
}

fn check_diffs(diffs, direction) {
  case diffs {
    [] -> True
    [diff, ..rest] -> {
      let valid_range = int.absolute_value(diff) >= 1 && int.absolute_value(diff) <= 3
      
      case direction {
        None -> case valid_range {
          True -> check_diffs(rest, Some(diff))
          False -> False
        }
        Some(prev_dir) -> case valid_range && diff * prev_dir >= 0 {
          True -> check_diffs(rest, Some(diff)) 
          False -> False
        }
      }
    }
  }
}
