# -*- coding: utf-8 -*-
"""
Created on Wed Oct 21 14:49:58 2026

@author: MCarrilloL
"""

import numpy as np
import matplotlib.pyplot as plt

# ==========================================
# 1. Parámetros del sistema
# ==========================================
m = 1.0       # kg
k = 25.0      # N/m
l0 = 1.0      # m

Omega = np.sqrt(k / m)

r0 = l0       # Posición radial inicial (m)
v0 = 0.5      # Velocidad radial inicial (m/s)

t = np.linspace(0, 50, 5001)

# Tres velocidades angulares del disco
omegas = [0.9 * Omega, Omega, 1.1 * Omega]

print(f"Frecuencia natural Omega = {Omega:.2f} rad/s")

# ==========================================
# 2. Solución analítica de r(t)
# ==========================================
def radio(t, omega):
    delta = Omega**2 - omega**2

    if delta > 1e-10:
        # Caso 1: Omega^2 > omega^2
        alpha = np.sqrt(delta)
        req = Omega**2 * l0 / delta

        A = r0 - req
        B = v0 / alpha

        r = (req
             + A * np.cos(alpha * t)
             + B * np.sin(alpha * t))

    elif delta < -1e-10:
        # Caso 3: Omega^2 < omega^2
        beta = np.sqrt(-delta)
        rp = -Omega**2 * l0 / beta**2

        A = r0 - rp
        B = v0 / beta

        r = (A * np.cosh(beta * t)
             + B * np.sinh(beta * t)
             + rp)

    else:
        # Caso 2: Omega^2 = omega^2
        r = r0 + v0 * t + 0.5 * Omega**2 * l0 * t**2

    return r


# ==========================================
# 3. Desplazamiento radial r(t)
# ==========================================
fig, axes = plt.subplots(3, 1, figsize=(10, 10))

for ax, omega in zip(axes, omegas):
    r = radio(t, omega)

    ax.plot(t, r, linewidth=1.5)
    ax.set_title(f"Desplazamiento radial: omega = {omega:.1f} rad/s")
    ax.set_xlabel("Tiempo t (s)")
    ax.set_ylabel("r(t) (m)")
    ax.grid(True)

plt.tight_layout()
plt.show()


# ==========================================
# 4. Coordenadas cartesianas x(t), y(t)
# ==========================================
for omega in omegas:
    r = radio(t, omega)
    theta = omega * t

    x = r * np.cos(theta)
    y = r * np.sin(theta)

    fig, axes = plt.subplots(2, 1, figsize=(10, 7))

    axes[0].plot(t, x)
    axes[0].set_title(f"x(t), omega = {omega:.1f} rad/s")
    axes[0].set_xlabel("Tiempo t (s)")
    axes[0].set_ylabel("x(t) (m)")
    axes[0].grid(True)

    axes[1].plot(t, y)
    axes[1].set_title(f"y(t), omega = {omega:.1f} rad/s")
    axes[1].set_xlabel("Tiempo t (s)")
    axes[1].set_ylabel("y(t) (m)")
    axes[1].grid(True)

    plt.tight_layout()
    plt.show()


# ==========================================
# 5. Trayectoria en el plano del disco
# ==========================================
for omega in omegas:
    r = radio(t, omega)
    theta = omega * t

    x = r * np.cos(theta)
    y = r * np.sin(theta)

    plt.figure(figsize=(7, 7))
    plt.plot(x, y, linewidth=1.0)
    plt.plot(x[0], y[0], "o", label="Posición inicial")
    plt.xlabel("x (m)")
    plt.ylabel("y (m)")
    plt.title(f"Trayectoria en el plano: omega = {omega:.1f} rad/s")
    plt.axis("equal")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.show()

