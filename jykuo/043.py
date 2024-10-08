def main():
    n = int(input())
    if n > 10:
        n = 10
    vec = nyuryoku(n)
    # print(vec)
    shiken = input().split()
    shiken.append("+")

    ans = [0 for i in range(n)]
    for i in range(n):
        ans[i] = shikenFun(shiken, vec, i)
    schools = [(vec[i][0], ans[i]) for i in range(n)]

    schools = sorted([school for school in schools if school[1]
                     != "0"], key=lambda x: x[1], reverse=True)
    print(" ".join([",".join(i) for i in schools]))


def nyuryoku(n: int):
    vec = [[''] for i in range(10)]
    for i in range(n):
        tmp = input().split()
        vec[i][0] = tmp[0]
        for j in range(1, len(tmp)):
            vec[i].append(tmp[j])
    return vec


def shikenFun(shiken, vec, index):
    ans = 0
    flag = 1
    for i in range(len(shiken)):
        if shiken[i] == '+':
            ans += flag
            flag = 1
        else:
            b = 0
            if shiken[i][0] == '!':
                b = 1
            for j in range(1, len(vec[index])):
                if b:
                    if vec[index][j] == shiken[i][1:]:
                        flag *= 0
                else:
                    if shiken[i] in vec[index]:
                        flag *= 1
                    else:
                        flag *= 0
    return str(ans)


main()
