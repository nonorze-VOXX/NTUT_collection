def a(tmp):
    if tmp == 1:
        return 2
    return a(tmp-1)+tmp


print(a(int(input())))
