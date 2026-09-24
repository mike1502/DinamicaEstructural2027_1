# -*- coding: utf-8 -*-
"""
Created on Tue Sep 22 17:34:21 2026

@author: MCarrilloL
"""
#%% GRAFICA DE LA FUNCIÓN ORIGINAL

import numpy as np #importar librerías para generar arreglos numéricos (vectores)
import matplotlib.pyplot as plt #importo librería para graficar
#import math #Importo librerías para operaciones matemáticas

#Genero el vector de tiempo (punto a puntp)
t=np.array([0,1,2,3,4,5,6])  
#Genero el vector de amplitudes e inicio y fin de cada triángulo
A=np.array([0, 4, 0, -2, 0, 8,0]) 

plt.figure(figsize=(10,4))
plt.plot(t,A, linewidth=2)

plt.axhline(0,linewidth=0.1)
plt.title("Función original")

plt.xlabel("Tiempo (s)")
plt.ylabel("Amplitud")


# plt.annotate(
#     'A = 4',
#     xy=(1, 4),
#     xytext=(1, 4.5),
#     ha='center',
#     fontsize=11
# )

# plt.annotate(
#     'A = -2',
#     xy=(3, -2),
#     xytext=(3, -1.2),
#     ha='center',
#     fontsize=11
# )

# plt.annotate(
#     'A = 8',
#     xy=(5, 8),
#     xytext=(5, 8.5),
#     ha='center',
#     fontsize=11
# )


# plt.text(0.45, 2.3, r'$m = +4$', fontsize=11, rotation=33)
# plt.text(1.45, 2.3, r'$m = -4$', fontsize=11, rotation=-33)

# plt.text(2.45, -0.9, r'$m = -2$', fontsize=11, rotation=-25)
# plt.text(3.45, -0.9, r'$m = +2$', fontsize=11, rotation=25)

# plt.text(4.45, 4.5, r'$m = +8$', fontsize=11, rotation=56)
# plt.text(5.45, 4.5, r'$m = -8$', fontsize=11, rotation=-56)

plt.xlim(0,6)
plt.ylim(-2,8)

plt.grid(True,alpha=0.3)
plt.tight_layout()
plt.show()


#%%
#Serie de Fourier del primer triángulo
#Muestre la solución para N=1,5,20,100 y 500 términos

N=np.array([1,5,20,100,500])
t_serie=np.linspace(0,6,1000)

for i in N:
    u1=np.ones(len(t_serie))*2/3
    for n in range(1,i+1):
        u1+=(24/(n**2*np.pi**2))*(1-np.cos(n*np.pi/3))*(np.cos(n*np.pi/3*(t_serie-1)))
    plt.plot(t_serie,u1, label=f'N={i}')

plt.title('Serie de Fourier del primer triángulo [0,2]')
plt.xlabel('Tiempo [s]')
plt.ylabel('Amplitud')
plt.xlim(0, 2)
plt.ylim(-0.2, 4.5)
plt.grid(True)


xtest=np.array([0, 1, 2])
ytest=np.array([0, 4, 0])

plt.plot(xtest,ytest,'k--', linewidth=2, label="Función original")
plt.legend()
plt.show()


#%%
#Serie de Fourier de los siguientes dos triángulos


