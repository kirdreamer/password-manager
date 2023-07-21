module PasswordGenerator(generatePassword) where

import System.Random

getRandomAlpha :: IO Char
getRandomAlpha = getStdRandom $ randomR ('0', 'z')

generateNewPassword :: Int -> IO [Char]
generateNewPassword 0 = return ""
generateNewPassword length = do
    char <- getRandomAlpha
    restOfPassword <- generateNewPassword (length - 1)
    return (char : restOfPassword)

generatePassword :: IO String
generatePassword = do
  putStr "Enter the length of the password > "
  lengthStr <- getLine
  let passwordLength = read lengthStr :: Int
  generateNewPassword passwordLength