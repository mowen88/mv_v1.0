shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float boxes_vertical = 9.0; 
uniform vec4 box_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    // Calculate the aspect ratio dynamically based on the current resolution
    float aspect_ratio = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
    
    // Derive the horizontal grid count so the boxes stay perfectly square
    vec2 grid_size = vec2(boxes_vertical * aspect_ratio, boxes_vertical);
    
    // Break the screen space down into repeated local grid cells using our balanced grid
    vec2 cell_uv = fract(UV * grid_size);
    
    // Calculate how far the current pixel is from the absolute center of its cell
    vec2 center_dist = abs(cell_uv - vec2(0.5));
    
    // Find the furthest edge distance along either axis
    float max_dist = max(center_dist.x, center_dist.y);
    
    // Render the pixel if it falls inside the growing square boundary
    if (max_dist < progress * 0.5) {
        COLOR = box_color;
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}