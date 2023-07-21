module FileWriter where

import Password
import System.IO
import System.Directory

editOrCreateFile :: FilePath -> Password -> IO String
editOrCreateFile path input = do
    fileExists <- doesFileExist path
    if fileExists
    then do
        contents <- readFile path
        let updatedContent = contents ++ "\n" ++ show input
        length contents `seq` (createFile path updatedContent)
        return "File edited successfully."
    else do
        createFile path $ show input

searchPassword :: FilePath -> String -> IO [Password]
searchPassword path search = do
  fileExists <- doesFileExist path
  if fileExists
    then do
      -- file content as string
      contents <- readFile path
      -- splits string into array of strings by new line
      let pwArray = lines contents
          -- Parse password string array into Password object array
          passwords = parsePasswords pwArray
      if null search
        then return passwords
        else return (filter (\pw -> title pw == search || login pw == search || url pw == search) passwords)
    else
      return []

parsePasswords :: [String] -> [Password]
parsePasswords [] = []
parsePasswords (line : rest) =
    -- reads function provided by Read typeclass in Password.hs
    case reads line of
    [(parsedPassword, _)] -> (parsedPassword : parsePasswords rest)
    _ -> parsePasswords rest


createFile :: FilePath -> String -> IO String
createFile path input = do
    writeFile path input
    return "File successfully created."
