shader_type canvas_item;

uniform float speed_x = .01;
uniform float speed_y = .01;

uniform float direction_x = 1;
uniform float direction_y = -1;

void vertex() {
	UV.x += TIME * speed_x * direction_x;
	UV.y += TIME * speed_y * direction_y;
	
}
