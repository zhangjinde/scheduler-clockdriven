#Uncomment to add Multi Processor affinity support
#FLAGS=-DMULTIPROC
FLAGS=-Wall
SLACK_STEALING=-DSLACK_STEALING
#BUSYCALIB_ADVANCED=-DBUSYCALIB_ADVANCED
#FRAME_HANDLER_SAME_PRIORITY=-DFRAME_HANDLER_SAME_PRIORITY

all:  task-example task-err task-sp task-sp-err task-sp-err-wcet

task-example: main.o executive.o task-example.o excstate.o busy.o
	gcc ${FLAGS} -o test-task-example main.o executive.o task-example.o excstate.o busy.o -lpthread -lrt

task-err: main.o executive.o task-err.o excstate.o busy.o
	gcc ${FLAGS} -o test-task-err main.o executive.o task-err.o excstate.o busy.o -lpthread -lrt

task-sp: main.o executive.o task-sp.o excstate.o busy.o
	gcc ${FLAGS} -o test-task-sp main.o executive.o task-sp.o excstate.o busy.o -lpthread -lrt

task-sp-err: main.o executive.o task-sp-err.o excstate.o busy.o
	gcc ${FLAGS} -o test-task-sp-err main.o executive.o task-sp-err.o excstate.o busy.o -lpthread -lrt

task-sp-err-wcet: main.o executive.o task-sp-err-wcet.o excstate.o busy.o
	gcc ${FLAGS} -o test-task-sp-err-wcet main.o executive.o task-sp-err-wcet.o excstate.o busy.o -lpthread -lrt

main.o: main.c
	gcc ${FLAGS} -c main.c -lpthread -lrt

executive.o: executive.c executive.h
	gcc ${FLAGS} ${SLACK_STEALING} ${FRAME_HANDLER_SAME_PRIORITY} -c executive.c -lpthread -lrt

excstate.o: excstate.c excstate.h
	gcc ${FLAGS} -c excstate.c -lpthread -lrt

task-example.o: task-example.c
	gcc ${FLAGS} -c task-example.c -lpthread -lrt

task-err.o: task-err.c
	gcc ${FLAGS} -c task-err.c -lpthread -lrt

task-sp.o: task-sp.c
	gcc ${FLAGS} -c task-sp.c -lpthread -lrt
	
task-sp-err.o: task-sp-err.c
	gcc ${FLAGS} -c task-sp-err.c -lpthread -lrt

task-sp-err-wcet.o: task-sp-err-wcet.c
	gcc ${FLAGS} -c task-sp-err-wcet.c -lpthread -lrt
	
busy.o: busy.c busy.h
	gcc ${FLAGS} ${BUSYCALIB_ADVANCED} -c busy.c

clean:
	rm -f *.o *~ test-*

