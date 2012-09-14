
import Data.Bits (shiftL)
import Data.Word
import Data.Int

-- This magical #include brings in all the everybody-knows-these magic
-- constants unfortunately, we need to be *explicit* about which one
-- we want; if we just hope a -I... will get the right one, we could
-- be in trouble.

{-
Pull in the autoconf defines (HAVE_FOO), but don't include
ghcconfig.h, because that will include ghcplatform.h which has the
wrong platform settings for the compiler (it has the platform
settings for the target plat instead).
-}
#include "../includes/ghcautoconf.h"

#include "stg/HaskellMachRegs.h"

#include "rts/Constants.h"
#include "MachDeps.h"
#include "../includes/dist-derivedconstants/header/DerivedConstants.h"

-- import Util

-- All pretty arbitrary:

mAX_TUPLE_SIZE :: Int
mAX_TUPLE_SIZE = 62 -- Should really match the number
                    -- of decls in Data.Tuple

mAX_CONTEXT_REDUCTION_DEPTH :: Int
mAX_CONTEXT_REDUCTION_DEPTH = 200
  -- Increase to 200; see Trac #5395

-- Size of a double in StgWords.

dOUBLE_SIZE :: Int
dOUBLE_SIZE = SIZEOF_DOUBLE

wORD64_SIZE :: Int
wORD64_SIZE = 8

-- This tells the native code generator the size of the spill
-- area is has available.

rESERVED_C_STACK_BYTES :: Int
rESERVED_C_STACK_BYTES = RESERVED_C_STACK_BYTES

-- The amount of (Haskell) stack to leave free for saving registers when
-- returning to the scheduler.

rESERVED_STACK_WORDS :: Int
rESERVED_STACK_WORDS = RESERVED_STACK_WORDS

-- Continuations that need more than this amount of stack should do their
-- own stack check (see bug #1466).

aP_STACK_SPLIM :: Int
aP_STACK_SPLIM = AP_STACK_SPLIM

-- Size of a word, in bytes

wORD_SIZE :: Int
wORD_SIZE = SIZEOF_HSWORD

wORD_SIZE_IN_BITS :: Int
wORD_SIZE_IN_BITS = wORD_SIZE * 8

-- Define a fixed-range integral type equivalent to the target Int/Word

#if SIZEOF_HSWORD == 4
type TargetInt  = Int32
type TargetWord = Word32
#elif SIZEOF_HSWORD == 8
type TargetInt  = Int64
type TargetWord = Word64
#else
#error unknown SIZEOF_HSWORD
#endif

tARGET_MIN_INT, tARGET_MAX_INT, tARGET_MAX_WORD :: Integer
tARGET_MIN_INT  = fromIntegral (minBound :: TargetInt)
tARGET_MAX_INT  = fromIntegral (maxBound :: TargetInt)
tARGET_MAX_WORD = fromIntegral (maxBound :: TargetWord)

tARGET_MAX_CHAR :: Int
tARGET_MAX_CHAR = 0x10ffff

-- Amount of pointer bits used for semi-tagging constructor closures

tAG_BITS :: Int
tAG_BITS = TAG_BITS

tAG_MASK :: Int
tAG_MASK = (1 `shiftL` tAG_BITS) - 1

mAX_PTR_TAG :: Int
mAX_PTR_TAG = tAG_MASK

-- Size of a C int, in bytes. May be smaller than wORD_SIZE.

cINT_SIZE :: Int
cINT_SIZE = SIZEOF_INT

cLONG_SIZE :: Int
cLONG_SIZE = SIZEOF_LONG

cLONG_LONG_SIZE :: Int
cLONG_LONG_SIZE = SIZEOF_LONG_LONG

-- Number of bits to shift a bitfield left by in an info table.

bITMAP_BITS_SHIFT :: Int
bITMAP_BITS_SHIFT = BITMAP_BITS_SHIFT

