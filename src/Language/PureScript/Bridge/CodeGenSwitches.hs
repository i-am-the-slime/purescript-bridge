-- | general switches for the code generation, such as generating profunctor-lenses or not
module Language.PureScript.Bridge.CodeGenSwitches 
    ( Settings (..)
    , defaultSettings
    , purs_0_11_settings
    , Switch
    , getSettings
    , defaultSwitch
    , noLenses, genLenses
    , useGen, useGenRep
    ) where


import Data.Monoid (Endo(..))

-- |general settings for code generation
data Settings = Settings
    { generateLenses :: Bool -- ^use purescript-profunctor-lens for generated PS-types?
    , genericsGenRep :: Bool -- ^generate generics using purescript-generics-rep instead of purescript-generics
    }
    deriving (Eq, Show)


-- |Settings to generate Lenses
defaultSettings :: Settings
defaultSettings = Settings True True

-- |settings for purescript 0.11.x
purs_0_11_settings :: Settings
purs_0_11_settings = Settings True False


-- |you can `mappend` switches to control the code generation
type Switch = Endo Settings


-- |translate switches into settings
getSettings :: Switch -> Settings
getSettings switch = appEndo switch defaultSettings


-- |default switches include code generation for lenses
defaultSwitch :: Switch
defaultSwitch = mempty


-- |switch off the generatation of profunctor-lenses
noLenses :: Switch
noLenses = Endo $ \settings -> settings { generateLenses = False }


-- |switch on the generatation of profunctor-lenses
genLenses :: Switch
genLenses = Endo $ \settings -> settings { generateLenses = True }


-- |generate generics using purescript-generics-rep
useGenRep :: Switch
useGenRep = Endo $ \settings -> settings { genericsGenRep = True }


-- |generate generics using purescript-generics
useGen :: Switch
useGen = Endo $ \settings -> settings { genericsGenRep = False }

