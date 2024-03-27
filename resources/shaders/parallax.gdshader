shader_type canvas_item;
uniform float speed = 0.01;

void fragment () {
	COLOR = texture(TEXTURE, vec2(UV.x + TIME * speed, UV.y));
}