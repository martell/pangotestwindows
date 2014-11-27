VIEWDO_SOURCES = \
            text/pango/ViewdoPangoRenderer.cpp \
            text/pango/ViewdoGlyphCache.cpp \
            text/pango/ViewdoGLRenderer.cpp

all: examples/text

VIEWDO_OBJECTS = $(addsuffix .o, $(basename $(filter %.c %.cpp %.cc,$(VIEWDO_SOURCES))))

CFLAGS = \
    -g \
	-fvisibility=hidden -fno-exceptions \
	-I. -Ithird_party/dawgdic/src \
    -Itext/pango \
    `pkg-config --cflags pango freetype2 glib-2.0`

LDFLAGS = -lpthread `pkg-config --libs pango pangoft2 freetype2 glib-2.0 gobject-2.0 gthread-2.0 gmodule-2.0 glfw3` -lglu32 -lglew32 -lopengl32

.c.o:
	@echo Compile C $<
	@$(CC) -Wall -Wextra -Wno-unused-parameter $(CFLAGS) -c $< -o $@

.cpp.o:
	@echo Compile C++ $<
	@${CXX} -Wall -Wextra -std=c++11 $(CFLAGS) -c $< -o $@

.cc.o:
	@echo Compile C++ $<
	@${CXX} -std=c++11 $(CFLAGS) -c $< -o $@

examples/text: ${VIEWDO_OBJECTS} examples/text.o
	@echo Link $@
	@${CXX} ${VIEWDO_OBJECTS} examples/text.o ${LDFLAGS} -o $@

clean:
	@rm -f ${OBJECTS} examples/text examples/text.o