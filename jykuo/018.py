n = int(input())
m = int(input())

if n==1 :
    for i in range(1,m+1):
        for j in range(1,i+1):
            print(j,end='')
        for j in range(i-1,0,-1):
            print(j,end='')
        print()
elif n==2:
    for i in range(m):
        for j in range(m//2-i+2):
            print('_',end= '')

        for j in range(i+1):
            print(j+1,end='')
        for j in range(i,0,-1):
            print(j,end='')
        for j in range(m//2-i+2):
            print('_',end= '')
        print()
elif n==3:
    for i in range(m,0,-1):
        for j in range(m-i):
            print('_',end='')
        for j in range(1,i+1):
            print(j,end='')
        for j in range(i-1,0,-1):
            print(j,end='')
        for j in range(m-i):
            print('_',end='')
        print()
