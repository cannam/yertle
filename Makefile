
YETI_JARPATH	:= ../yeti
YETI_JARS	:= asm-3.1r yeti yeti-lib

CLASSPATH	:= $(patsubst %,$(YETI_JARPATH)/%.jar,$(YETI_JARS))
CLASSPATH	:= $(shell echo $(CLASSPATH) | tr ' ' ':')

SOURCES		:= \
	yertle/blank.yeti \
	yertle/char.yeti \
	yertle/index.yeti \
	yertle/parsebits.yeti \
	yertle/prefix.yeti \
	yertle/read.yeti \
	yertle/store.yeti \
	yertle/ttlre.yeti \
	yertle/types.yeti \
	yertle/write.yeti \
	example/readwrite.yeti

yertle.jar:	$(SOURCES)
	( java -cp $(CLASSPATH) yeti.lang.compiler.yeti -d classes $^ )
	jar cf $@ -C classes yertle -C classes example

clean:	
	rm -rf com

