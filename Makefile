CXX := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -O3 -I.
AR := ar
ARFLAGS := rcs

SRC := input_parser.cpp
OBJ := $(SRC:.cpp=.o)
LIB := libinput_parser.a
HEADER := input_parser.hpp
PREFIX := /usr/local

.PHONY: all clean install uninstall

all: $(LIB)

$(LIB): $(OBJ)
	$(AR) $(ARFLAGS) $@ $^

$(OBJ): $(SRC) $(HEADER)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(LIB)

install: $(LIB) $(HEADER)
	mkdir -p $(PREFIX)/lib
	mkdir -p $(PREFIX)/include
	cp $(LIB) $(PREFIX)/lib
	cp $(HEADER) $(PREFIX)/include

uninstall:
	rm -f $(PREFIX)/lib/$(LIB)
	rm -f $(PREFIX)/include/$(HEADER)
