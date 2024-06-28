#include "memoread.h"

#include <stdio.h> 
#include <stdlib.h>
#include <dirent.h>

#include <fcntl.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <sys/types.h>

#include <unistd.h>
#include <sys/mman.h>

size_t select_shm()
{
    struct dirent *de;
    DIR *dr;
   
    struct stat statbuf;

    size_t max_selection;
    size_t selection;
        
    if (!(dr = opendir("/dev/shm")))
    { 
        exit(1);
    }
    
    for(max_selection = 1; (de = readdir(dr)); max_selection++)
    {
	lstat(de->d_name, &statbuf);
        
        if(!S_ISDIR(statbuf.st_mode))
	{
            printf("%lu. %s\n", max_selection, de->d_name);
        }
    }
    closedir(dr);
    
    while(scanf("%lu", &selection) < 1 || selection < 1 || selection >= max_selection);

    return selection;
}

int main()
{


 #define MAPNAME "/M6532RAM"
 
  const int fd = shm_open(MAPNAME,
       O_CREAT | O_RDWR,
       S_IRUSR | S_IWUSR);
  (void)! ftruncate(fd, 1024);
  (void) mmap(NULL, 1024,
               PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
  close(fd);


    printf("Selected: %lu\n", select_shm());
}
