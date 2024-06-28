include sources.mk

.PHONY: all

TARGET := build/app

all: $(TARGET)

define app_build_dir
$(1):
	mkdir -p $(1)

endef

obj_from_src = $(patsubst %.c,build/%.o,$(1))

OBJS := $(call obj_from_src,$(SRC))

$(info SRC == $(SRC))
$(info OBJS == $(OBJS))

$(foreach d,$(sort $(dir $(OBJS))),$(info $(call app_build_dir,$(d))))
$(foreach d,$(sort $(dir $(OBJS))),$(eval $(call app_build_dir,$(d))))

# NOTE: this is "CCFLAGS", not CFLAGS.
CCFLAGS += -D_GNU_SOURCE -pthread -I. -O1

define app_compile_src
$(call obj_from_src,$(1)): $(1) | $(dir $(call obj_from_src,$(1)))
	$(CC) -c $(CCFLAGS) -o $(call obj_from_src,$(1)) $(1)

endef

$(foreach src,$(SRC),$(info $(call app_compile_src,$(src))))
$(foreach src,$(SRC),$(eval $(call app_compile_src,$(src))))

LDLIBS += -lpthread -lrt -lssl -lcrypto

$(TARGET): $(OBJS) | build/
	$(CC) $(LDFLAGS) -o $(TARGET) $(OBJS) $(LDLIBS)

