num = int(input())
b = True
for i in range(2,num,1):
    if num%i == 0:
        b=False
if(b):
    print(num,"is prime number")
elif num==1:
    print("1 is prime number")
else:
    print(num,"is not prime number")
