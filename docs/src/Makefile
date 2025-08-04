CC 		 = emcc
TARGET = sim
FLAGS	 = -s EXPORTED_FUNCTIONS="['_init_particles', '_update_particles', '_get_particles', '_get_lines', '_get_line_count', '_generate_lines']" -s EXPORTED_RUNTIME_METHODS="['ccall', 'cwrap', 'HEAPF32']" -s ALLOW_MEMORY_GROWTH=1 -O3

build: $(TARGET).c
	$(CC) $(TARGET).c -o $(TARGET).js $(FLAGS)
