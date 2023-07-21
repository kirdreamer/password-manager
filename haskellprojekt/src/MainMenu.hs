module MainMenu(callMenu) where

import Password
import PasswordGenerator
import FileWriter

callMenu :: [Char] -> IO ()
callMenu "-1" = do
    printDelimiter
    putStrLn "Welcome to Password-Generator\n"
    putStrLn "Please choose option:"
    putStrLn "(1) Generate a new Password"
    putStrLn "(2) Read a password"
    putStrLn "(3) Read all passwords"
    putStrLn "(4) Quit"
    putStr "> " 
    num <- getLine
    callMenu num

callMenu "1" = do
    createNewPasswordMenu

callMenu "2" = do
    searchPasswordMenu "1"

callMenu "3" = do
    searchPasswordMenu "2"

callMenu "4" = do
    putStrLn "Goodbye!"

callMenu _ = 
    callMenu "-1"

-- (1)
createNewPasswordMenu :: IO()
createNewPasswordMenu = do
    passwordObj <- fillPasswordInfo
    if (password passwordObj /= "") then do
        result <- editOrCreateFile "vault.txt" passwordObj
        putStrLn result
    else
        putStrLn "Password was not saved."
    printExitPrompt

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
    putStr "> " 
    option <- getLine 
    if option == "2" then return password
    else generatePasswordMenu option

generatePasswordMenu _ = return ""

-- (2)
searchPasswordMenu :: String -> IO()
searchPasswordMenu "1" = do
    putStrLn "Enter title or login" 
    putStr "> "
    search <- getLine
    if null search
        then do
            putStrLn "search cannot be empty."
            searchPasswordMenu "1"
        else do
            passwords <- searchPassword "vault.txt" search
            case passwords of
                [] -> putStrLn "No password found."
                [single] -> putStrLn $ password single
                multiple -> do
                    putStrLn "Found multiple results:"
                    mapM_ (putStrLn . show) multiple
    printExitPrompt

searchPasswordMenu "2" = do
    passwords <- searchPassword "vault.txt" ""
    case passwords of
        [] -> putStrLn "No passwords found."
        multiple -> mapM_ (putStrLn . show) multiple
    printExitPrompt

-- Helpers
printDelimiter :: IO()
printDelimiter = do
    putStrLn "\n----------------------------\n"

printExitPrompt :: IO()
printExitPrompt = do
    putStrLn "" 
    putStrLn "(Press any key to go back to main menu)" 
    enter <- getLine
    callMenu "-1"
