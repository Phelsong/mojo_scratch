import os
from pathlib import Path


fn main():
    var home: Path = Path(os.getenv("HOME"))
    var recent_cache: Path = home.joinpath(".local/share/recently-used.xbel")
    try:
        with open(recent_cache, "w") as fi:
            fi.write(String(""))
            var blank: String = ""
            fi.write(blank)
    except Exception:
        print("error")
        