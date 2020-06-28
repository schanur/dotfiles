#include <stdio.h>
#include <math.h>
#include <float.h>

#include <malloc.h>
#include <inttypes.h>

#include <png.h>

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"


#define MIN(a,b)   (((a)<(b))?(a):(b))
#define MAX(a,b)   (((a)>(b))?(a):(b))

#define PIXEL(x,y) (&(image[(x * image_res[0] + y) * 3]))


static const int RIGHT = 0;
static const int UP    = 1;
static const int LEFT  = 2;
static const int DOWN  = 3;


typedef struct draw_pos_state_t {
    int x;
    int y;
    int direction;
    int same_direction_cnt;
    int direction_change_cnt;
    int curr_direction_length;
} draw_state_t;


void init_draw_pos(draw_state_t * draw_state) {
    draw_state->x                     = 0;
    draw_state->y                     = 0;
    draw_state->direction             = RIGHT;
    draw_state->same_direction_cnt    = 0;
    draw_state->direction_change_cnt  = 0;
    draw_state->curr_direction_length = 1;
}


void next_draw_pos(draw_state_t * draw_state) {
    switch (draw_state->direction) {
    case RIGHT: draw_state->x++; break;
    case UP:    draw_state->y--; break;
    case LEFT:  draw_state->x--; break;
    case DOWN:  draw_state->y++; break;
    }

    draw_state->same_direction_cnt++;
    if (draw_state->same_direction_cnt == draw_state->curr_direction_length) {
        draw_state->same_direction_cnt = 0;
        draw_state->direction = (draw_state->direction + 1) % 4;
        draw_state->direction_change_cnt++;
        if (!(draw_state->direction_change_cnt % 2)) {
            draw_state->curr_direction_length++;
        }
    }
}


int is_prime_num(uint64_t num)
{
    uint64_t j, i_sqrt;
    int      is_prime = 1;

    if (num != 1) {
        i_sqrt = sqrt (num);
        for (j = 2; j <= i_sqrt; j++)
        {
            if (num % j == 0)
            {
                is_prime = 0;
                break;
            }
        }
    } else {
        is_prime = 0;
    }

    return is_prime;
}


void parse_cmd_line_params(int argc, char* argv[], int *image_res) {
    char *x, *y;

    x = strtok(argv[1], "x");
    y = strtok(NULL,    "x");

    image_res[0] = atoi(x);
    image_res[1] = atoi(y);
}


int main(int argc, char* argv[])
{
    uint64_t      i, start, end;
    int           image_res[2];
    unsigned int  calc_size;
    draw_state_t  draw_state;
    uint8_t      *image;
    char          filename[4096];

    parse_cmd_line_params(argc, argv, image_res);
    init_draw_pos(&draw_state);

    calc_size = image_res[0] * image_res[1] * 8;
    start     = 1;
    end       = start + calc_size;
    image     = malloc(calc_size * 3);

    for (i = start; i <= end; i++)
    {
        int x = image_res[1] - ((image_res[1] / 2) + draw_state.x);
        int y = image_res[0] - ((image_res[0] / 2) + draw_state.y);

        if (!((   x < 0) || (x >= image_res[1])
              || (y < 0) || (y >= image_res[0]))) {

            uint8_t *pixel = PIXEL(x, y);

            pixel[0] = 0;
            pixel[1] = 0;
            pixel[2] = 0;

            if (is_prime_num(i)) {
                float x_f = (float) x / (float) image_res[1];
                float y_f = (float) y / (float) image_res[0];

                /* Colorize by position in image. */
                pixel[0]  = (uint8_t) MIN(x_f * 300.f, 255.f);
                pixel[1]  = (uint8_t) MIN(MAX(((1. - x_f) + (1. - (2. * y_f))) * 120.f, 0.), 190.f);
                pixel[2]  = (uint8_t) MIN(MAX((y_f - 0.2f) * 280.f, 0.f), 200.f);
            }
        }

        next_draw_pos(&draw_state);
    }

    snprintf(filename, 4095, "ulam_spiral_%ix%i_color.png", image_res[0], image_res[1]);
    stbi_write_png(filename, image_res[0], image_res[1], 3, image, 0);

    free(image);

    return 0;
}
