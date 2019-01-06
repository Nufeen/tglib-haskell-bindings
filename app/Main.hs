{-# LANGUAGE ForeignFunctionInterface #-}

module Main where

import Foreign
import Foreign.C.String
import Foreign.C.Types

import Control.Monad (forever)

type Client = Ptr ()

foreign import ccall "libtdjson td_json_client_create" c_create :: Client
foreign import ccall "libtdjson td_json_client_send" c_send :: Client -> CString -> IO()
foreign import ccall "libtdjson td_json_client_receive" c_receive :: Client -> Double -> IO CString

testQuery = "{\"@type\": \"getAuthorizationState\", \"@extra\": 1.01234}"

main :: IO ()
main = do
  send testQuery
  getAnswer >>= peekCString >>= print

client :: Client
client = c_create

send :: String -> IO ()
send x = (newCString x) >>= c_send client

getAnswer :: IO CString
getAnswer  = c_receive client 1.0
