def main():
    vec = input().split()
    ans = []
    f = 0
    for i in range(len(vec)):
        if f == 1:
            f = 0
            continue
        c = vec[i]
        if c == "%":
            f = 1
            tmp = int(ans[-1]) % int(vec[i+1])
            del ans[-1]
            ans.append(tmp)
        elif c == "*":
            f = 1
            tmp = int(ans[-1])*int(vec[i+1])
            del ans[-1]
            ans.append(tmp)
        elif c == "/":
            f = 1
            tmp = int(ans[-1])/int(vec[i+1])
            del ans[-1]
            ans.append(tmp)
        else:
            ans.append(vec[i])
    tmp1 = vec
    vec = ans
    ans = []
    f = 0
    for i in range(len(vec)):
        if f == 1:
            f = 0
            continue
        c = vec[i]
        if c == "+":
            f = 1
            tmp = int(ans[-1])+int(vec[i+1])
            del ans[-1]
            ans.append(tmp)
        elif c == "-":
            f = 1
            tmp = int(ans[-1])-int(vec[i+1])
            del ans[-1]
            ans.append(tmp)
        else:
            ans.append(vec[i])
    print(ans[0])


main()
