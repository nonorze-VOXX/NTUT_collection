a = int(input())
b=int(input())
c = int(input())

def checkApple(a):
    if a>=11 and a<=15:
        return a*30*0.95
    elif a>=16 and a<=20:
        return a*30*0.9
    elif a>=21:
        return a*30*0.8
    else :
        return a*30
def checkB(a):
    if a>=11 and a<=15:
        return a*70*0.9
    elif a>=16 and a<=20:
        return a*70*0.85
    elif a>=21:
        return a*70*0.75
    else :
        return a*70
def checkC(a):
    if a>=11 and a<=15:
        return a*40*0.85
    elif a>=16 and a<=20:
        return a*40*0.8
    elif a>=21:
        return a*40*0.8
    else :
        return a*40
total = checkApple(a)+checkB(b)+checkC(c)
if a+b+c>=30:
    total*=0.87
print('%.0f'%total)
