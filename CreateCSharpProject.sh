#!/bin/sh
checkMakefile() {
    if [ ! -f Makefile  ]; then 
        touch Makefile
    fi
}

createApp() {
    printf "app with name \033[38;2;0;250;0m$1\033[39m will be create\n" 
    mkdir $1 && cd $1
    dotnet new console -lang C#
    cd ..
    checkMakefile
    printf "run:\n\tdotnet run --project $1" >> Makefile
}

createLib() {
    printf "lib with name \033[38;2;0;250;0m$1\033[39m will be create\n"
    mkdir $1 && cd $1
    dotnet new classlib -lang C#
    cd ..
}

createLibWithTest() {
    libName=$1
    testName=$2
    printf "lib with name \033[38;2;0;250;0m$libName\033[39m will be create with test lib\n"
    createLib $libName
    mkdir $testName && cd $testName
    dotnet new nunit -lang C#
    dotnet add reference ../$libName
    cd .. 
}

echo -n "Enter project name: "
read projectName
mkdir $projectName && cd $projectName
dotnet new sln

while [ -n "$1" ]
do
    case "$1" in
        -a) 
            appName="$projectName.$2.App"
            createApp $appName 
            dotnet sln add $appName
            shift ;;
        -l)  
            libName="$projectName.$2.Lib"
            createLib $libName        
            dotnet sln add $libName
            shift;;
        -lt)
            libName="$projectName.$2.Lib"
            testName="$libName.Test"
            createLibWithTest $libName $testName
            dotnet sln add $libName 
            dotnet sln add $testName
            shift ;;
        -nu)
            dotnet add package $2 
            shift ;;
    esac
    shift
done

git init
touch README.md && '$projectName' >> README.md
