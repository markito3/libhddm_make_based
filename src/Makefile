MADE_CODE_BASENAMES = hddm_r hddm_s
MADE_CPP = $(addsuffix .cpp, $(MADE_CODE_BASENAMES))
MADE_HPP = $(addsuffix .hpp, $(MADE_CODE_BASENAMES))
SOURCES = $(wildcard *.cc)
BASENAMES = $(basename $(SOURCES))
OBJECTS1 = $(addsuffix .o, $(BASENAMES))
OBJECTS =  $(addprefix .obj/, $(OBJECTS1))
CPPFLAGS = -I../include -I/home/marki/cleave/particleType -I$(XSTREAM_HOME)/include -I$(JANA_HOME)/include -I$(ROOTSYS)/include

all: $(MADE_CPP) $(MADE_HPP) .lib/libHDDM.a

hddm_r.cpp hddm_r.hpp: rest.xml
	hddm-cpp -o $(basename $@) rest.xml

hddm_s.cpp hddm_s.hpp: event.xml
	hddm-cpp -o $(basename $@) event.xml

install_includes:
	test -d ../include/HDDM || mkdir -p ../include/HDDM
	install $(wildcard *.h) ../include/HDDM

.obj/%.o: %.cc
	$(CXX) -o $@ $(CPPFLAGS) $<

.lib/libHDDM.a: install_includes $(OBJECTS)
	test -d .lib || mkdir .lib
	ar rc $@ $(OBJECTS) $@

install: all
	test -d ../include/HDDM || mkdir -p ../include/HDDM
	install $(MADE_HPP) ../include/HDDM
	test -d ../lib || mkdir -p ../lib
	install .lib/libHDDM.a ../lib

