#
# Author: Peterson Yuhala
# This is a custom makefile for zlib and is 
# very different from the official makefile.
# It compiles and works Ok for the purpose of 
# my work.
#

CC := gcc
AR := ar

SRC := .
INCLUDE_PATHS := -I.

#
# No stack protector used so gcc does not use canaries
# to prevent buffer overflows. This is for education purposes
# so we see the results of a buffer overflow.
#
COMPILE_FLAGS := $(INCLUDE_PATHS) 
LD_FLAGS := -lm

HEADERS := $(wildcard ./headers/*.h)

ZLIB := zlib.a

.PHONY: clean

all: $(ZLIB)

APP_C_FILES := $(wildcard $(SRC)/*.c)
APP_OBJS := $(APP_C_FILES:.c=.o)


$(SRC)/%.o:	$(SRC)/%.c $(HEADERS)
	@$(CC) $(COMPILE_FLAGS) -c $< -o $@
	@echo "CC <= $<" 

$(ZLIB):	$(APP_OBJS)
	@$(AR) rcs $@ $^



clean:
	@rm $(ZLIB) $(APP_OBJS) 
