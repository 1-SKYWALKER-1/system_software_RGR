CC := gcc
INCLUDE_DIR = include
INCLUDE_FLAG = -I$(INCLUDE_DIR)

LDFLAGS_USER ?=
LDFLAGS_FINAL = $(LDFLAGS_USER) -lm

CFLAGS_USER ?=
CFLAGS_FINAL = $(CFLAGS_USER) $(INCLUDE_FLAG)

BUILD_DIR = bin
TARGET = $(BUILD_DIR)/program
STATIC_TARGET = $(BUILD_DIR)/libmylib.a
OBJS = $(patsubst src/%.c, src/%.o, $(wildcard src/*.c))

$(shell mkdir -p $(BUILD_DIR))

ifeq ($(BUILD_TYPE),static)
$(TARGET): src/main.o $(STATIC_TARGET)
	$(CC) -static -o $@ $^ -L$(BUILD_DIR) -lmylib $(LDFLAGS_FINAL)
else
$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS_FINAL)
endif

$(STATIC_TARGET): $(filter-out src/main.o, $(OBJS))
	ar rcs $@ $^

$(OBJS): src/%.o : src/%.c
	$(CC) $(CFLAGS_FINAL) -c -o $@ $<

check:
	./checkpatch.pl --no-tree -f --showfile --fix-inplace src/*.c;

clean:
	rm -f $(OBJS)
	rm -rf $(BUILD_DIR)

.PHONY: check clean