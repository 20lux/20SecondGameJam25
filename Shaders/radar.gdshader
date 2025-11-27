shader_type canvas_item;

uniform float line_thickness: hint_range(0.01, 1.0, 0.01) = 0.1;
uniform float speed: hint_range(0.1, 20.0, 0.1) = 5.0;
uniform vec3 line_color: source_color = vec3(0.0, 1.0, 0.0);
uniform float zoom: hint_range(1.0, 100.0, 0.1) = 10.0;
uniform int line_count: hint_range(1, 100, 1) = 10;
uniform float line_zoom: hint_range(0.1, 10.0, 0.1) = 2.0;
uniform float step_size: hint_range(0.1, 10.0, 0.1) = 1.0;
uniform float fade_factor: hint_range(0.1, 1.0, 0.01) = 0.75;
uniform float line_factor: hint_range(0.0, 1.0, 0.1) = 0.1;

float draw_line(vec2 uv, vec2 a, vec2 b) {
	vec2 pa = uv - a;
	vec2 ba = b - a;
	float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
	return 1.0 - smoothstep(line_thickness * 0.8, line_thickness * 1.2, length(pa - ba * h));
}

void fragment() {
	vec2 uv = UV - 0.5;
	uv *= zoom;
	float time = TIME * speed;
	vec3 color = vec3(0.0);
	for (int i = 0; i < line_count; i++) {
		time += step_size;
		color *= fade_factor;
		vec2 a = vec2(sin(time * line_factor), cos(time * line_factor));
		vec2 b = vec2(cos(time * line_factor), sin(time * line_factor));
		color += draw_line(uv, a * line_zoom, b * line_zoom) * line_color;
	}
	COLOR = vec4(color, 1.0);
}

