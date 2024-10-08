m = int(input())
n = int(input())
sum = 0
x = 1
for i in range(m,n+1,2):
    sum+=i
for i in range(m,n+1,3):
    x*=i
print(sum)
print(x)
