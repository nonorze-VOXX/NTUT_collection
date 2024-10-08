def little(vec):
    ans = 0
    for i in vec:
        if i in 'abcdefghijklmnopqrstuvwxyz':
            ans+=1
    return ans

def big(vec):
    ans = 0
    for i in vec:
        if i in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
            ans+=1
    return ans*2

def num(vec):
    ans = 0 
    for i in vec:
        if i in "1234567890":
            ans+=1
    return ans*3

def shape(vec):
    ans = 0
    for i in vec:

        if i in "~!@#$%^&*<>()_+=":
            ans+=1
    return ans*5

def num5(vec):
    flag = True
    if num(vec)>=15:
        for i in range(len(vec)-1):
            if vec[i] in "1234567890" and vec[i+1] in "1234567890":
                flag = True
            else :
                flag = False
    if flag:
        return num(vec)
    else:
        return 10+num(vec)


def main():
    smax = ""
    smin = ""
    ansmax =0
    ansmin = 100000000
    while(True):
        s = str(input())
        if  s =="-1":
            break
        else:
            ans = little(s)+big(s)+num5(s)+shape(s)
            
            if ans>=ansmax:
                ansmax = ans
                smax = s
            if ans<=ansmin:
                ansmin = ans
                smin = s
    print(smax,ansmax)
    print(smin,ansmin)

main()