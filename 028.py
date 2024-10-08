def check(num,x,y):
    if num%x==y:
        return True
    else:
        return False


def main():
    string=input()
    string=string.split()
    ans=1
    while(1):
        if  check(ans,int(string[0]),int(string[1])) and check(ans,int(string[2]),int(string[3])) and check(ans,int(string[4]),int(string[5])):
            break
        ans+=1
    print(ans)

main()