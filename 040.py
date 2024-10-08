def sta(vec, n):
    ans = []
    tmp = ''
    for i in range(len(vec)):

        if vec[i] in "qazwsxedcrfvtgbyhnujmikolpQAWSZEDXRFCTGVYHBUJNIKMOLP":
            tmp += vec[i]
            if len(tmp) == n:
                ans.append(tmp)
                tmp = ''
    if len(tmp) != 0:
        ans.append(tmp)
    for i in range(len(ans)-1, 0, -1):
        print(ans[i].swapcase(), end='/')
    print(ans[0].swapcase())


tmp = input().split()
n = tmp[1]
tmp = tmp[0]
sta(tmp, int(n))
