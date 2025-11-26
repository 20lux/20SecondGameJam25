shader_type sky;

uniform sampler2D sky_texture: source_color, filter_linear, hint_default_black;
uniform vec3 sun_pos = vec3(0.0);
uniform vec3 color: source_color;

void sky() {
	if (AT_CUBEMAP_PASS) {
		COLOR = color;
	} else {
		COLOR = texture(sky_texture, SKY_COORDS).rgb;
		float ds = max(dot(normalize(sun_pos - POSITION), EYEDIR), 0.0); // direction to sun
		COLOR += pow(vec3(pow(ds, 40.0), pow(ds, 60.0), pow(ds, 100.0)), vec3(2.0));
	}
}
