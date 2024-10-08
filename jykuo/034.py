def check(tmp):
    if tmp == 0:
        return 0
    if tmp == 1:
        return 1
    return check(tmp-1)*2+check(tmp-2)*3


def main():

    tmp = input()
    if '.' in tmp:
        print("Error")
    tmp = int(tmp)
    if tmp < 2:
        print("Error")
    else:
        print(check(tmp))


main()
