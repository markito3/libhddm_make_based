BASENAMES = hddm_r hddm_s
MADE_CPP = $(addsuffix .cpp, $(BASENAMES))
MADE_HPP = $(addsuffix .hpp, $(BASENAMES))
OBJECTS1 = $(addsuffix .o, $(BASENAMES))
OBJECTS =  $(addprefix .obj/, $(OBJECTS1))
#CPPFLAGS = -I../include -I$(XSTREAM_HOME)/include
CPPFLAGS = -I$(XSTREAM_HOME)/include -I/home/marki/cleave/particleType
CXXFLAGS = -fPIC

all: $(MADE_HPP) .lib/libhddm.a

hddm_r.cpp hddm_r.hpp: rest.xml
	hddm-cpp -o $(basename $@) rest.xml

hddm_s.cpp hddm_s.hpp: event.xml
	hddm-cpp -o $(basename $@) event.xml

.obj/%.o: %.cpp
	test -d .obj || mkdir .obj
	$(CXX) -c -o $@ $(CXXFLAGS) $(CPPFLAGS) $<

.lib/libhddm.a: $(OBJECTS)
	test -d .lib || mkdir .lib
	ar rc $@ $(OBJECTS) $@

install: all
	test -d ../include/HDDM || mkdir -p ../include/HDDM
	install $(MADE_HPP) ../include/HDDM
	test -d ../lib || mkdir -p ../lib
	install .lib/libhddm.a ../lib

