def rotate_array(inout arr: List[Int], owned rotation: Int) -> None:
    var ro = rotation % len(arr)
    arr = arr[-ro:] + arr[:-ro]


fn main():
    var arr = List[Int](1, 2, 5, 3, 9, 1, 14, 22, 1, 14)
    print(arr.__str__())
    try:
        rotate_array(arr, 4)
    except:
        pass
    print(arr.__str__())
