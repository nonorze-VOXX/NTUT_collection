def many_input(n):
    vec = []
    for i in range(n):
        vec.append(input().split())
    return vec


def add_front(vec, n, i, string):
    vec[n-1].insert(i-1, string)
    return vec


def add_after(vec, n, i, string):
    vec[n-1].insert(i, string)
    return vec


def insert_front(vec, key, word):
    for i in vec:
        for j in range(len(i)-1, -1, -1):
            if i[j] == key:
                i.insert(j, word)
    return vec


def insert_after(vec, key, word):
    for i in vec:
        for j in range(len(i)-1, -1, -1):
            if i[j] == key:
                i.insert(j+1, word)
    return vec


def del_W(vec, i: int, n: int):
    del vec[i-1][n-1]
    return vec


def del_L(vec, i: int):
    del vec[i-1]
    return vec


def old_to_new(vec, old, new):
    for i in vec:
        for j in range(len(i)-1, -1, -1):
            if i[j] == old:
                i.insert(j+1, new)
                del i[j]
    return vec


def count(vec):
    ans = 0
    for i in vec:
        ans += len(i)
    return ans


def add_front_line(vec, n, string: list):
    for x in string:
        vec[n-1].insert(0, x)
    return vec


def add_after_line(vec, n, string: list):
    for x in string:
        vec[n-1].append(x)
    return vec


def doMain(vec):
    tmp = input().split()
    if tmp[0] == "ADD_W_FRONT":
        vec = add_front(vec, int(tmp[1]), int(tmp[2]), tmp[3])
    elif tmp[0] == "ADD_W_AFTER":
        vec = add_after(vec, int(tmp[1]), int(tmp[2]), tmp[3])
    if tmp[0] == "ADD_S_FRONT":
        vec = add_front_line(vec, int(tmp[1]), list(tmp[2:]))
    if tmp[0] == "ADD_S_AFTER":
        vec = add_after_line(vec, int(tmp[1]), list(tmp[2:]))
    elif tmp[0] == "INSERT_FRONT":
        vec = insert_front(vec, tmp[1], tmp[2])
    elif tmp[0] == "INSERT_AFTER":
        vec = insert_after(vec, tmp[1], tmp[2])
    elif tmp[0] == "DEL_W":
        vec = del_W(vec, int(tmp[1]), int(tmp[2]))
    elif tmp[0] == "DEL_L":
        vec = del_L(vec, int(tmp[1]))
    elif tmp[0] == "REPLACE":
        vec = old_to_new(vec, tmp[1], tmp[2])
    elif tmp[0] == "COUNT":
        print(count(vec))


def main():
    n, m = [int(x) for x in input().split()]
    ans = many_input(n)
    for i in range(m):
        doMain(ans)

    [print(" ".join(line)) for line in ans]


main()
