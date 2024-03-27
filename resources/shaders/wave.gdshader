shader_type canvas_item;

uniform float amplitude : hint_range(0, 5) = 0.2; // Amplitude da ondulação
uniform float frequency : hint_range(0, 10) = 4.0; // Frequência da ondulação
uniform float time_scale : hint_range(0, 10) = 4.0; // Velocidade da ondulação
uniform float intensity : hint_range(1, 10) = 4.0; // Intensidade adicional

void vertex() {
    // Calcula o deslocamento vertical baseado no tempo e na posição x com intensidade adicional
    float offset = sin(TIME * time_scale + VERTEX.x * frequency) * amplitude * intensity;
    
    // Aplica o deslocamento à posição y do vértice
    VERTEX.y += offset;
}
