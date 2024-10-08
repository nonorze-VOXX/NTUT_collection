

def main():
    n = int(input())
    vec = []
    vec1 = []
    bvec = []
    for i in range(n):
        tmp = input()
        tmp = tmp.split(',')
        a = int(tmp[0])
        b = int(tmp[1])
        vec.append(a)
        vec1.append(b)
        bvec.append(0)
    k = len(vec)

    for j in range(k):
        for i in range(k):
            '''
            print(j, i)
            print(vec)
            print(vec1)
            print(bvec)
            print()
            '''
            if i == j or bvec[i] == 1 or bvec[j] == 1:
                continue

            if vec[i] == vec[j] and vec1[i] == vec1[j]:
                bvec[j] = 1
                continue

            if vec[i] == vec[j]:
                if vec1[i] > vec1[j]:
                    bvec[j] = 1
                    continue
                elif vec1[i] < vec1[j]:
                    bvec[i] = 1
                    continue
            if vec[i] < vec[j] and vec1[i] > vec1[j]:
                bvec[j] = 1
                continue
            if vec1[j] >= vec[i] and vec1[i] > vec1[j]:
                vec1[j] = vec1[i]
                bvec[i] = 1
    for j in range(k):
        for i in range(k):

            if i == j or bvec[i] == 1 or bvec[j] == 1:
                continue

            if vec[i] == vec[j] and vec1[i] == vec1[j]:
                bvec[j] = 1
                continue

            if vec[i] == vec[j]:
                if vec1[i] > vec1[j]:
                    bvec[j] = 1
                    continue
                elif vec1[i] < vec1[j]:
                    bvec[i] = 1
                    continue
            if vec[i] < vec[j] and vec1[i] > vec1[j]:
                bvec[j] = 1
                continue
            if vec1[j] >= vec[i] and vec1[i] > vec1[j]:
                vec1[j] = vec1[i]
                bvec[i] = 1

    for i in range(len(vec)):
        if bvec[i] == 0:
            print(vec[i], end=',')
            print(vec1[i])


main()
