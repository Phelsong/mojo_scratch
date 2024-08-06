""" batch copier script"""

import os
import sys
from pathlib import Path
from csv_reader import CsvReader


# ------------------------------------------------------------------------------
fn hunter_copy(owned in_csv: String, owned out_dir: String, owned search_dir: String,
    owned
    verbose: Bool = True):
    """Copies files based on a (single column csv) list of search elements"""
    try:
        var work_dir: List[String] = os.listdir(search_dir)
        var case_exists:Bool = False
        # ----------------------------
        with open(in_csv, "r") as csvfile:
            var reader = CsvReader(csvfile.read(), delimiter=",", quotechar="|")

            for query in reader:
                for item in work_dir:
                    # search thru items in dir for string (id) in CSV
                    ### !! re doesnt exist yet
                    var matched = re.search(query[0], item)
                    if matched is not None:
                        case_exists = True
                        var match: Path = Path(search_dir).join("\\").join(item)
                        var out: Path = Path(out_dir).join("\\").join(item)
                        with open(match, "r") as match_file:
                            with open(out, "w") as out_file:
                                out_file.write(match_file.read)
                        if verbose is True:
                            print(
                                "Copied: ".add(search_dir).add("\\").add(item).add("to: "
                                    "").add(out_dir).add("\\").add(item)
                            )

                # write not copied
                if case_exists is False:
                    print(query[0], file=open(".\\not_found.csv", "a"))
                else:
                    case_exists = False
    except Exception:
        pass

# -----------------------------------------------------------------------------------

fn main():
    try:
        in_csv = sys.argv[1]
        out_dir = sys.argv[2]
        search_dir = sys.argv[3]
        # verbose = True if sys.argv[4] == "--verbose" else False
        hunter_copy(
            in_csv=in_csv,
            out_dir=out_dir,
            search_dir=search_dir,
        )
    except IndexError:
        print("Usage: hc.exe <in_csv> <out_dir> <search_dir> < --verbose(optional)>")
        print("Example: hc.exe .\\csv .\\out_dir_path .\\search_dir_path --verbose")
