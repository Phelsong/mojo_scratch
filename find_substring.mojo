from testing import assert_true

fn find_substring(owned sir_str:String, owned substring:String) -> Bool:
    try:
        assert_true(len(sir_str) > 0)
        assert_true(len(substring) > 0)
        
        for x in range(len(sir_str)):
            if sir_str[x] == substring[0]:
                for y in range(len(substring)):
                    assert_true(substring[y] == sir_str[x+y])
                return True
                
    except AssertionError:
        return False
    return False
