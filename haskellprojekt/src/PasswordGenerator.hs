module PasswordGenerator(generatePassword) where

import System.Random
import System.IO.Unsafe

-- Generate a random password of given length
generatePassword :: Int -> String
generatePassword length = take length $ randomChars charsGenerator
  where
    randomChars :: [a] -> [a]
    randomChars xs = unsafePerformIO $ shuffle xs

    charsGenerator :: String
    charsGenerator = ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']

-- Shuffle a list using Fisher-Yates algorithm
shuffle :: [a] -> IO [a]
shuffle xs = do
  g <- getStdGen
  return $ fst $ shuffle' g xs
  where
    shuffle' :: StdGen -> [a] -> ([a], StdGen)
    shuffle' g [] = ([], g)
    shuffle' g [x] = ([x], g)
    shuffle' g xs =
      let (n, newGen) = randomR (0, length xs - 1) g
          (rest, y:ys) = splitAt n xs
          (shuffled, finalGen) = shuffle' newGen (rest ++ ys)
      in (y : shuffled, finalGen)

-- Usage example
main :: IO ()
main = do
  putStrLn "Enter the length of the password:"
  lengthStr <- getLine
  let passwordLength = read lengthStr :: Int
  putStrLn $ "Generated password: " ++ generatePassword passwordLength