
-- ################################################
-- #           ESERCIZI PROVE SCRITTE             #
-- ################################################

mediaGeometrica :: (Floating a) => [a] -> a
mediaGeometrica [] = error "Errore: lista vuota"
mediaGeometrica lista = product lista ** recip (fromIntegral (length lista))

-- Meida Aritmetica
mediaAritmetica :: (Fractional a) => [a] -> a
mediaAritmetica [] = error "Errore: lista vuota"
mediaAritmetica list = sum list / fromIntegral (length list)

-- Scarta multipli dispari 5
scartaMultipliDispari5 :: (Integral a) => [a] -> [a]
scartaMultipliDispari5 [] = []
scartaMultipliDispari5 (x : xs) | x `mod` 5 == 0 && x `mod` 2 == 1 = scartaMultipliDispari5 xs
                                | otherwise = x : scartaMultipliDispari5 xs

listaCoppie :: (Fractional a) => [a] -> [(a, Int)]
listaCoppie [] = []
listaCoppie (x : xs) = (x, length xs) : listaCoppie xs

-- Minimo dei secondi elementi
minSecondiElementi :: [(Int, Int)] -> Int
minSecondiElementi [] = error "Lista vuota"
minSecondiElementi xs = minimum (map snd xs)

-- Massimo dei primi elementi
maxPrimiElementi :: [(Int, Int)] -> Int
maxPrimiElementi [] = error "Lista vuota"
maxPrimiElementi xs = maximum (map fst xs)

-- Condizione bisestile
isBisestile :: Int -> Bool
isBisestile x = x `mod` 4 == 0 && x `mod` 100 /= 0 ||
                x `mod` 400 == 0

generaAnniBisestili :: Int -> Int -> [Int]
generaAnniBisestili a b = [x | x <- [a..b], isBisestile x]

scartaBisestili :: [Int] -> [Int]
scartaBisestili [] = []
scartaBisestili xs = [x | x <- xs, not (isBisestile x)]
