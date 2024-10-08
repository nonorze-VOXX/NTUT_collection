def ans(vec, maxx, tmp):
    for i in range(maxx, tmp):
        vec.append(vec[i]+vec[i-1])
    return vec[tmp]


def main():
    maxx = 2
    vec = [0, 1, 1]
    while(True):
        tmp = int(input())
        if tmp == -1:
            break
        if tmp > maxx:
            print(ans(vec, maxx, tmp))
            maxx = tmp
        else:
            print(vec[tmp])


main()
