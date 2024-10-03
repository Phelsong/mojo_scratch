from testing import assert_true
from merge_sort import merge_sort

fn uniqueOccurrences(inout in_arr: List[Int]) -> Bool:
    var arr = merge_sort(in_arr)
    var results = Set[Int]()
    var count: Int = 1
    for x in range(len(arr)):
        try:
            assert_true(arr[x] == arr[x - 1])
            count += 1
        except AssertionError:
            if x == 0 and len(arr) > 2:
                continue
            try:
                assert_true(count not in results)
                results.add(count)
                count = 1
            except AssertionError:
                return False
    else:
        if count in results:
            return False
    return True


fn main():
    var arr = List[Int](1,2,5,3,9,1,14,22,1,14)
    print(uniqueOccurrences(arr))
    var t_arr = List[Int](1,2,5,2,5,5,5,5,3,3,3)
    print(uniqueOccurrences(t_arr))