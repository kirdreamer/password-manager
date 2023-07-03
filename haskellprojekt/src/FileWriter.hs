module FileWriter where

import System.IO
import System.Directory

editOrCreateFile :: FilePath -> String -> IO String
editOrCreateFile path input = do
    fileExists <- doesFileExist path
    
    if fileExists
    then do
        contents <- FileWriter.readFile path input
        let updatedContent = contents ++ "\n\n" ++ input
        length contents `seq` (createFile path updatedContent)
        return "File edited successfully"
    else do
        createFile path input

readFile :: FilePath -> String -> IO String
readFile path input = do
    contents <- System.IO.readFile path  
    return contents


createFile :: FilePath -> String -> IO String
createFile path input = do
    writeFile path input
    return "File successfully created"
