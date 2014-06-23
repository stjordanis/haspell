module Main where

import Data.List ((\\))
import qualified Data.Set as S

import System.Environment (getArgs)

import WTrie
import TrieMED

testWL :: [String] -> IO ()
testWL wl_dup = let wl = nub' S.empty wl_dup
                    wl' = toList . fromList $ wl
                    diff = (wl \\ wl') in -- ++ (wl' \\ wl) in
                putStrLn $ if null diff then "All words were accurately reproduced."
                                        else "ERROR in exact word reproduction, diff:" ++ show diff
    where
        nub' _ [] = []
        nub' s (x:xs) = if S.member x s then nub' s xs
                                        else x : nub' (S.insert x s) xs


testFile :: String -> IO ()
testFile f = do rawwords <- readFile f
                testWL $ words rawwords

testExample :: IO ()
testExample = do let res = calcMEDs "Lit" $ fromList ["Lot", "Lose", "Hose", "Los"]
                 putStrLn $ if lookup "Lot" res == Just 1
                            && lookup "Los" res == Just 2
                            && lookup "Lose" res == Just 3
                            && lookup "Hose" res == Just 4 then "All four MEDs were correct."
                                                           else "ERROR in checking MEDs!"

main = do ts <- fromWLFile "/home/sjm/downloads/aspell-dump-expand-de_DE.utf8.txt"
          --toWLFile "/tmp/ha_WL" ts
          --toWTFile "/tmp/ha_WT" ts
          --ts <- fromWTFile "/tmp/ha_WT" -- This takes eternities. Deserialization is apparently evil.
          let wordnum = length $ toList ts -- Cheap deepseq. Also nice to know.
          putStrLn $ (show wordnum) ++ " words loaded."
          let printSimpletest w = putStr $ if ts `contains` w then "" else (++"\n") . show $ calcMEDs w ts
          let forceSimpletest w = putStrLn . show $ calcMEDs w ts
          --mapM printSimpletest ["sfalihfaiwuehfliwauehfaiwfa", "ajfalwfaheofifmafowjfaiofja", "iwaefiehfalierjgmvcsafsefrf", "aioewjfoasmcoreijfsoerigmer", "asoiejfadorjgaormfairjfoeig", "wefaiwhefiascaimifaloifricm", "oeiafjigrofimaeorijfseorjgj", "aoiejfmosimfcijfloirajfsirg", "maoirjfoaaergaeergjfsfsafsm", "fliwaufsaedfsdfsadfehfaiwfa", "fmaforegwefawefwaefjfaiofja", "rjgmvwefasdasdfasfcsafsefrf", "reijfdefasfaefawefsoerigmer", "aormfaefrthfaefaefairjfoeig", "aimifaefaweffsawefaloifricm", "aeorijawrsthaewfgerfseorjgj", "ijfloirathsrhrsthrztqjfsirg", "maoirjfoaersfawgaageraergjm"]
          --mapM printSimpletest ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
          mapM forceSimpletest ["Test", "Absolue", "Rekonstruktion", "a", "Versicherungskaufmann", "b"]
          --mapM printSimpletest ["awejoawg", "sefawf", "dsefafg", "fiewajfwrg", "fwaeifa", "safwefwefaewf", "sfasfesv", "safsfsfg", "awefoe"]
          --mapM printSimpletest ["Weit", "hinten,", "hinter", "den", "Wortbergen,", "fern", "der", "Länder", "Vokalien", "und", "Konsonantien", "leben", "die", "Blindtexte.", "Abgeschieden", "wohnen", "Sie", "in", "Buchstabhausen", "an", "der", "Küste", "des", "Semantik,", "eines", "großen", "Sprachozeans.", "Ein", "kleines", "Bächlein", "namens", "Duden", "fließt", "durch", "ihren", "Ort", "und", "versorgt", "sie", "mit", "den", "nötigen", "Regelialien.", "Es", "ist", "ein", "paradiesmatisches", "Land,", "in", "dem", "einem", "gebratene", "Satzteile", "in", "den", "Mund", "fliegen.", "Nicht", "einmal", "von", "der", "allmächtigen", "Interpunktion", "werden", "die", "Blindtexte", "beherrscht", "–", "ein", "geradezu", "unorthographisches", "LebenEines", "Tages", "aber", "beschloß", "eine", "kleine", "Zeile", "Blindtext,", "ihr", "Name", "war", "Lorem", "Ipsum,", "hinaus", "zu", "gehen", "in", "die", "weite", "Grammatik.", "Der", "große", "Oxmox", "riet", "ihr", "davon", "ab,", "da", "es", "dort", "wimmele", "von", "bösen", "Kommata,", "wilden", "Fragezeichen", "und", "hinterhältigen", "Semikoli,", "doch", "das", "Blindtextchen", "ließ", "sich", "nicht", "beirren.", "Es", "packte", "seine", "sieben", "Versalien,", "schob", "sich", "sein", "Initial", "in", "den", "Gürtel", "und", "machte", "sich", "auf", "den", "WegAls", "es", "die", "ersten", "Hügel", "des", "Kursivgebirges", "erklommen", "hatte,", "warf", "es", "einen", "letzten", "Blick", "zurück", "auf", "die", "Skyline", "seiner", "Heimatstadt", "Buchstabhausen,", "die", "Headline", "von", "Alphabetdorf", "und", "die", "Subline", "seiner", "eigenen", "Straße,", "der", "Zeilengasse.", "Wehmütig", "lief", "ihm", "eine", "rethorische", "Frage", "über", "die", "Wange,", "dann", "setzte", "es", "seinen", "Weg", "fortUnterwegs", "traf", "es", "eine", "Copy.", "Die", "Copy", "warnte", "das", "Blindtextchen,", "da,", "wo", "sie", "herkäme", "wäre", "sie", "zigmal", "umgeschrieben", "worden", "und", "alles,", "was", "von", "ihrem", "Ursprung", "noch", "übrig", "wäre,", "sei", "das", "Wort", "und", "und", "das", "Blindtextchen", "solle", "umkehren", "und", "wieder", "in", "sein", "eigenes,", "sicheres", "Land", "zurückkehrenDoch", "alles", "Gutzureden", "konnte", "es", "nicht", "überzeugen", "und", "so", "dauerte", "es", "nicht", "lange,", "bis", "ihm", "ein", "paar", "heimtückische", "Werbetexter", "auflauerten,", "es", "mit", "Longe", "und", "Parole", "betrunken", "machten", "und", "es", "dann", "in", "ihre", "Agentur", "schleppten,", "wo", "sie", "es", "für", "ihre", "Projekte", "wieder", "und", "wieder", "mißbrauchten.", "Und", "wenn", "es", "nicht", "umgeschrieben", "wurde,", "dann", "benutzen", "Sie", "es", "immernoch."]
          -- mapM printSimpletest ["Schornsteinfegerinnen","SchornsteinfegerInnen","Schnittstellenwandler","Schnittstellentreiber","Schnittstellennummern","Schnittstellenadapter","Schnelligkeitsrekorde","Schnellfeuergesch\252tze","Schneidwarenindustrie","Schneidringverbindung","Schneidkopfunterkante","Schneidkopfbewegungen","Schl\252sseltechnologien","Schlitzwanderstellung","Schlittenkonstruktion","Schlichtungsvorschlag","Schlichtungsausschuss","Schleuserkriminalit\228t","Schlechtwetterperiode","Schlaganfallpatientin","SchlaganfallpatientIn","Schlaganfallpatienten","Schildb\252rgerstreichen","Schildausbausteuerung","steuerungstechnischer","steuerungstechnischen","steuerungstechnischem","steuerungstechnisches","stempeldruckabh\228ngige","stammesgeschichtliche","spritzwassergesch\252tzt","speicherprogrammierte","speicherplatzintensiv","sozialpsychologischer","sozialpsychologischen","sozialpsychologischem","sozialpsychologisches","softwaretechnologisch","sicherungs\252bereignete","sicherheitstechnische","sicherheitsrelevanter","sicherheitsrelevanten","sicherheitsrelevantem","sicherheitsrelevantes","sicherheitspolitische","sicherheitskritischer","sicherheitskritischen","sicherheitskritischem","sicherheitskritisches","sicherheitsgerichtete","selbstzerst\246rerischer","selbstzerst\246rerischen","selbstzerst\246rerischem","selbstzerst\246rerisches"]
