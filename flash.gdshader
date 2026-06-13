shader_type canvas_item;

uniform bool flash = false;

void fragment() {
	  vec4 col = texture(TEXTURE, UV);
	  if (flash && col.a > 0.0) {
			  COLOR = vec4(1.0, 1.0, 1.0, col.a);
	  } else {
			  COLOR = col;
	  }
}
