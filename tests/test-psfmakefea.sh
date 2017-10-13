# this test script uses the Charis Reg UFO
# clone the Charis repo and checkout the commit indicated by Charis-test-commit-SHA.txt
#  in a directory parallel to pysilfont
# after the tests run, compare the generated files to their *-ref counterparts

# cd ../..
# git clone https://github.com/silnrsi/font-charis.git
# cd font-charis
# git checkout < ../pysilfont/tests/Charis-test-commit-SHA.txt #this does NOT work
# cd ../pysilfont/tests

# test class generation only
python ../lib/silfont/scripts/psfmakefea.py ../../font-charis/source/CharisSIL-Regular.ufo -o results/classes.fea

# test that the Charis fea will pass thru cleanly
# *** this will OVERWRITE any features.fea that is already present in the UFO
# at this time, no such file is present
#  the fea compilation typically starts with a file generated by make_fea in results/source
cp Charis-Reg-make_fea.fea ../../font-charis/source/CharisSIL-Regular.ufo/features.fea
python ../lib/silfont/scripts/psfmakefea.py ../../font-charis/source/CharisSIL-Regular.ufo -o results/features.fea  -i ../../font-charis/source/CharisSIL-Regular.ufo/features.fea
rm ../../font-charis/source/CharisSIL-Regular.ufo/features.fea

# this FAILS because the includes in the CharisSIL-Regular.fea are written assuming
#  that that file is itself included from source/results
# python ../lib/silfont/scripts/psfmakefea.py ../../font-charis/source/CharisSIL-Regular.ufo -o results/features.fea  -i ../../font-charis/source/opentype/CharisSIL-Regular.fea

# test the use of a base class for the bases in a mark to base position lookup
python ../lib/silfont/scripts/psfmakefea.py ../../font-charis/source/CharisSIL-Regular.ufo -o results/test-pos-baseClass-to-mark.fea -i test-pos-baseClass-to-mark.feax

# test the use of a mark class for the base marks in a mark to mark position lookup
python ../lib/silfont/scripts/psfmakefea.py ../../font-charis/source/CharisSIL-Regular.ufo -o results/test-pos-markClass-to-mark.fea -i test-pos-markClass-to-mark.feax

# test the use of a glyph class in a one-to-many substitution lookup
python ../lib/silfont/scripts/psfmakefea.py ../../font-charis/source/CharisSIL-Regular.ufo -o results/test-sub-1-to-many.fea -i test-sub-1-to-many.feax

# test the use of a glyph class in a many-to-one substitution lookup
python ../lib/silfont/scripts/psfmakefea.py ../../font-charis/source/CharisSIL-Regular.ufo -o results/test-sub-many-to-1.fea -i test-sub-many-to-1.feax

diff results/classes.fea results/classes-ref.fea
diff results/features.fea results/features-ref.fea
diff results/test-pos-baseClass-to-mark.fea results/test-pos-baseClass-to-mark-ref.fea
diff results/test-pos-markClass-to-mark.fea results/test-pos-markClass-to-mark-ref.fea
diff results/test-sub-1-to-many.fea results/test-sub-1-to-many-ref.fea
diff results/test-sub-many-to-1.fea results/test-sub-many-to-1-ref.fea
