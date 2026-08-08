*(Done.)*
</think>

Sitio web de investigación de Zhenke Wu: [haz clic para ver](http://zhenkewu.com)

# Notas

* [2025/06/11] 
  - La fuente de la barra de búsqueda se puede cambiar en `_includes/search-form-global.html` o `_includes/search-form.html`
  - La fuente de las barras de navegación superior e inferior se controla en `assets/themes/lab/css/style.scss`. Comprueba: `body{}` al final. Actualmente es `Roboto`. Esta no es una solución limpia.
  - La fuente en todos los demás lugares sigue el orden especificado en `$font-stack:    jinkaiFont, "museo-sans", Optima, sans-serif;` en el archivo `assets/themes/lab/css/style.scss`
  - Las fuentes se almacenan en la carpeta: `assets/themes/lab/fonts`. El archivo `assets/themes/lab/styles/font.css` hace referencia a estos archivos. Esta estructura y `jinkaiFont` siguen la de [manateelazycat.github.io
](https://github.com/manateelazycat/manateelazycat.github.io).

* [2025/05/28] Se agregaron IpMeta y Google Tag Manager.

* [2024/10/26] Se agregaron artículos por tema; utiliza `pages_list_paper` y `tags_list_paper` en la carpeta `JB`. Estos buscarán `tags` en los artículos.
  * al especificar las etiquetas, usa minúsculas; es complicado implementar el ordenamiento de forma insensible a mayúsculas/minúsculas (si lo sabes, ¡informmelo!)
  * una vez que hagas clic en `Topic` en la pestaña de `papers`, deberías poder ver las palabras clave con sus conteos en la parte superior y la lista de artículos por palabras clave en la parte inferior.

* [2023/12/16] Se agregó la función de búsqueda; una referencia útil está [aquí](https://github.com/christian-fei/Simple-Jekyll-Search) y [aquí](https://kevquirk.com/how-to-add-search-jekyll). Es necesario realizar lo siguiente:
    - Coloca el archivo JavaScript en `./js/search-scripts.js`, el cual se basa en el[`SimpleJekyllSearch`](https://github.com/christian-fei/Simple-Jekyll-Search) y especifica opciones para realizar operaciones adicionales en los resultados de búsqueda, como el ordenamiento.
    - Coloca el archivo JavaScript en `./js/search-result.js`, el cual define una función `simple_search()` que llama a la función `SimpleJekyllSearch()` anterior, con especificaciones adicionales sobre cómo serían las entradas y salidas de la búsqueda. Las entradas y resultados se procesarán mediante `search-form-global.html` o `search-form.html` para ser incluidos en una página y así renderizar la barra de búsqueda y mostrar los resultados.
    - Coloca `search-form-global.html` en la carpeta `_includes` y coloca lo siguiente donde quieras que aparezca tu barra de búsqueda: 
        - `<div> {% include search-form-global.html %} </div>`
      - Lo anterior permite buscar globalmente (basado en `search-global.json` que extrae datos de las entradas de todo el sitio web y genera un archivo `.json` real con el mismo nombre en la carpeta de sitio estático generada llamada `_site`); si solo quieres buscar un subconjunto de entradas, por ejemplo, artículos, puedes modificar el archivo JSON a tu gusto, por ejemplo, `search.json` en el directorio principal es un archivo JSON separado para extraer datos de las entradas de la categoría `papers` únicamente. Siéntete libre de modificar los comandos de Liquid o incluir información adicional para extraer. Para incluir la barra de búsqueda solo para el subconjunto de entradas, es necesario usar una declaración HTML diferente para insertar la barra de búsqueda donde desees. Por ejemplo, incluí solo la barra de búsqueda de artículos en las páginas de artículos:
        - `<div> {% include search-form-global.html %} </div>` 
    - La configuración opcional: actualmente uso el argumento de la función de ordenamiento `sortMiddleware` en `search-form.html` y `search-form-global.html`, donde el primero es solo para artículos (ordenar por año), y el segundo para todo el sitio web (ordenar por categoría y año). `especificarás` la función `sort_curr` para definir tu mecanismo de ordenamiento deseado en JavaScript.


* Después de clonar el repositorio en tu carpeta local, `es necesario` instalar Jekyll para compilar y probar tu sitio modificado. 

* fuentes
	- Utiliza [Typekit](https://typekit.com/) para publicar las fuentes que te gusten; `registra` una cuenta de Adobe;
	- Modifica `$font-stack` en `/assets/themes/lab/css/style.scss` para incluir tus fuentes. Se utilizan nombres de fuentes adicionales como respaldo.
* entradas
    - Para agregar una entrada, por ejemplo, un artículo nuevo, sigue el formato de los archivos `.md` existentes
    - Comenta `</div>` si hay un múltiplo de tres artículos en cada subsección; de lo contrario, habrá errores de sangría. 
* seguimiento
	- Para vincular tu sitio a los servicios de análisis de Google (Google Analytics 4), modifica el `tracking_id` en el archivo `_config.yml` del directorio raíz para que apunte a tu sitio web. 
	- Reemplaza el `tracking_id` con tu propio ID en el siguiente bloque de código en `_config.yml`
    
    ```
    analytics :
        provider : google
   		google : 
      	  tracking_id : G-XXXXXXX
    ```
* feed de Twitter:
    - Sigue las instrucciones [aquí](https://gist.github.com/abhisheknaik96/26ce79ac7a307eb836dcf02a52f87cf2) y [aquí](https://keitaito.com/blog/2017/01/20/embedding-tweets-in-github-pages.html). La idea básica es usar localmente lo siguiente
    para incrustar un tweet.
    
    ```
    <div class='jekyll-twitter-plugin' align="center">
    {% twitter https://twitter.com/anaik96 maxwidth=500 limit=5 %}
    </div>
    ```

     Ejecuta `bundle exec jekyll server` para generar una subcarpeta `_site/` y luego encuentra el archivo `.html` generado que contiene el bloque de código para incrustar tu tweet. Copia el bloque de código, por ejemplo:
    
    ```html
    <blockquote class="twitter-tweet" data-width="500"><p lang="en" dir="ltr">For our first ever <a href="https://twitter.com/hashtag/StudentSpotlight?src=hash&amp;ref_src=twsrc%5Etfw">#StudentSpotlight</a>, we&#39;re excited to feature Tim NeCamp who graduated in May and is an official <a href="https://twitter.com/hashtag/alum?src=hash&amp;ref_src=twsrc%5Etfw">#alum</a>! Tim’s interests lie in the areas of experimental design, causal inference, intensive longitudinal data, and....<br>Read More: <a href="https://t.co/NYfWov7wDk">https://t.co/NYfWov7wDk</a> <a href="https://t.co/S6D3sM2vo7">pic.twitter.com/S6D3sM2vo7</a></p>&mdash; Statistics (@UMichStatistics) <a href="https://twitter.com/UMichStatistics/status/1144334755506401283?ref_src=twsrc%5Etfw">June 27, 2019</a></blockquote>
    <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    ```

    y reemplaza el bloque `<div>` anterior.

* MathJax (también consulta [aquí](http://www.idryman.org/blog/2012/03/10/writing-math-equations-on-octopress/) )
	- Para mostrar correctamente las expresiones matemáticas renderizadas por MathJax, 
		+ Añade `kramdown` en la línea de `markdown:` en `_config.yml`; esto evita que el lenguaje Markdown interfiera con los comandos de LaTeX; también añade `gem 'kramdown'` en `Gemfile`;
	- Añade el siguiente bloque de código a `/_includes/themes/lab/default.html`, antes de `</head>`
	
>
    <!-- Math via MathJax -->
    <script type="text/x-mathjax-config">
        MathJax.Hub.Config({
            extensions: ["tex2jax.js"],
            jax: ["input/TeX", "output/HTML-CSS"],
            tex2jax: {
                inlineMath: [ ['$','$'], ["\\(","\\)"] ],
                displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
                processEscapes: true
            },
        "HTML-CSS": { availableFonts: ["TeX"] }
        });
    </script>
    <script src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>


* proyectos
    - Para cada repositorio (en la carpeta `/_data`), la `url` no debe terminar con `/`. Por ejemplo, usa `url: /projects/baker`, en lugar de `url: /projects/baker/`
* navegación:
    - Por ejemplo, la pestaña "papers" se especifica en la carpeta "papers/". En la parte superior, `title` es para el nombre de la pestaña; `group` puede ser `navigation` o `subnavigation` dependiendo de si quieres mostrar esta pestaña o colapsarla en la pestaña "More"; `navorder` especifica el orden en la barra de navegación (1 para la primera pestaña).
* equipo
    - para las fotos, establece aproximadamente 200px de ancho y 300px de alto, con una resolución de 144. El requisito de ancho ayuda a que la foto se muestre correctamente en la página individual.

 ## Otras consideraciones técnicas
 * `categories`
    - hace referencia a las subcarpetas en el directorio principal sin un guion bajo `_`;
    - se utiliza para hacer referencia a ubicaciones específicas en el sitio web (mi suposición actual es que la definición de `categories` viene incluida con el motor de Jekyll, por lo que no es necesario que el `usuario` defina las categorías)
* hojas de estilo
    - Hay dos que importan: `/assets/themes/lab/css/style.scss` y `/assets/themes/css/style.scss`; El primero funciona para las entradas, y el segundo para las páginas ANTES de acceder a las entradas. 
    - Esto podría corregirse mejor, pero ahora no tengo tiempo para verificar cómo se utilizan actualmente en las diferentes páginas.
* página del equipo
    - Actualmente, la [página de aterrizaje del Equipo](https://github.com/zhenkewu/zhenkewu.github.io/blob/master/team/index.md) muestra fotos de perfil circulares en cuatro columnas (sin apilarse si la pantalla es más ancha de 576px). La imagen circular se logra mediante `border-radius: 50%` - se puede eliminar esto para volver a rectangular.
    - `consulta` [aquí](https://getbootstrap.com/docs/4.0/layout/grid/) y [aquí](https://www.w3schools.com/bootstrap/bootstrap_grid_examples.asp) para realizar cambios en la página de aterrizaje del Equipo bas, en el sistema de cuadrícula de Bootstrap.
