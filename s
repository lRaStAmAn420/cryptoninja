<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fruit Ninja Game</title>
    <style>
        body { margin: 0; overflow: hidden; }
        canvas { display: block; background: #f0f0f0; }
    </style>
</head>
<body>
    <canvas id="gameCanvas"></canvas>
    <script>
        const canvas = document.getElementById('gameCanvas');
        const ctx = canvas.getContext('2d');
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        class Fruit {
            constructor(x, y, radius, speed) {
                this.x = x;
                this.y = y;
                this.radius = radius;
                this.speed = speed;
                this.cut = false;
            }

            draw() {
                ctx.beginPath();
                ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
                ctx.fillStyle = this.cut ? 'gray' : 'red';
                ctx.fill();
                ctx.closePath();
            }

            update() {
                this.y += this.speed;
                if (this.y - this.radius > canvas.height) {
                    this.reset();
                }
            }

            reset() {
                this.x = Math.random() * canvas.width;
                this.y = -this.radius;
                this.speed = Math.random() * 5 + 2;
                this.cut = false;
            }

            checkCut(mouseX, mouseY) {
                const dist = Math.hypot(this.x - mouseX, this.y - mouseY);
                if (dist < this.radius) {
                    this.cut = true;
                    return true;
                }
                return false;
            }
        }

        const fruits = [];
        for (let i = 0; i < 5; i++) {
            const radius = 30;
            const x = Math.random() * canvas.width;
            const y = -radius;
            const speed = Math.random() * 5 + 2;
            fruits.push(new Fruit(x, y, radius, speed));
        }

        let score = 0;

        function gameLoop() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            fruits.forEach(fruit => {
                fruit.update();
                fruit.draw();
            });

            ctx.fillStyle = 'black';
            ctx.font = '24px Arial';
            ctx.fillText('Score: ' + score, 10, 30);

            requestAnimationFrame(gameLoop);
        }

        canvas.addEventListener('mousedown', (e) => {
            const rect = canvas.getBoundingClientRect();
            const mouseX = e.clientX - rect.left;
            const mouseY = e.clientY - rect.top;

            fruits.forEach(fruit => {
                if (fruit.checkCut(mouseX, mouseY)) {
                    score += 1;
                }
            });
        });

        gameLoop();
    </script>
</body>
</html>
