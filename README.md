# Dinámica Molecular
Modelo de dinámica molecular mediante potencial de Lennard-Jones con termostato de Langevin implementado en Fortran 90 como parte del curso Introducción a la Simulación computacional.
www.tandar.cnea.gov.ar/~pastorin/cursos/intro_sims/

#### Autores 
  - Augusto Román [augustojre](https://github.com/augustojre)
  - Simón Saint-André [sstandre](https://github.com/sstandre)


## Cómo correr una simulación

- Editar las variables de control en `control.h`. Si se define `GDR`, el programa calcula la función de distribución radial, pero es un poco más lento.
- Compilar el programa de Fortran con `make`.
- Editar el archivo `input.dat`. Cada línea corresponde a una de las variables de ingreso. El nombre o descripción de las mismas está separada de los valores por espacios. Si la variable `verbose` es `true`, el programa imprime en pantalla los valores de energía durante la ejecución.
- Correr el ejecutable resultante: `./dinamica`
- Si existe un archivo `configuracion.dat`, el programa lo toma como configuración inicial para la simulación. Debe contener N filas con 6 valores cada una, correspondientes a las posiciones y velocidades iniciales de las partículas. Al finalizar la simulación, el programa sobreescribe `configuracion.dat` con la última configuración simulada. Precaución: al cambiar de tamaño de la caja o el número de partículas, los archivos `configuracion.dat` no funcionarán para la nueva simulación.


### Archivos de salida

- `output.dat`: 4 columnas y (nsteps / nwrite) filas. Contiene valores de energía cinética, potencial y total, y presión sampleados de la secuencia de pasos de simulación.
- `movie.vtf`: Archivo para generar animaciones de la dinámica de partículas con `VMD`.
- `configuracion.dat`: Última configuración obtenida. Sobreescribe a la configuración de entrada.
- `correlacion.dat`: 2 columnas y L*30 filas. Sólo se genera si está definida `GDR` al momento de compilar. Contiene la función de distribuición radial. La primer columna corresponde al radio, y la segunda a g(r).
- `seed.dat`: Archivo utilizado por `ziggurat` para obtener números aleatorios. Se usa tanto como entrada como salida.

## Cómo hacer un barrido en temperaturas y/o densidades

- Editar en `send_jobs.py` los valores de entrada y el ejecutable a usar. `temperaturas` y `densidades` deben ser listas de valores.
- Ejecutar `python3 send_jobs.py NJOBS` donde NJOBS es el número de corridas que hace en cada temperatura.

Las distintas simulaciones se organizan en el directorio `data/`. Por ejemplo, de la siguiente forma:
```

data/
├── 0.001_dens/
│   ├── 0.90_temp/
│   │   ├── 01_JOB/
│   │   │   ├── configuracion.dat
│   │   │   ├── input.dat
│   │   │   ├── movie.vtf
│   │   │   └── output.dat
│   │   ├── 02_JOB/
│   │   │   ...
│   │   └── 06_JOB/
│   │
│   ├── 1.10_temp/
│   │   ...
│   └── 2.00_temp/
│
├── 0.010_dens/
│   ...
└── 1.000_dens/
```

Toda la información contenida en los distintos `output.dat` se puede recopilar en un solo archivo mediante:
`python3 recopilar_data.py`
Esto crea (o sobreescribe) el archivo `alldata.dat`, con el cual se pueden analizar los resultados obtenidos.

## Análisis de datos en Jupyter

El notebook `analisis.ipynb` contiene los cálculos y las figuras realizadas con la información de `alldata.dat`. Al ejecutarlo se llama a `recopilar_data.py` para asegurarse de tener los datos actualizados.

Para correr este notebook tenemos que usar Jupyter, que no está por defecto en Ubunutu. Puede ser instalado en un entorno virtual:

 - `sudo apt install python3-venv`
 - `python3 -m venv .venv`
 Con esto tenemos creado el entorno virtual, para usarlo lo activamos con:
 - `source .venv/bin/activate`
 Ahora podemos instalar Jupyter y otros paquetes mediante `pip`:
 - `pip3 install -r requirements.txt`