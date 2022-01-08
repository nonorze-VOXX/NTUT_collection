def out(i):
    vec=[0,0,0,0]
    tmp1 = 3
    while(not i==0):
        tmp = i%2
        vec[tmp1]=tmp
        i=i//2
        tmp1-=1
    return vec


def main ():
    ans=[]
    while (1):
        tmp = input()
        if tmp =="-1":
            break
        for i in range(len(tmp)):
            if tmp[i]=="1":
                i = 8-i
                for j in range(4):
                    print(out(i)[j],end='')
                print()
                
                break
            elif tmp[i]=="0" and i==7:
                print("0000")
                '''
    for i in range(len(ans)):
        for j in range(len(ans[i])):
            print(ans[i][j],end='')
        print()
'''



main()