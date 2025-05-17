// Declaración de variables globales
int pantallaActual = 0;
PImage imagenPantalla1;
PImage imagenPantalla2;
PImage imagenPantalla3;
PFont fuenteTexto;
int tiempoInicioPantalla;
int duracionPantalla = 10000;
String resumenSW1; // Declaración global
String resumenSW2; // Declaración global
String resumenSW3; // Declaración global
float textoPantalla1X;
float textoPantalla2Y;
float textoPantalla3X;
int alfaImagen1 = 0;
float escalaImagen2 = 0.5;
float textoImagen3X;

// Variables para el botón de reinicio
boolean mostrarBotonReinicio = false;
float botonX;
float botonY;
float botonAncho = 150;
float botonAlto = 50;
String textoBoton = "Reiniciar";
boolean botonSobre = false; // Para detectar si el mouse está sobre el botón


void setup() {
  size(640, 480);
  tiempoInicioPantalla = millis();
  imagenPantalla1 = loadImage("SW1.jpg");
  imagenPantalla2 = loadImage("SW2.jpg");
  imagenPantalla3 = loadImage("SW4.jpg");
  fuenteTexto = createFont("Arial", 12);
  textFont(fuenteTexto);
  resumenSW1 = "En una galaxia lejana, una reina pacífica enfrenta la amenaza de una invasión por una malvada federación. Dos caballeros Jedi, protectores de la paz con poderes especiales, intentan ayudarla en medio de este conflicto inicial.";
  resumenSW2 = "Durante su misión, los Jedi descubren a un joven esclavo con habilidades asombrosas y una conexión misteriosa con \"La Fuerza\", una energía especial. Su aparición parece crucial en el despertar de una fuerza oscura que se cierne sobre la galaxia.";
  resumenSW3 = "La película marca el comienzo de una lucha épica entre el bien y el mal, presentando a nuevos héroes y villanos. Es una aventura llena de magia (a través de La Fuerza) y los primeros pasos hacia un conflicto que definirá el destino de la galaxia.";
  textoPantalla1X = -width;
  textoPantalla2Y = height + 50;
  textoPantalla3X = width + 420;
  textoImagen3X = -width;
}


void draw() {
  background(200);

  if (pantallaActual == 0) {
    tint(255, alfaImagen1);
    image(imagenPantalla1, 0, 0, width, height);
    fill(0); // Color del texto negro
    textAlign(CENTER, CENTER);
    textSize(26);
    text(resumenSW1, textoPantalla1X, 100, 422, 302);
    fill(255,255,0); // Color del texto amarillo
    textAlign(CENTER, CENTER);
    textSize(26);
    text(resumenSW1, textoPantalla1X, 100, 421, 301);
    textoPantalla1X = min(textoPantalla1X + 5, 100);
    if (alfaImagen1 < 255) {
      alfaImagen1 += 10; // Ajusta la velocidad del degradado
    }

  } else if (pantallaActual == 1) {
    float anchoImagen2 = width * escalaImagen2;
    float altoImagen2 = height * escalaImagen2;
    float posXImagen2 = (width - anchoImagen2) / 2; // Centrar horizontalmente
    float posYImagen2 = (height - altoImagen2) / 2; // Centrar verticalmente
    image(imagenPantalla2, posXImagen2, posYImagen2, anchoImagen2, altoImagen2);
    fill(0); // Color del texto negro
    textAlign(CENTER, CENTER);
    textSize(26);
    text(resumenSW2, 100, textoPantalla2Y, 422, 302);
    fill(255,255,0);
    textAlign(CENTER, CENTER);
    textSize(26);
    text(resumenSW2, 100, textoPantalla2Y, 420, 300);
    textoPantalla2Y = max(textoPantalla2Y - 5, 100);
    if (escalaImagen2 < 1.0) {
      escalaImagen2 += 0.02; // Velocidad del zoom
    } else {
      escalaImagen2 = 1.0;
    }

  } else if (pantallaActual == 2) {
    image(imagenPantalla3, textoImagen3X, 0, width, height); // La imagen se desliza desde la izquierda

    fill(0);
    textAlign(LEFT, CENTER); // Alinea el texto a la izquierda
    textSize(26);

    // Posición X inicial del texto (fuera de la derecha)
    float textoInicioPantalla3X = width + 50;
    // Posición X donde queremos que el texto SE DETENGA
    float textoPantalla3FinalX = width - 470; // Dejé un margen de 50 desde la izquierda (width - ancho del texto - margen)

    // Calculo la posición X del texto basada en el progreso de la imagen
    float progresoAnimacionImagen3 = map(textoImagen3X, -width, 0, 0, 1);
    float textoPantalla3ActualX = lerp(textoInicioPantalla3X, textoPantalla3FinalX, progresoAnimacionImagen3);

    text(resumenSW3, textoPantalla3ActualX, 100, 420, 300);

    textoImagen3X = min(textoImagen3X + 5, 0); // Anima la imagen hacia la derecha
  }

    // Control de la transición automática y mostrar botón de reinicio
  if (pantallaActual < 3) { // Condición para incluir el estado final
    if (millis() - tiempoInicioPantalla > duracionPantalla) {
      if (pantallaActual < 2) {
        pantallaActual++;
        tiempoInicioPantalla = millis();
        // Reiniciar variables de animación para la siguiente pantalla
        if (pantallaActual == 1) {
          textoPantalla2Y = height + 350;
          escalaImagen2 = 0.5;
        } else if (pantallaActual == 2) {
          textoImagen3X = -width;
        }
      } else if (pantallaActual == 2) {
        mostrarBotonReinicio = true; // Mostrar el botón después de la última pantalla
      }
      // Evitar que pantallaActual siga incrementándose
      if (pantallaActual > 2) {
        pantallaActual = 2;
      }
    }
  }

  // Dibujar el botón de reinicio si mostrarBotonReinicio es true
  if (mostrarBotonReinicio) {
    botonX = width / 2 - botonAncho / 2;
    botonY = height - botonAlto - 50; // Posición del botón en la parte de abajo al centro

    // Detectar si el mouse está sobre el botón
    botonSobre = mouseX > botonX && mouseX < botonX + botonAncho && mouseY > botonY && mouseY < botonY + botonAlto;

    // Dibujar el fondo del botón
    if (botonSobre) {
      fill(150); // Color más claro al pasar el mouse
    } else {
      fill(100);
    }
    rect(botonX, botonY, botonAncho, botonAlto, 10); // Rectángulo con esquinas redondeadas

    // Dibujar el texto del botón
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(textoBoton, botonX + botonAncho / 2, botonY + botonAlto / 2);
  }
}

void mousePressed() {
  if (mostrarBotonReinicio && botonSobre) {
    pantallaActual = 0;
    mostrarBotonReinicio = false;
    tiempoInicioPantalla = millis();
    // Reiniciar las variables de animación a sus valores iniciales
    textoPantalla1X = -width;
    textoPantalla2Y = height + 50;
    textoImagen3X = -width;
    escalaImagen2 = 0.5;
    alfaImagen1 = 0;
  }
}
