module PasswordGenerator(generatePassword) where

import Data.Time.Clock.POSIX
import System.IO.Unsafe
import System.Random

generateNewPassword :: Int -> String
generateNewPassword length = take length $ randomChars charsGenerator
  where
    randomChars :: [a] -> [a]
    randomChars xs = unsafePerformIO $ shuffle xs

    charsGenerator :: String
    charsGenerator = ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9']

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

getCurrentTimestamp :: IO Int
getCurrentTimestamp = round <$> getPOSIXTime

generatePassword :: IO String
generatePassword = do
  putStr "Enter the length of the password > "
  lengthStr <- getLine
  let passwordLength = read lengthStr :: Int

  timestamp <- getCurrentTimestamp
  let seed = timestamp `mod` 1000000  -- Use the last 6 digits of the timestamp as the seed
  setStdGen (mkStdGen seed)

  return $ generateNewPassword passwordLength