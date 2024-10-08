def dosome(vec, ans):
    for i in range(len(vec)):
        for j in range(i+1, len(vec)+1):
            tmp = vec[i:j]
            tmp = tmp[::-1]
            if tmp == vec[i: j] and not (tmp in ans):
                ans.append(tmp)


ans = []
dosome(input(), ans)
ans = sorted(ans)
for i in range(len(ans)-1):
    print(ans[i], end='#')
print(ans[-1])
