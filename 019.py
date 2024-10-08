num = int(input())

for i in range(num):
    for j in range(num+i):
        print('#',end='')
    for j in range(num-i,0,-1):
        print(j,end='')
    print()
