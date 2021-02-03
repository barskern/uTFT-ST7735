# Makefile template for a shared library in C
# https://www.topbug.net/blog/2019/10/28/makefile-template-for-a-shared-library-in-c-with-explanations/

CC = avr-gcc  # C compiler
CFLAGS = -mmcu=atmega2560 -fPIC -Wall -Wextra -O0 -g  # C flags
RM = rm -f   # rm command
TARGET_LIB = libuTFT_ST7735.a  # target lib

SRCS = uTFT_ST7735.c
OBJS = $(SRCS:.c=.o)

.PHONY: all
all: ${TARGET_LIB}

$(TARGET_LIB): $(OBJS)
	ar rcs $@ $^

$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

include $(SRCS:.c=.d)

.PHONY: clean
clean:
	-${RM} ${TARGET_LIB} ${OBJS} $(SRCS:.c=.d)
