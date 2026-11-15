#version 330
in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
vec4 default_post_processing(vec4 c);

const float r = 10.0;

vec4 window_shader() {
    vec2 size = textureSize(tex, 0);
    vec4 c = default_post_processing(texture2D(tex, texcoord / size, 0));
    vec2 p = vec2(min(texcoord.x, size.x - texcoord.x), texcoord.y);
    if (p.x < r && p.y < r) {
        c *= clamp(r - distance(p, vec2(r)) + 0.5, 0.0, 1.0);
    }
    return c * opacity;
}
