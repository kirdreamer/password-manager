

module MainMenu(callMenu) where

import Password
import PasswordGenerator

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
    passwordMenu "-1"


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
    password <- generateNewPassword "1"
    return Password {title = title, login = login, url = url, password = password}

generateNewPassword :: String -> IO String
generateNewPassword "1" = do 
    printDelimeter
    putStr "Enter the length of the password >"
    lengthStr <- getLine
    let passwordLength = read lengthStr :: Int
    -- password <- generatePassword passwordLength
    putStr "Generated password: "
    -- print password
    putStrLn $ generatePassword passwordLength
    printDelimeter
    putStrLn "Choose next Option:"
    putStrLn "(1) Regenerate Password"
    putStrLn "(2) Save Password"
    putStrLn "(Any Other Number) Cancel Generating"
    option <- getLine 
    if option == "2" then return $ generatePassword passwordLength
    else generateNewPassword option
        -- where passwordLength = "222"

generateNewPassword _ = return ""

printDelimeter :: IO()
printDelimeter = do
    putStrLn "\n----------------------------\n"