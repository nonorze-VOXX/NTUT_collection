def main():
    string=input()
    string=string.split()
    #print(string)
    odd=[]
    pair=[]
    for i in range(len(string)):
        if int (string[i])%2==1:
            odd.append(int(string[i]))
        else:
            pair.append(int(string[i]))
    odd.sort()
    pair.sort(reverse=True)
    odd+=pair
    print(odd)

main()