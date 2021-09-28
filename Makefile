all:
	make -C proposal/
	make -C report/

clean:
	make clean -C proposal/
	make clean -C report/