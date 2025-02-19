int collArrayCounter;
color[] bluePalette = {
  color(25, 165, 190), // Синьо
  color(95, 170, 200), // Светло синьо
  color(120, 190, 210), // Тюркоазено
  color(170, 210, 230), // Синьо-сиво
  color(205, 225, 245), // По-светъл нюанс синьо
  color(220, 240, 250)  // Бяло-синьо
};

color[] pinkPalette = {
  color(255, 182, 193), // Светло розово
  color(255, 105, 180), // Цикламено
  color(255, 160, 210), // Розово
  color(255, 85, 145),  // Тъмно розово
  color(255, 50, 120),  // Ярко розово
  color(255, 200, 230)  // Бяло-розово
};

color[] colArray; // Текущата палитра
int shapeTypeSelector; // 0 = circle, 1 = square, 2 = triangle, 3 = star
boolean isBluePalette;

void setup(){
   size(900, 900);
  surface.setLocation(987,70);
  //fullScreen();
  noStroke();
  mouseX = 10;
  frameRate(10);

  // Избиране на случайна палитра
  isBluePalette = random(1) < 0.5;
  colArray = isBluePalette ? bluePalette : pinkPalette; // Задаваме текущата палитра

  // Избиране на случайна форма
  shapeTypeSelector = int(random(4));
}

void draw(){
  background(#282828);

  translate(width / 2, height / 2);  // Центрираме на екрана
  float rStep = 30;
  float rMax = 1920;
  float rMin = mouseX;

  for (float r = rMin; r < rMax; r += rStep) {
    float c = 2 + PI * r;
    float cSegment = map(r, 0, rMax, rStep * 3 / 4, rStep / 2);
    float aSegment = floor(c / cSegment);
    float ellipseSize = map(r, 0, rMax, rStep * 3 / 4 * 1, rStep / 4);

    for (float a = 0; a < 360; a += 360 / aSegment) {
      collArrayCounter++;
      if (collArrayCounter > colArray.length - 1) collArrayCounter = 0;
      fill(colArray[collArrayCounter]);

      pushMatrix();
      rotate(radians(a));

      // В зависимост от shapeTypeSelector рисуваме само една форма
      switch(shapeTypeSelector) {
        case 0:  // Кръгове
          ellipse(r, 0, ellipseSize, ellipseSize); 
          break;
        case 1:  // Квадрати
          rect(r - ellipseSize / 2, -ellipseSize / 2, ellipseSize, ellipseSize); 
          break;
        case 2:  // Триъгълници
          float triSize = ellipseSize;
          triangle(r, -triSize / 2, r + triSize / 2, -triSize / 2, r, triSize / 2); 
          break;
        case 3:  // Звезда
          drawStar(r, 0, ellipseSize * 0.5, ellipseSize, 5); // 5 крака на звездата
          break;
      }

      popMatrix();
    }
    //saveFrame("output-####.png");
  }
  saveFrame("output-####.png");
}

// Функция за рисуване на звезда
void drawStar(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;
  beginShape();
  for (float a = -PI/10; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a + halfAngle) * radius1;
    sy = y + sin(a + halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
