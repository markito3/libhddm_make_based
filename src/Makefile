BASENAMES = hddm_r hddm_s
MADE_CPP = $(addprefix .src/, $(addsuffix .cpp, $(BASENAMES)))
MADE_HPP = $(addprefix .src/, $(addsuffix .hpp, $(BASENAMES)))
MADE_PYTHON = $(addprefix .python/, $(addsuffix .py, $(BASENAMES)))
MADE_PYTHON_SETUP = $(addprefix .python/setup_, $(addsuffix .py, $(BASENAMES)))
OBJECTS1 = $(addsuffix .o, $(BASENAMES))
OBJECTS =  $(addprefix .obj/, $(OBJECTS1))
CPPFLAGS = -I.src -I$(XSTREAM_HOME)/include -I$(PARTICLETYPE_HOME)
CXXFLAGS = -fPIC

all: .mkdirs_done $(MADE_HPP) .lib/libhddm.a .so/hddm_r.so

.mkdirs_done:
	test -d .obj || mkdir .obj
	test -d .lib || mkdir .lib
	test -d .src || mkdir .src
	test -d .python || mkdir .python
	test -d .so || mkdir .so
	date >$@

.src/hddm_r.cpp .src/hddm_r.hpp: rest.xml
	hddm-cpp -o $(basename $@) $<

.src/hddm_s.cpp .src/hddm_s.hpp: event.xml
	hddm-cpp -o $(basename $@) $<

.obj/%.o: .src/%.cpp
	$(CXX) -c -o $@ $(CXXFLAGS) $(CPPFLAGS) $<

.python/setup_hddm_r.py .python/hddm_r.py: rest.xml
	cd .python ; hddm-py ../$<

.so/%.so: .python/setup_%.py
	cd .so ; python2 ../.python/setup_$*.py build

.lib/libhddm.a: $(OBJECTS)
	ar rc $@ $(OBJECTS) $@

install: all
	test -d ../include/HDDM || mkdir -p ../include/HDDM
	install $(MADE_HPP) ../include/HDDM
	test -d ../lib || mkdir -p ../lib
	install .lib/libhddm.a ../lib

env:
	@echo MADE_CPP = $(MADE_CPP)
