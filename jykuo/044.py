def main():
    spNum = input()
    sp2Num = input()
    headNum = input().split()
    newsix = input().split()
    n = int(input())
    ans = 0
    for i in range(n):
        tmp = input()
        tmpcountmax = 0
        tmpcount = 0
        for i in range(7, -1, -1):
            if tmp[i] == headNum[0][i]:
                tmpcount += 1
            else:
                break
        if tmpcount > tmpcountmax:
            tmpcountmax = tmpcount
        for i in range(7, -1, -1):
            if tmp[i] == headNum[1][i]:
                tmpcount += 1
            else:
                break
        if tmpcount > tmpcountmax:
            tmpcountmax = tmpcount
        for i in range(7, -1, -1):
            if tmp[i] == headNum[2][i]:
                tmpcount += 1
            else:
                break
        if tmpcount > tmpcountmax:
            tmpcountmax = tmpcount
        tmpcount = tmpcountmax
        if tmp == spNum:
            ans += 10000000
        elif tmp == sp2Num:
            ans += 2000000
        if tmpcount == 8:
            ans += 200000
        elif tmpcount == 7:
            ans += 40000
        elif tmpcount == 6:
            ans += 10000
        elif tmpcount == 5:
            ans += 4000
        elif tmpcount == 4:
            ans += 1000
        elif tmpcount == 3:
            ans += 200
        if newsix[0] == tmp[-3:]:
            ans += 200
        if newsix[1] == tmp[-3:]:
            ans += 200
        if newsix[2] == tmp[-3:]:
            ans += 200
    print(ans)


main()
