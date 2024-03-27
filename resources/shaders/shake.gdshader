shader_type canvas_item;

uniform float time_factor : hint_range(0, 100) = 50.0;
uniform float magnitude : hint_range(0, 100) = 10.0;
uniform float opacity : hint_range(0, 1) = 1.0;

void fragment() {
    vec2 offset = vec2(sin(TIME * time_factor), cos(TIME * time_factor)) * magnitude;
    vec2 uv = UV + offset;
    
    if (uv.x >= 0.0 && uv.x <= 1.0 && uv.y >= 0.0 && uv.y <= 1.0) {
        COLOR = texture(TEXTURE, uv);
    } else {
        COLOR = texture(TEXTURE, UV);
    }
    COLOR.a *= opacity;
}
