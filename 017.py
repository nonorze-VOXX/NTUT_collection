n = int(input())
m = int(input())

if n==1 :
    for i in range(m//2+1):
        for j in range(i+1):
            print('*',end='')
        print()
    for i in range(m//2):
        for j in range(m//2-i,0,-1):
            print('*',end='')
        print()
elif n==2:
    for i in range(m//2+1):
        for j in range(m//2-i):
            print('.',end= '')
        for j in range(i+1):
            print('*',end='')
        print()
    for i in range(m//2):
        for j in range(i+1):
            print('.',end='')
        for j in range(m//2-i):
            print('*',end= '')
        print()
elif n==3:
    for i in range(m//2+1):
        for j in range(m//2-i,0,-1):
            print('.',end='')
        for j in range(2*(i+1)-1):
            print('*',end='')
        print()
    for i in range(m//2):
        for j in range(i+1):
            print('.',end='')
        for j in range(2*(m//2-i)-1,0,-1):
            print('*',end='')
        print()
    print()
