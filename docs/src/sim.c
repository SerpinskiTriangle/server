#include <stdlib.h>
#define MAX_PARTICLES 1

struct particle {
  float x;
  float y;
  float x_velocity;
  float y_velocity;
};

struct particle particles[MAX_PARTICLES];

void init_particles(int window_height, int window_width){
  for (int i = 0; i < MAX_PARTICLES; i++){
    particles[i].x = 3;
    particles[i].y = 3;
    particles[i].x_velocity = 3;
    particles[i].y_velocity = 3;
  }
}

void update_particles(int window_height, int window_width){
  for (int i = 0; i < MAX_PARTICLES; i++){
    particles[i].x += particles[i].x_velocity;
    particles[i].y += particles[i].y_velocity;

    if (particles[i].x > window_width || particles[i].x < 0){
      particles[i].x_velocity *= -1;
    }

    if (particles[i].y > window_height || particles[i].y < 0){
      particles[i].y_velocity *= -1;
    }
  }
}
struct particle *get_particles(){
  return particles;
}
