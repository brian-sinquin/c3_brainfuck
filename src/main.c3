module brainfuck;
import std::io;

const MAX_FILESIZE = 10*2048;

fn int main(String[] args)
{
	if (args.len < 2) 
	{
		io::printfn("Usage: %s <file>", args[0]);
		return -1;
	}

	if (!io::file::is_file(args[1])) {
		io::printfn("Unable to open %s, file may not exists", args[1]);
		return -1;
	}

	usz size = io::file::get_size(args[1])!!;
	if (size > MAX_FILESIZE )
	{
		io::printfn("File size is too big : %s / %s bytes", size, MAX_FILESIZE);
		return -1;
	}

    char[]! program = io::file::load_new(args[1]);
    if (catch excuse = program)
    {
        io::printfn("Cannot read file : %s", excuse);
        return -1; 
    }

    brainfuck(program);

	return 0;
}

