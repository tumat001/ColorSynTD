shader_type canvas_item;

uniform bool upper_is_filled_instead = false;

void fragment() {
	ivec2 size = textureSize(TEXTURE, 0);
	float size_ratio = (float(size.x) / float(size.y) + 0.5) / 2.0;
	float uv_ratio = UV.x / UV.y;
	
	if (size_ratio > uv_ratio && upper_is_filled_instead){
		COLOR.a = 0.0;
	} else if (size_ratio < uv_ratio && !upper_is_filled_instead) {
		COLOR.a = 0.0;
	}
}
