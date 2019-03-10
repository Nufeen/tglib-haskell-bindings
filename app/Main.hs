{-# LANGUAGE ForeignFunctionInterface #-}

module Main where

import Foreign
import Foreign.C.String
import Foreign.C.Types

import Control.Monad (forever)
import Control.Exception

type Client = Ptr ()
type Timeout = Double

foreign import ccall "libtdjson td_json_client_create" c_create :: IO Client
foreign import ccall "libtdjson td_json_client_send" c_send :: Client -> CString -> IO ()
foreign import ccall "libtdjson td_json_client_receive" c_receive :: Client -> Timeout -> IO CString
foreign import ccall "libtdjson td_json_client_execute" c_execute :: Client -> CString -> IO ()
foreign import ccall "libtdjson td_json_client_destroy" c_destroy :: Client -> IO ()

testQuery1 = "{\"@type\": \"getAuthorizationState\", \"@extra\": 1.01234}"
testQuery2 = " { \"@type\": \"getTextEntities\", \"text\": \"@telegram /test_command https://telegram.org telegram.me\" } "

main :: IO ()
main = do
  client <- create
  send client testQuery1
  execute client testQuery2
  receive client >>= peekCString >>= putStrLn
  destroy client

create :: IO Client
create = c_create

send :: Client -> String -> IO ()
send c s = (newCString s) >>= c_send c

execute :: Client -> String -> IO ()
execute c s = (newCString s) >>= c_execute c

receive :: Client -> IO CString
receive c = c_receive c 1.0

destroy :: Client -> IO ()
destroy c = c_destroy c
