module Password where

data Password = Password {
    title :: String,
    login :: String,
    url :: String,
    password :: String
} deriving (Eq, Show)