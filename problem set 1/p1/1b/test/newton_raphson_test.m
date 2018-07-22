%[theta, x, y] = init_values();
[theta, x, y] = titanic_data();

[th, ll] = newton_raphson(theta, x, y);
