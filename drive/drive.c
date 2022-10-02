#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <signal.h>
int pwml;
int pwmr;
int gpiol;
int gpior;
int openIo(char *name){
	int ret = open(name,O_WRONLY);
	if (ret < 0){
		perror(name);
		exit(1);
	}
	return ret;
}

static void handler(int signum) {
	dprintf(pwmr,"%d",0);
	dprintf(pwml,"%d",0);
	exit(0);
}
int drive(){
	int left,right,oleft,oright;
	int v;
	float pct;
	oleft =0;
	oright =0;
	while(1){
		scanf("%d|%d %f\n",&left,&right,&pct);
		if (oleft != left){
			oleft = left;
			if (left < 0){
				dprintf(gpiol,"%d",1);
				left = left * -1;
			}else {
				dprintf(gpiol,"%d",0);
			}
			if (left > 1000000){
				left = 1000000;
			}
			dprintf(pwml,"%d",left);
		}
		if (oright != right){
			oright = right;
			if (right < 0){
				dprintf(gpior,"%d",1);
				right = right * -1;
			}else {
				dprintf(gpior,"%d",0);
			}
			if (right > 1000000){
				right = 1000000;
			}
			dprintf(pwmr,"%d",right);
		}
		printf("%d %d %f\n",left,right,pct);
	}
}
int main(int argc, char *argv[]){
	struct sigaction sa;
	// takes 4 args
	//
	if (argc != 5){
		fprintf(stderr,"wrong argc , got %d expecting 5\n",argc);
		exit(1);
	}
	pwml=openIo(argv[1]);
	pwmr=openIo(argv[2]);
	gpiol=openIo(argv[3]);
	gpiol=openIo(argv[4]);
       sa.sa_handler = handler;
       sigemptyset(&sa.sa_mask);
       sa.sa_flags = SA_RESTART; /* Restart functions if
				    interrupted by handler */
       if (sigaction(SIGINT, &sa, NULL) == -1){
	       perror("cant catch sigint");
       }

	drive();
}


