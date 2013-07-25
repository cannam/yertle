
YETI_JARPATH	:= ../yeti
YETI_JARS	:= asm-3.1r yeti yeti-lib

CLASSPATH	:= $(patsubst %,$(YETI_JARPATH)/%.jar,$(YETI_JARS))
CLASSPATH	:= $(shell echo $(CLASSPATH) | tr ' ' ':')

SOURCES		:= \
	yertle/blank.yeti \
	yertle/char.yeti \
	yertle/collection.yeti \
	yertle/index.yeti \
	yertle/parsebits.yeti \
	yertle/prefix.yeti \
	yertle/read.yeti \
	yertle/store.yeti \
	yertle/ttlre.yeti \
	yertle/rdftypes.yeti \
	yertle/write.yeti \
	example/readwrite.yeti

TEST_SOURCES	:= \
	test/all.yeti \
	test/test_collection.yeti \
	test/test_index.yeti \
	test/test_prefix.yeti \
	test/test_read.yeti \
	test/test_spec.yeti \
	test/test_store.yeti \
	test/test_write.yeti \
	test/test.yeti

test/.run:	yertle.jar $(TEST_SOURCES)
	java -cp $(CLASSPATH) yeti.lang.compiler.yeti test/all.yeti | tee $@.out
	@grep -qv passed $@.out || touch $@

yertle.jar:	$(SOURCES)
	java -cp $(CLASSPATH) yeti.lang.compiler.yeti -d classes -doc doc $^
	jar cf $@ -C classes yertle -C classes example

clean:	
	rm -rf com

