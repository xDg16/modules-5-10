#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>

// Handler for SIGTERM
void handle_sigterm(int sig) {
    printf("\nParent received SIGTERM (signal %d). Cleaning up and exiting gracefully...\n", sig);
    exit(0);
}

// Handler for SIGINT
void handle_sigint(int sig) {
    printf("\nParent received SIGINT (signal %d). Performing different cleanup and exiting gracefully...\n", sig);
    exit(0);
}

int main() {
    pid_t pid1, pid2;

    // Register signal handlers
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    printf("Parent PID: %d\n", getpid());

    // Child 1 sends SIGTERM after 5 seconds
    pid1 = fork();
    if (pid1 == 0) {
        sleep(5);
        printf("Child 1 sending SIGTERM to parent (PID %d)\n", getppid());
        kill(getppid(), SIGTERM);
        exit(0);
    }

    // Child 2 sends SIGINT after 10 seconds
    pid2 = fork();
    if (pid2 == 0) {
        sleep(10);
        printf("Child 2 sending SIGINT to parent (PID %d)\n", getppid());
        kill(getppid(), SIGINT);
        exit(0);
    }

    // Parent runs indefinitely
    while (1) {
        printf("Parent running...\n");
        sleep(1);
    }

    return 0;
}
