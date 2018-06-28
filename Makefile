
TREMA = ../../trema
GEM_BIN = `ruby -e 'require "rubygems"; puts Gem::bindir'`
SHELL = /bin/sh

TREMA_CONFIG = $(shell which trema-config)
ifeq ($(TREMA_CONFIG),)
  TREMA_CONFIG = $(TREMA)/trema-config
endif

CC = gcc
CFLAGS = $(shell $(TREMA_CONFIG) --cflags) -I../topology -g -std=gnu99 -D_GNU_SOURCE -fno-strict-aliasing -Werror -Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align -Wwrite-strings -Wconversion -Wfloat-equal -Wpointer-arith
LDFLAGS = $(shell $(TREMA_CONFIG) --libs) -L../topology -ltopology

TARGET = routing_switch
SRCS = fdb.c libpathresolver.c port.c routing_switch.c
OBJS = $(SRCS:.c=.o)

FEATURES = routing_switch.feature

DEPENDS = .depends

.PHONY: all clean

.SUFFIXES: .c .o

all: depend $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

.c.o:
	$(CC) $(CFLAGS) -c $<

depend:
	$(CC) -MM $(CFLAGS) $(SRCS) > $(DEPENDS)

clean:
	@rm -rf $(DEPENDS) $(OBJS) $(TARGET) *~

run_acceptance_test:
	@for feature in $(FEATURES); do \
	  ( \
	    file=`pwd`/$$feature; \
	    cd ${TREMA}; \
	    ${GEM_BIN}/cucumber -r ../apps/routing_switch/features $$file; \
	  ) \
	done

cbench:
	( \
          set -x; \
          cd ${TREMA}; \
	  ./trema run -c ../apps/routing_switch/routing_switch_null.conf -d; \
	  objects/oflops/bin/cbench --switches 1 --loops 10 --delay 15000; \
	  objects/oflops/bin/cbench --switches 1 --loops 10 --delay 15000 --throughput; \
          ./trema killall; \
	)

-include $(DEPENDS)
