//自由制作課題_BK23284.pde
//学生番号:BK23284 名前:前田 大貴

int NN = 100;  // ボールの最大個数
int numBalls = 0;  // 現在のボールの数
int score = 0;  // スコアを管理する変数
int timeLimit = 15;  // 制限時間（秒）
int startTime;  // ゲーム開始時の時間
boolean gameActive = true;  // ゲームがアクティブかどうか
Ball[] balls = new Ball[NN];  // ボールの配列

void setup() {
  size(480, 360);  // ウィンドウサイズ
  noStroke();
  frameRate(30);  // フレームレートを30に設定
  startGame();  // ゲームの初期化
}

void draw() {
  background(204);  // 背景を灰色に設定

  if (gameActive) {
    // 残り時間の計算
    int elapsedTime = (millis() - startTime) / 1000;  // 経過時間（秒）
    int remainingTime = timeLimit - elapsedTime;  // 残り時間

    if (remainingTime <= 0) {
      gameActive = false;  // 制限時間が0になったらゲーム終了
    }

    // スコアと残り時間の表示
    fill(0);
    textSize(20);
    text("Score: " + score, 10, 20);  // スコアを左上に表示
    text("Time: " + remainingTime, 400, 20);  // 残り時間を右上に表示

    // ボールの更新と描画
    for (int i = 0; i < NN; i++) {
      if (balls[i] != null) {  // 存在するボールのみ処理
        balls[i].update();
        balls[i].display();
      }
    }
  } else {
    // ゲーム終了画面
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Game Over", width / 2, height / 2 - 20);  // ゲームオーバー表示
    text("Final Score: " + score, width / 2, height / 2 + 20);  // 最終スコア表示
    textSize(20);
    text("Click to Restart", width / 2, height / 2 + 60);  // 再スタートメッセージ
  }
}

void mousePressed() {
  if (gameActive) {  // ゲーム中のみクリック処理を行う
    // クリック位置に近いボールを削除してスコアを加算
    for (int i = 0; i < NN; i++) {
      if (balls[i] != null && dist(mouseX, mouseY, balls[i].posx, balls[i].posy) < balls[i].radius) {
        balls[i] = null;  // ボールを削除
        score += 10;  // スコアを10加算
        break;  // 1つのボールを消したら終了
      }
    }
  } else {
    startGame();  // ゲーム再スタート
  }
}

// ゲームを初期化する関数
void startGame() {
  score = 0;  // スコアをリセット
  startTime = millis();  // ゲーム開始時刻を記録
  gameActive = true;  // ゲームをアクティブ状態に設定

  // ボールの再初期化
  numBalls = 0;  // 現在のボール数をリセット
  for (int i = 0; i < NN; i++) {
    float x = random(0, width);
    float y = random(0, height);
    float d = random(10, 20);  // 半径
    float sx = random(-5, 5);  // 横方向の速度
    float sy = random(-5, 5);  // 縦方向の速度
    color c = color(random(0, 255), random(0, 255), random(0, 255));  // ランダムな色
    balls[i] = new Ball(d, x, y, sx, sy, c);  // Ballオブジェクトを生成
    numBalls++;
  }
}

class Ball {
  float posx, posy;  // 位置
  float speedx, speedy;  // 速度
  float radius;  // 半径
  color ballColor;  // 色

  // コンストラクタ
  Ball(float r, float x, float y, float sx, float sy, color c) {
    radius = r;
    posx = x;
    posy = y;
    speedx = sx;
    speedy = sy;
    ballColor = c;
  }

  // ボールの位置を更新
  void update() {
    posx += speedx;
    posy += speedy;

    // 壁との衝突判定
    if (posx + radius > width || posx - radius < 0) {
      speedx = -speedx;  // 横方向の速度反転
    }
    if (posy + radius > height || posy - radius < 0) {
      speedy = -speedy;  // 縦方向の速度反転
    }
  }

  // ボールの描画
  void display() {
    fill(ballColor);
    ellipse(posx, posy, radius * 2, radius * 2);  // ボールを描画
  }
}
