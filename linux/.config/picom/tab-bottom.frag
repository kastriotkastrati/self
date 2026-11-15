#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
uniform float dim;
uniform bool invert_color;
uniform float corner_radius;

vec4 window_shader() {
    vec2 size = textureSize(tex, 0);
    vec4 c = texture2D(tex, texcoord / size, 0);
    if (invert_color) {
        c = vec4(c.aaa - c.rgb, c.a);
    }
    c = vec4(c.rgb * (1.0 - dim), c.a) * opacity;
    float r = corner_radius;
    vec2 p = vec2(min(texcoord.x, size.x - texcoord.x), size.y - texcoord.y);
    if (p.x < r && p.y < r) {
        c *= clamp(r - distance(p, vec2(r)) + 0.5, 0.0, 1.0);
    }
    return c;
}
