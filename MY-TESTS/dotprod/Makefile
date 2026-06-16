CC = ccac
ARCH = -tcf=ev71_vfpu

HEADERS = -Hvdsp_vector_c
OPT = -O2
AUTOVEC = -fvectorize -fslp-vectorize -ffast-math

SRCS = main.c dotp.c
TARGET = a.out

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) $(ARCH) $(HEADERS) $(OPT) $(SRCS) -o $(TARGET)

run: $(TARGET)
	runac $(ARCH) $(TARGET)

ass: $(SRCS)
	$(CC) $(ARCH) $(HEADERS) $(OPT) -S $(SRCS)

ass-auto: $(SRCS)
	$(CC) $(ARCH) $(HEADERS) $(OPT) $(AUTOVEC) -S $(SRCS)

llvm: $(SRCS)
	$(CC) $(ARCH) $(HEADERS) $(OPT) -BS $(SRCS)

llvm-auto: $(SRCS)
	$(CC) $(ARCH) $(HEADERS) $(OPT) $(AUTOVEC) -BS $(SRCS)

auto:
	@echo "Build con autovettorizzazione..."
	$(CC) $(ARCH) $(HEADERS) $(OPT) $(AUTOVEC) $(SRCS) -o $(TARGET)

clean:
	@cmd /c del /f /q $(TARGET) *.ll *.s *.o 2>nul || rm -f $(TARGET) *.ll *.s 2>/dev/null
	@echo "Pulizia completata."

.PHONY: all clean run llvm auto clean_auto help