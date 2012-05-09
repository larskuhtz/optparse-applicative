import Control.Applicative
import Options.Applicative.Types
import Options.Applicative.Builder
import Options.Applicative.Extra

data Sample
  = Hello String
  | Goodbye

hello :: Parser Sample
hello = Hello <$> argument str (metavar "TARGET")

sample :: Parser Sample
sample = command (`lookup`
  [("hello", info hello)
  ,("goodbye", info (pure Goodbye))])
  idm

run :: Sample -> IO ()
run (Hello target) = putStrLn $ "Hello, " ++ target ++ "!"
run Goodbye = putStrLn "Goodbye."

main :: IO ()
main = execParser (info sample) >>= run
