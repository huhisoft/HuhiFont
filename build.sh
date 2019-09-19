#!/bin/sh
set -e
echo "Generating Static fonts"
mkdir -p ./out ./out/ttf ./out/otf
fontmake -g HuhiFont.glyphs -i -o ttf --output-dir ./out/ttf
fontmake -g HuhiFont_Italic.glyphs -i -o ttf --output-dir ./out/ttf

fontmake -g HuhiFont.glyphs -i -o otf --output-dir ./out/otf
fontmake -g HuhiFont_Italic.glyphs -i -o otf --output-dir ./out/otf
rm -rf instance_ufo/ master_ufo/


echo "Post processing"
ttfs=$(ls out/ttf/*.ttf)
for ttf in $ttfs
do
	gftools fix-dsig -f $ttf;
	ttfautohint $ttf "$ttf.fix";
	mv "$ttf.fix" $ttf;
	gftools fix-hinting $ttf;
	mv $ttf.fix $ttf;
done

