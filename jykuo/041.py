def main():
    n = input()
    n = n.split()
    x = int(n[1])
    y = int(n[2])
    n = int(n[0])
    vec = getinput(n, y)
    # for i in range(y+1):
    #   for j in range(y+1):
    #      print(vec[i][j], end='')
    # print()
    vecFind = [0 for i in range(y+1)]
    if find(x, y, vecFind, vec):
        print("Yes!")
    else:
        print("No!")


def getinput(n: int, y: int):
    vec = [[0 for _ in range(y+10)] for i in range(y+10)]
    for i in range(n):
        tmp = input().split()
        vec[int(tmp[0])][int(tmp[1])] = 1
        vec[int(tmp[1])][int(tmp[0])] = 1
    return vec


def find(start, end, vecFind, vec):
    queue = [start]
    while(1):
        if len(queue) == 0:
            break
        for i in range(1, end+1):
            if vecFind[queue[0]] == 1:
                break
            if vec[queue[0]][i] == 1:
                queue.append(i)
        vecFind[queue[0]] = 1
        del queue[0]
    if vecFind[end] == 1:
        return True
    else:
        return False


main()
