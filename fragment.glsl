// https://www.youtube.com/watch?v=f4s1h2YETNY

precision mediump float;

uniform float u_time;
uniform vec2 u_resolution;

vec3 palette(float t, vec3 a, vec3 b, vec3 c, vec3 d) {
    return a + b * cos(6.28318 * (c * t + d));
}

vec3 customPalette(float t) {
    return palette(
        t, 
        vec3(0.5, 0.5, 0.5),
        vec3(0.5, 0.5, 0.5),
        vec3(1.0, 1.0, 1.0),
        vec3(0.263, 0.416, 0.557)
    );
}

void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution.xy) / u_resolution.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);

    for (float i = 0.0; i < 4.0; i++) {
        uv = fract(uv * 1.5) - 0.5;

        float d = length(uv) * exp(-length(uv0));
        float gap = 9.0;

        vec3 color = customPalette(length(uv0) + i * 0.4 + u_time * 0.4);

        d = sin(d * gap + u_time) / gap;
        d = abs(d);

        d = pow(0.01 / d, 1.2);

        finalColor += color * d;
    }

    gl_FragColor = vec4(finalColor, 1.0);
}
