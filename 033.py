def check(tmp0, tmp1):
    if tmp1 == 0:
        return tmp0
    return check(tmp1, tmp0 % tmp1)


def main():
    while(True):
        tmp = input()
        if tmp == "-1":
            break
        tmp = tmp.split()
        tmp0 = int(tmp[0])
        tmp1 = int(tmp[1])
        tmp2 = int(tmp[2])
        maxx = tmp0
        anss = check(check(tmp0, tmp1), check(tmp1, tmp2))
        print(anss)


main()
