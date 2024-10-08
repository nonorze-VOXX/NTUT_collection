
def check(a):
    if a == 'A':
        return 1
    if a in ['Q','J','K']:
        return 0.5
    else:
        return int(a)
asum = 0
bsum = 0
tmp = input()
asum = check(tmp)
tmp = input()
bsum = check(tmp)
aboom = False
bboom = False
flag = False
bflag = False

while 1:
    #print (f"{asum:.1f} vs. {bsum:.1f}")

    if not flag:
        #print("A")
        tmp = input()
        if tmp == 'Y' :

            tmp = check(input())
            asum += tmp
        elif tmp == 'N':
            flag = True
        else:
            if (bsum<=8 or bsum<asum)and not bflag:
                bsum += tmp
            else:
                bflag=True
    if asum >10.5:
        asum = 0
        flag = True
    if (bsum<=8 or bsum<asum)and not bflag:
        tmp = check(input())
        bsum += tmp
    else:
        bflag=True
    if bsum >10.5:
        bsum = 0
        bflag = True
    if (flag and bflag ):
        break
print (f"{asum:.1f} vs. {bsum:.1f}")
if asum<bsum:
    print('computer wins')
elif asum>bsum:
    print('player wins')
else:
    print("It's a tie")
