name = input()
high = int(input())
w = int(input())
high/=100
print("Hi "+name,end='')
a = w/high/high
print(", Your BMI: %.6f"%a,end="")
if a<18.5 :
    print(" too LOW.")
elif a>24 :
    print(" too HIGH.")
else :
    print(".")
