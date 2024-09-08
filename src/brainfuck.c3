module brainfuck;
import std::io;
import libc;

const MEM_SIZE = 2048*10;

fn void brainfuck(char[] program) {

    int ip = 0;
    uint ptr = 0;
    int closed = 0;
    int opened = 0;
    char[] memory = mem::new_array(char, MEM_SIZE);

    while (ip < program.len) {

        switch (program[ip]) {

            case '>' : ptr++;break;
            case '<' : ptr--;break;
            case '+' : memory[ptr]++;break;
            case '-' : memory[ptr]--;break;
            case '.' : io::printf("%c", memory[ptr]);break;
            case ',' : memory[ptr] = (char) libc::getchar();break;

            case '[' : if (memory[ptr]==0) 
            {
                for (opened = 0, ip++; ip < program.len; ip++) {
					if (program[ip] == ']' && !opened) {break;}
					else if (program[ip] == '['){ opened++;}
					else if (program[ip] == ']'){ opened--;}
				} break;

            } 
            case ']' : if (memory[ptr]!=0) {
                for (closed = 0, ip--; ip >= 0; ip--) {
					if (program[ip] == '[' && !closed)
						{break;}
					else if (program[ip] == ']'){
						closed++;}
					else if (program[ip] == '['){
						closed--;}
				} 
            } break;
            default : break;

        }
        ip++;


    }

}

// > = increases memory pointer, or moves the pointer to the right 1 block.
// < = decreases memory pointer, or moves the pointer to the left 1 block.
// + = increases value stored at the block pointed to by the memory pointer
// - = decreases value stored at the block pointed to by the memory pointer
// [ = like c while(cur_block_value != 0) loop.
// ] = if block currently pointed to's value is not zero, jump back to [
// , = like c getchar(). input 1 character.
// . = like c putchar(). io::print 1 character to the console