big = 0
two = 0
little = 10000
n = int(input())
for i in range(n):
    tmp = int(input())
    if tmp>big:
        two=big
        big=tmp
    elif tmp>two:
        two=tmp
    if tmp<little:
        little=tmp;
print(two)
print(big*little)
