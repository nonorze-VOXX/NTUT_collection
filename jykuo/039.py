FA = []


def main(data, DeepST: int, nowData, maxDeep: int):
    #print(data, DeepST, nowData, maxDeep)
    if len(nowData) == maxDeep:
        FA.append(nowData)
        return 0
    if DeepST+maxDeep-len(nowData) > len(data):
        return 0
    for i in range(DeepST+1, len(data)):
        tmp = nowData+data[i]
        main(data, i, tmp, maxDeep)


tmp = input().split()
n = int(tmp[1])
tmp = tmp[0]
nowdata = ''
main(tmp, -1, nowdata, n)
FA = sorted(FA)
for i in range(len(FA)):

    print(FA[i], end=' ')
print()
