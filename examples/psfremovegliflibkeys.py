#!/usr/bin/env python
'''Remove the specified key(s) from glif libs'''
__url__ = 'http://github.com/silnrsi/pysilfont'
__copyright__ = 'Copyright (c) 2017 SIL International (http://www.sil.org)'
__license__ = 'Released under the MIT License (http://opensource.org/licenses/MIT)'
__author__ = 'David Raymond'

from silfont.core import execute

argspec = [
    ('ifont',{'help': 'Input font file'}, {'type': 'infont'}),
    ('key',{'help': 'Key(s) to remove','nargs': '+' }, {}),
    ('-o', '--ofont',{'help': 'Output font file' }, {'type': 'outfont'}),
    ('-l','--log',{'help': 'Log file'}, {'type': 'outfile', 'def': '_removegliflibkeys.log'})]

def doit(args) :
    font = args.ifont
    logger = args.logger
    keys = args.key
    keycounts = {}
    for key in keys : keycounts[key] = 0

    for glyphn in font.deflayer :
        glyph = font.deflayer[glyphn]
        if glyph["lib"] :
            for key in keys :
                if key in glyph["lib"] :
                    val = str( glyph["lib"].getval(key))
                    glyph["lib"].remove(key)
                    keycounts[key] += 1
                    logger.log(key + " removed from " + "glyphn. Value was " + val, "I" )

    for key in keys :
        count = keycounts[key]
        if count > 0 :
            logger.log(key + " removed from " + str(count) +  " glyphs", "P")
        else :
            logger.log("No lib entries found for " + key, "E")

    return font

def cmd() : execute("UFO",doit,argspec)
if __name__ == "__main__": cmd()
