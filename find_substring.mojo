
fn find_substring(inout sir_str:String, inout substring:String)  -> Bool:
    sub_len: Int = len(substring)
    for x in len(sir_str):
        if sir_str[x] == substring[0]
            try:
                for y in sub_len:
                    assert substring[y] == sir_str[x+y]
                return True
            except AssertionError:
                continue
    return False