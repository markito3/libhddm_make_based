BASENAMES = hddm_s hddm_r hddm_mc_s
MADE_CPP = $(addprefix .src/, $(addsuffix .cpp, $(BASENAMES)))
MADE_HPP = $(addprefix .src/, $(addsuffix .hpp, $(BASENAMES)))
MADE_PYTHON = $(addprefix .python/, $(addsuffix .py, $(BASENAMES)))
MADE_PYTHON_SETUP = $(addprefix setup_, $(addsuffix .py, $(BASENAMES)))
PYTHON_MODULES = $(addprefix .so/, $(addsuffix .so, $(BASENAMES)))
OBJECTS1 = $(addsuffix .o, $(BASENAMES))
OBJECTS =  $(addprefix .obj/, $(OBJECTS1))
CPPFLAGS = -I.src -I$(XSTREAM_HOME)/include -I$(PARTICLETYPE_HOME)
CXXFLAGS = -fPIC

all: mkdirs $(MADE_HPP) .lib/libhddm.a $(PYTHON_MODULES)
#.so/hddm_s.so .so/hddm_r.so

mkdirs:
	test -d .obj || mkdir .obj
	test -d .lib || mkdir .lib
	test -d .src || mkdir .src
	test -d .so || mkdir .so

.src/hddm_r.cpp .src/hddm_r.hpp: rest.xml
	hddm-cpp -o $(basename $@) $<

.src/hddm_s.cpp .src/hddm_s.hpp: event.xml
	hddm-cpp -o $(basename $@) $<

.src/hddm_mc_s.cpp .src/hddm_mc_s.hpp: mc.xml
	hddm-cpp -o $(basename $@) $<

.obj/%.o: .src/%.cpp
	$(CXX) -c -o $@ $(CXXFLAGS) $(CPPFLAGS) $<

setup_hddm_r.py pyhddm_r.cpy: rest.xml
	hddm-py $<

setup_hddm_s.py pyhddm_s.cpy: event.xml
	hddm-py $<

setup_hddm_mc_s.py pyhddm_mc_s.cpy: mc.xml
	hddm-py $<

.so/%.so: setup_%.py
	python2 setup_$*.py build -b build_$*
	mv -v $*.so .so

.lib/libhddm.a: $(OBJECTS)
	ar rc $@ $(OBJECTS) $@

install: all
	test -d ../include/HDDM || mkdir -p ../include/HDDM
	install $(MADE_HPP) ../include/HDDM
	test -d ../lib || mkdir -p ../lib
	install .lib/libhddm.a ../lib

env:
	@echo MADE_CPP = $(MADE_CPP)
