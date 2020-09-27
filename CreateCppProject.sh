#!/bin/sh

mkdir $1 && cd $1
mkdir sources && mkdir headers && mkdir bin

printf "build:\n\tg++ -g main.cpp -o bin/app\nrun:\n\t./bin/app" >> Makefile 
printf "#include <iostream>\n\nint main()\n{\n\tstd::cout << \"Hello World!\" << std::endl;;\n\treturn 0;\n}" >> main.cpp 

make build && make run
