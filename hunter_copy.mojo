
import sys
import os
from pathlib import Path
from testing import assert_true, assert_raises
from mojo_csv import CsvReader
from find_substring import find_substring


# ------------------------------------------------------------------------------
fn hunter_copy(owned in_csv: String, owned search_dir: String, owned out_dir: String,
    owned verbose: Bool = False):
    try:
        var no_match_csv = open("./not_found.csv", "w")
        var work_dir: List[String] = os.listdir(search_dir)
        var case_exists: Bool = False
        # ----------------------------
        with open(in_csv, "r") as csvfile:
            var reader = CsvReader(csvfile.read(), delimiter=",", quotation_mark="|")
            for i in range(len(reader.elements)):
                # print(reader.elements[i])
                for k in range(len(work_dir)):
                    if find_substring(work_dir[k], reader.elements[i]):
                        case_exists=True
                        var matchee: Path = Path(search_dir).joinpath(work_dir[k])
                        var out: Path = Path(out_dir).joinpath(work_dir[k])
                        with open(matchee, "r") as match_file:
                            with open(out, "w") as out_file:
                                out_file.write(match_file.read())
                        if verbose:
                            print(
                                String("Copied: {} to: {}").format(matchee, out)
                            )
                        break
                if case_exists == False and len(reader.elements[i])>0:
                    print(reader.elements[i], end=",\n", file=no_match_csv)
                else:
                    case_exists = False
        no_match_csv.close()
    except Exception:
        if verbose:
            print("unknown error")
        pass

# -----------------------------------------------------------------------------------

fn main():
    try:
        var in_args: Int8 =(len(sys.argv()))
        assert_true(in_args >= 3)
        var in_csv = sys.argv()[1]
        var search_dir = sys.argv()[2]
        var out_dir = sys.argv()[3]
        if sys.argv()[4] == "--verbose" or sys.argv()[4] == "-v":
            hunter_copy(
                in_csv=in_csv,
                out_dir=out_dir,
                search_dir=search_dir,
                verbose=True
            )
        else:
            hunter_copy(
                in_csv=in_csv,
                out_dir=out_dir,
                search_dir=search_dir,
            )
    except AssertionError:
        print("Usage: hc.exe <in_csv> <out_dir> <search_dir> < --verbose(optional)>")
        print("Example: hc.exe ./csv ./out_dir_path ./search_dir_path --verbose")
