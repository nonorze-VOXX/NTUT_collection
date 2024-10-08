n = int(input())
m = int(input())
sum = 0
if n%2:
    n=n+1
for i in range(n,m+1,2):
    sum+=i;
print(sum)
