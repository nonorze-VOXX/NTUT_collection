
def check(a):
    if a == 'A':
        return 1
    if a in ['Q','J','K']:
        return 0.5
    else:
        return int(a)
        
        
def reset():
    n = int(input())
    vec = input()
    vec = vec.split()
    vec1 = input()
    vec1 = vec1.split()
    ans = [0]
    ans[0]=check(vec1[0])
    for i in range(1,len(vec1)):
        ans.append(check(vec1[i]))
    
    return n,vec,ans

def turn(vec,boom,nowplayer):
    #print(vec)
    if boom[nowplayer]:
        tmp = input()
        if tmp == 'Y':
            tmp = input()
            vec[nowplayer]+=check(tmp)
            
            if vec[nowplayer] > 10.5:
                vec[nowplayer]=-2
                boom[nowplayer]=False
        else :
            boom[nowplayer]=False
    else:
        return False
    return True

def main():
    n,money,card = reset()
    boomplayer = [True for _ in range(n)]
    for i in range(n):
        count=0
        while(1):
            if count == 1 and card[i]==10.5:
                card[i]=12
                boomplayer[i]=False
            elif card[i]==10.5:
                card[i]=11 
            if count == 4:
                card[i]=12
                boomplayer[i]= False
            
            #print("cardA",card)
            b=turn(card,boomplayer,i)
            count +=1
            if not b:
                break
    #print("OVER")
    card.append(check(input()))
    boomplayer.append(True)
    while(1):
        if card[n]>10.5:
            card[n] = -3
        count = 0
        if count==2 and card[n]==10.5:
            boomplayer[n] = False
            card [n]= 11
        elif card[n]==10.5:
            card[n]=11.1
            boomplayer[n]=False
        if count == 4:
            card[n]=11
            boomplayer[n]= False
        
        #print("card",card)
        b=turn(card,boomplayer,n)
        
        count +=1
        if not b:
            break
    #print(money)
    #print(card)
    #print(boomplayer)
    ans=0
    for i in range(n):
        if card[i]<=card[n]:
            money[i]='-'+money[i]
        else :
            money[i]="+"+money[i]
        tmp = str(i+1)
        ans+=int(money[i])
        print("Player"+tmp+' '+money[i])
    #print(money)
    ans*=-1
    if ans>0:
        ans="+"+str(ans)
    print("Bank",ans)

   
main()        