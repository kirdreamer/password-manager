{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_haskellprojekt (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/reiskanzler/Code/bht_workspace/puk/projekt/password-manager/.stack-work/install/aarch64-osx/4f50d891a536c895b918a2ddf98821a0ca70f4ab846bc5c0c959e77eb641b152/9.4.5/bin"
libdir     = "/Users/reiskanzler/Code/bht_workspace/puk/projekt/password-manager/.stack-work/install/aarch64-osx/4f50d891a536c895b918a2ddf98821a0ca70f4ab846bc5c0c959e77eb641b152/9.4.5/lib/aarch64-osx-ghc-9.4.5/haskellprojekt-0.1.0.0-7lICk12FMMfAlio6FIaF96-haskellprojekt"
dynlibdir  = "/Users/reiskanzler/Code/bht_workspace/puk/projekt/password-manager/.stack-work/install/aarch64-osx/4f50d891a536c895b918a2ddf98821a0ca70f4ab846bc5c0c959e77eb641b152/9.4.5/lib/aarch64-osx-ghc-9.4.5"
datadir    = "/Users/reiskanzler/Code/bht_workspace/puk/projekt/password-manager/.stack-work/install/aarch64-osx/4f50d891a536c895b918a2ddf98821a0ca70f4ab846bc5c0c959e77eb641b152/9.4.5/share/aarch64-osx-ghc-9.4.5/haskellprojekt-0.1.0.0"
libexecdir = "/Users/reiskanzler/Code/bht_workspace/puk/projekt/password-manager/.stack-work/install/aarch64-osx/4f50d891a536c895b918a2ddf98821a0ca70f4ab846bc5c0c959e77eb641b152/9.4.5/libexec/aarch64-osx-ghc-9.4.5/haskellprojekt-0.1.0.0"
sysconfdir = "/Users/reiskanzler/Code/bht_workspace/puk/projekt/password-manager/.stack-work/install/aarch64-osx/4f50d891a536c895b918a2ddf98821a0ca70f4ab846bc5c0c959e77eb641b152/9.4.5/etc"

getBinDir     = catchIO (getEnv "haskellprojekt_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "haskellprojekt_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "haskellprojekt_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "haskellprojekt_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskellprojekt_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskellprojekt_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
