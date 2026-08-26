import Data.Array as Array

printMenu :: IO ()
printMenu = do
    putStrLn "Available Operations: "
    putStrLn "1) Action 1"
    putStrLn "2) Action 2"
    putStrLn "3) Action 3"
    putStrLn "0) Exit"

getChoice :: IO String
getChoice = do
    putStrLn "Insert your choice number: "
    getLine

main = do
    loop

loop :: IO ()
loop = do
    printMenu
    choice <- getChoice
    case choice of
        "1" -> do
            putStrLn "Action 1"
            loop
        "2" -> do
            putStrLn "Action 2"
            loop
        "3" -> do
            putStrLn "Action 3"
            loop
        "0" -> putStrLn "Exit"
        _ -> do
            putStrLn "Invalid choice"
            loop
