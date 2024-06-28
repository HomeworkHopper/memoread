#include "memoread.h"

void memoread_init(Memoread *memoread)
{
    pthread_mutex_init(&memoread->mutex, NULL);
}
