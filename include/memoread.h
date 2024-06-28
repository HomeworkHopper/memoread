
#include <pthread.h>

typedef struct _Memoread
{
    pthread_mutex_t mutex;
} Memoread;


void memoread_init(Memoread *memoread);
