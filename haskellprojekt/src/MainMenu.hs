module MainMenu(callMenu) where

import Password
import PasswordGenerator
import FileWriter

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
    printDelimiter
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
    passwordObj <- fillPasswordInfo
    if (password passwordObj /= "") then do
        result <- editOrCreateFile "vault.txt" (show passwordObj)
        putStrLn result
    else
        passwordMenu "-1"


passwordMenu _ = do
    callMenu "-1"

printGeneratePasswordMenu :: IO()
printGeneratePasswordMenu = do
    printDelimiter
    putStrLn "Generate a new Password\n"
    putStrLn "Please choose option:"
    putStrLn "(1) Generate new password"
    putStrLn "(2) Settings of Generating Password"
    putStrLn "(Any Other Number) Return to Main menu"
    putStr "> " 

fillPasswordInfo :: IO Password
fillPasswordInfo = do
    printDelimiter
    putStr "Title > "
    title <- getLine
    putStr "Login > "
    login <- getLine
    putStr "Url > "
    url <- getLine
    password <- generatePasswordMenu "1"
    return Password {title = title, login = login, url = url, password = password}

generatePasswordMenu :: String -> IO String
generatePasswordMenu "1" = do 
    printDelimiter
    password <- generatePassword 
    putStr "Generated password: "
    putStrLn password
    printDelimiter
    putStrLn "Choose next Option:"
    putStrLn "(1) Regenerate Password"
    putStrLn "(2) Save Password"
    putStrLn "(Any Other Number) Cancel Generating"
    option <- getLine 
    if option == "2" then return password
    else generatePasswordMenu option

generatePasswordMenu _ = return ""

printDelimiter :: IO()
printDelimiter = do
    putStrLn "\n----------------------------\n"