a=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
b=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
c=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
d=[""]*100
e=[[0]*2]
nameA = input()
timeA = int(input())
for i in range(timeA) :
    tmp=int(input())
    a[tmp]=1
nameB = input()
timeB = int(input())
for i in range(timeB) :
    tmp=int(input())
    b[tmp]=1
nameC = input()
timeC = int(input())
for i in range(timeC) :
    tmp=int(input())
    c[tmp]=1

for i in range(60):
    if a[i]+b[i]+c[i]==3:
        print(nameA,'and',nameB,' and ',nameC,' confict on ',i)
    elif a[i]+b[i]==2:
        print(nameA,'and',nameB,'confict on',i)
    elif b[i]+c[i]==2:
        print(nameB,'and',nameC,'confict on',i)
    elif a[i]+c[i]==2:
        print(nameA,'and',nameC,'confict on',i)
