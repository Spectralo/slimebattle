shader_type canvas_item;

// Original colors to replace
uniform vec3 color1 = vec3(0.086, 0.353, 0.298); // #165a4c
uniform vec3 color2= vec3(0.137, 0.565, 0.388); // #239063
uniform vec3 color3  = vec3(0.118, 0.737, 0.451); // #1ebc73
uniform vec3 color4 = vec3(0.569, 0.859, 0.412); // #91db69

// Replacement colors
uniform vec3 replace1  = vec3(0.431, 0.153, 0.153); // #6e2727
uniform vec3 replace2  = vec3(0.702, 0.220, 0.192); // #b33831
uniform vec3 replace3  = vec3(0.918, 0.310, 0.212); // #ea4f36
uniform vec3 replace4  = vec3(0.961, 0.490, 0.290); // #f57d4a

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Check if the texture color matches one of the target colors (with some tolerance)
    float tolerance = 0.01; // Tolerance for color matching

    if (distance(tex_color.rgb, color1) < tolerance) {
        COLOR = vec4(replace1, tex_color.a);
    } else if (distance(tex_color.rgb, color2) < tolerance) {
        COLOR = vec4(replace2, tex_color.a);
    } else if (distance(tex_color.rgb, color3) < tolerance) {
        COLOR = vec4(replace3, tex_color.a);
    } else if (distance(tex_color.rgb, color4) < tolerance) {
        COLOR = vec4(replace4, tex_color.a);
    } else {
        COLOR = tex_color; // Keep the original color if no match
    }
}