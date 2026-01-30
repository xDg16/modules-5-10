 
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int i;
    pid_t pid;
    int status;

    printf("Parent PID: %d\n", getpid());

    // Create 3 child processes
    for (i = 0; i < 3; i++) {
        pid = fork();

        if (pid == 0) {
            // Child process
            printf("Child created with PID: %d\n", getpid());
            sleep(1);
            exit(0);
        } 
        else if (pid < 0) {
            perror("fork failed");
            exit(1);
        }
    }

    // Parent waits for all children
    for (i = 0; i < 3; i++) {
        pid = wait(&status);
        if (pid > 0) {
            printf("Parent cleaned child with PID: %d\n", pid);
        }
    }

    return 0;
}
