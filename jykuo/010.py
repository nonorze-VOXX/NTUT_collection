def cardToInt(card):
  cardNum = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']
  Num = [1,2,3,4,5,6,7,8,9,10,0.5,0.5,0.5]
  index = cardNum.index(card)
  return Num[index]
def cardSum(a,b,c):
  num = cardToInt(a)+cardToInt(b)+cardToInt(c)
  if num>10.5 :
      num=0
  print(num)
  return num
def main():
  x1 = input()
  x2 = input()
  x3 = input()
  y1 = input()
  y2 = input()
  y3 = input()
  xSum = cardSum(x1,x2,x3)
  ySum = cardSum(y1,y2,y3)

  if xSum == ySum:
    print('Tie')
  elif xSum>ySum:
    print('A Win')
  elif ySum>xSum:
    print('B Win')
main()
