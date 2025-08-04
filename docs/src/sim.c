#include <stdlib.h>
#include <math.h>

int max_particles;

struct particle {
  float x;
  float y;
  float x_velocity;
  float y_velocity;
};

struct line {
  float x1;
  float y1;
  float x2;
  float y2;
};

struct particle *particles;

struct line *lines;
int line_count;

void init_particles(int window_width, int window_height, int count){
  max_particles = count;

  particles = (struct particle *)calloc(max_particles, sizeof(struct particle));

  lines = (struct line *)calloc(max_particles * max_particles, sizeof(struct line));// yeah i know

  float speed = 1;

  for (int i = 0; i < max_particles; i++){
    particles[i].x = rand() % window_width;
    particles[i].y = rand() % window_height;
    particles[i].x_velocity = ((float)(rand() % 100) / 100.0f - 0.5f) * speed;
    particles[i].y_velocity = ((float)(rand() % 100) / 100.0f - 0.5f) * speed;
  }
}

void update_particles(int window_width, int window_height){
  for (int i = 0; i < max_particles; i++){
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

int close(float x1, float y1, float x2, float y2, float threshold){
  if (pow(pow(x1 - x2, 2) + pow(y1 - y2, 2),0.5) < threshold){
    return 1;
  }
  return 0;
}

void append_line(float x1, float y1, float x2, float y2){
  lines[line_count].x1 = x1;
  lines[line_count].y1 = y1;
  lines[line_count].x2 = x2;
  lines[line_count].y2 = y2;
  line_count++;
}

void generate_lines(){
  line_count = 0;

  for(int point_1 = 0; point_1 < max_particles; point_1++){
    for(int point_2 = 0; point_2 < max_particles; point_2++){
      if (point_1 == point_2){
        continue;
      }

      if (close(particles[point_1].x, particles[point_1].y, particles[point_2].x, particles[point_2].y, 70)){
        append_line(particles[point_1].x, particles[point_1].y, particles[point_2].x, particles[point_2].y);
      }
    }
  }
}

int get_line_count(){
  return line_count;
}

struct particle *get_particles(){
  return particles;
}

struct line *get_lines(){
  return lines;
}
