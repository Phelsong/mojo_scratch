from collections import Dict, List

# item1,"ite,m2",item3


@value
struct CsvReader:
    # var data: Dict[String,String]
    var headers: List[String]
    var rows: List[List[String]]
    var raw: String
    var delimiter: String
    var CR: String
    var LF: String
    var QM: String
    var row_count: Int
    var col_count: Int

    fn __init__(
        inout self,
        owned in_str: String,
        delimiter: String = ",",
        quotation_mark: String = '"',
    ):
        self.raw = in_str
        self.delimiter = delimiter
        self.QM = quotation_mark
        self.CR = "\n"
        self.LF = "\r"
        self.row_count = 0
        self.col_count = 0
        self.headers = List(delimiter)
        self.rows = List(List(delimiter))
        self.create_reader()

    @always_inline
    fn create_reader(inout self):
        var length: Int = self.raw.__len__()
        var pos: Int = 0
        var row_start: Int = 0
        var col: Int = 0
        var col_start: Int = 0
        var in_quotes: Bool = False

        while pos < length:
            var char: String = self.raw[pos]
            print(pos, "char: ", char)
            # --------

            if in_quotes:
                if char != self.QM:
                    pos += 1
                    continue
                else:
                    in_quotes = False
                    pos += 1
                    continue

            if char == self.QM:
                in_quotes = True
                pos += 1
                continue
            # ignore any cases
            # --------

            if char == self.delimiter:
                self.rows[self.row_count][col] = self.raw[col_start:pos]

                col += 1
                col_start = pos + 1

                if self.row_count == 0:
                    self.col_count += 1

                print("delimiter: ", pos, self.raw[pos])

            # --------
            # case end of row
            elif char == self.CR:
                print("newline: ", char)
                # self.rows.resize(self.row_count + 1)
                self.rows[self.row_count][col] = self.raw[row_start:pos]

                if self.raw[pos + 1]:
                    print("new")
                    self.row_count += 1
                    col_start = pos + 1
                    row_start = pos + 1
                    col = 0
            pos += 1
            # -------
        # -------------
        print(self.rows[0][1])

    # ---------------------


def main():
    from pathlib import Path, cwd

    var test_csv = cwd().joinpath("test.csv")
    with open(test_csv, "r") as fi:
        try:
            var text = fi.read()
            var rd = CsvReader(text)
            print(rd.col_count)
        except:
            print("error")
