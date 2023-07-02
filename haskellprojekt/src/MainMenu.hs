module MainMenu(callMenu) where

callMenu :: [Char] -> IO ()
callMenu "1" = do
    printMenu
    num <- getLine
    callMenu num

callMenu "2" = do
    passwordMenu "1"

callMenu _ = 
    putStrLn "Goodbye!"

printMenu :: IO()
printMenu = do
    putStrLn "Welcome to Passwort-Generator"
    putStrLn "Please choose option:"
    putStrLn "(1) Return to main Menu"
    putStrLn "(2) Generate a new Password"
    putStrLn "(3) Read a password from file"
    putStrLn "(Any Other Number) Quit"
    putStr "> " 

passwordMenu :: [Char] -> IO()
passwordMenu "1" = do
    printGeneratePasswordMenu
    num <- getLine
    passwordMenu num

passwordMenu _ = do
    callMenu "1"

printGeneratePasswordMenu :: IO()
printGeneratePasswordMenu = do
    putStrLn ""