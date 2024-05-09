fn merge_sort(inout arr: List[Int]) -> List[Int]:
    if len(arr) <= 1:
        return arr
    var mid = len(arr) // 2
    var Le = List[Int](arr[:mid])
    var Ri = List[Int](arr[mid:])

    var sort_left = merge_sort(Le)
    var sort_right = merge_sort(Ri)
    var out_array:List[Int] = run_sort(sort_left, sort_right)
    return out_array

fn run_sort(inout left: List[Int], inout right: List[Int]) -> List[Int]:
    var out_arr = List[Int]()
    var i: Int = 0
    var j: Int = 0

    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            out_arr.append(left[i])
            i += 1
        else:
            out_arr.append(right[j])
            j += 1

    out_arr.extend(left[i:])
    out_arr.extend(right[j:])

    return out_arr


def main():
    var array: List[Int] = List[Int](1,2,5,3,9,1,14,22,1,14)
    print(array.__str__())
    var sorted_array = merge_sort(array)
    print(sorted_array.__str__())
