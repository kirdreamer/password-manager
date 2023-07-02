module Settings where

data Settings = Settings {
    limitOfSymbols :: Integer,
    isContainsNumbers :: Bool,
    isContainsCharacters :: Bool,
    isContainsSpecialSymbols :: Bool
}