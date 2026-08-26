mySucc :: Int -> Int
mySucc n = n + 1

myPred :: Int -> Int
myPred n = n - 1

myAdd :: Int -> Int -> Int
myAdd m 0 = m
myAdd m n = myAdd (mySucc m) (myPred n)

mySub :: Int -> Int -> Int
mySub m 0 = m
mySub m n = mySub (myPred m) (mySucc n)

myMult :: Int -> Int -> Int
myMult m 0 = 0
myMult m n = myAdd m (myMult m (myPred n))

myDiv :: Int -> Int -> Int
myDiv m 0 = 0
myDiv m n = myDiv (myPred m) (mySucc n)
