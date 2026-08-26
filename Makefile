main:
	ghc main.hs -o main.exe

run:
	.\main.exe

clean:
	del main.hi main.o main.exe
