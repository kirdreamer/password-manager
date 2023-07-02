

module MainMenu(callMenu) where

import Password

callMenu :: [Char] -> IO ()
callMenu "-1" = do
    printMenu
    num <- getLine
    callMenu num

callMenu "1" = do
    passwordMenu "-1"

callMenu _ = 
    putStrLn "Goodbye!"

printMenu :: IO()
printMenu = do
    printDelimeter
    putStrLn "Welcome to Password-Generator\n"
    putStrLn "Please choose option:"
    putStrLn "(1) Generate a new Password"
    putStrLn "(2) Read a password from file"
    putStrLn "(Any Other Number) Quit"
    putStr "> " 

passwordMenu :: [Char] -> IO()
passwordMenu "-1" = do
    printGeneratePasswordMenu
    num <- getLine
    passwordMenu num

passwordMenu "1" = do
    password <- fillPasswordInfo
    print password


passwordMenu _ = do
    callMenu "-1"

printGeneratePasswordMenu :: IO()
printGeneratePasswordMenu = do
    printDelimeter
    putStrLn "Generate a new Password\n"
    putStrLn "Please choose option:"
    putStrLn "(1) Generate new password"
    putStrLn "(2) Settings of Generating Password"
    putStrLn "(Any Other Number) Return to Main menu"
    putStr "> " 

fillPasswordInfo :: IO Password
fillPasswordInfo = do
    printDelimeter
    putStr "Title > "
    title <- getLine
    putStr "Login > "
    login <- getLine
    putStr "Url > "
    url <- getLine
    return Password {title = title, login = login, url = url, password = generatePassword}

-- Make a new class with password generation
generatePassword :: String
generatePassword = 
    "12" ++ "34"

printDelimeter :: IO()
printDelimeter = do
    putStrLn "\n----------------------------\n"