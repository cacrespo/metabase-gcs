# Data Platforms en Startups: El dilema de construir vs. comprar (y un despliegue de regalo)

Les traigo algunas reflexiones que giran sobre el concepto de "Data Platform", enfocadas puntualmente en empresas que transitan sus primeras etapas de crecimiento y evalúan implementar una arquitectura de datos.

Y dada la indisoluble relación entre "ser y estar", a la cual el amigazo Cheva me invitó a reflexionar este fin de semana, cerraremos el posteo con un ejemplo concreto de cómo levantar una instancia de Metabase en Google Cloud (GCP) para que puedan empezar a experimentar con la herramienta y comprobar si se ajusta a su necesidad.

## El dilema Build vs. Buy

Al diseñar una plataforma de datos (aunque supongo que aplica a cualquier sistema de software) existe una tensión constante entre desarrollar soluciones *in-house* o pagar por un servicio administrado (SaaS). 
Este debate no es ninguna novedad y se remonta a la época de las cavernas (el clásico dilema *Build vs. Buy*).
Naturalmente, cada opción posee ventajas y desventajas; la decisión final dependerá de múltiples factores, incluyendo el tamaño del equipo, el presupuesto disponible y la complejidad del problema a resolver.

### El consejo de los expertos

En lo que respecta a los datos, estas opciones suelen evaluarse de cara a la madurez de la compañía o emprendimiento. Así, por ejemplo, Joe Reis y Matt Housley, en su libro *Fundamentals of Data Engineering*, sugieren que cuando una empresa da sus primeros pasos: 
> *"Use off-the-shelf, turnkey solutions wherever possible. Build custom solutions and code only where this creates a competitive advantage"* (p. 38).

Más adelante también mencionan: 
> *"Whenever possible, find the immutable technologies along the data engineering lifecycle, and use those as your base. Build transitory tools around the immutables"* (p. 212).

Y concluyen: 
> *"Investing in building and customizing when doing so will provide a competitive advantage for your business. Otherwise, stand on the shoulders of giants and use what’s already available in the market."* (p. 230).

Todo lo anterior nos lleva a pensar que, para una organización en sus primeras etapas de crecimiento, resulta recomendable utilizar soluciones ya existentes y probadas en el mercado en lugar de reinventar la rueda. Lo ideal es ir a lo seguro y enfocarse en el *core* de la iniciativa. Perfecto. Estoy de acuerdo.

## Dos aspectos cruciales para Founders

Y aquí es donde quiero llamar la atención: amiga/o *founder*, startupero, colegas que se conocieron en el posgrado y están arrancando un negocio... Es comprensible que necesiten hacer foco en el producto. Dependiendo del tipo de negocio, "los datos" (y su analítica) pueden ser o no un componente fundamental en esta etapa. Sin embargo, hay dos aspectos cruciales a tener en cuenta:

1. **La portabilidad de tu historia:** Tu producto o servicio evolucionará, cambiará, se transformará, tal vez muera y vuelva a nacer. Es fundamental que, desde la perspectiva de los datos, conserves la flexibilidad para entrar o salir de las herramientas que elijas y logres preservar (o "migrar") la analítica central de tu negocio. Ese historial se convertirá en un activo invaluable.
2. **El cuidado del presupuesto:** Supongo que gastar dinero en herramientas de renombre puede resultar útil en términos de posicionamiento... ¡pero cuidá el mango, amigoide! No deja de ser una apuesta; si gastás menos en infraestructura sobredimensionada, tendrás más margen para invertir en áreas más estratégicas o, simplemente, extender la pista de aterrizaje (*runway*) de tu proyecto.

## La capa de visualización: dónde ahorrar dinero

De modo que, si estás a cargo del problema de los datos (fijate que ni siquiera dije "área") y tenés que definir la arquitectura, seleccionar las herramientas y velar por todo el ciclo de vida de la data, inevitablemente lidiarás con el *trade-off* entre tiempo/esfuerzo vs. dinero. 
El más típico de los dilemas operativos: ¿a qué le dedicarás más tiempo y dónde preferís o necesitás inyectar el dinero?

Mi no tan humilde recomendación es que, si toca priorizar alguna fase del ciclo (generación, transformación, analítica, seguridad, almacenamiento...), la capa de visualización es la que menos esfuerzo financiero debería demandar en esta etapa inicial. 

¿Por qué? Porque en última instancia, la visualización es un medio para un fin y no un fin en sí mismo.
Si este mes logramos mejorar el DAU/MAU en un 13%, da exactamente igual si lo mostrás en una presentación deslumbrante, en una cadena de emails o con un meme del dictador Mbappé en Slack.

Por otro lado, a las herramientas específicas de BI les encanta empujarte al famoso *vendor lock-in* (Tableau, Qlik, PowerBI, etc.). Y si bien es cierto que algunas de ellas son fantásticas, no son la única alternativa; muchas veces podés lograr exactamente lo mismo empleando soluciones más simples y económicas.

## ¿Por qué Metabase?

Y aquí es donde aprovecho para presentarte a mi candidato ideal: **Metabase**.
Se trata de una plataforma de visualización de datos *open source* que permite crear dashboards y reportes de manera ágil e intuitiva. 

¿Qué es lo que más me atrae de esta herramienta?
- **Open Source**: No necesito aclarar por qué. 
- **Flexibilidad dual:** Ofrece una interfaz *point-and-click* súper amigable para usuarios de negocio, pero integra a la perfección la capacidad de escribir sentencias SQL puras al crear gráficos. Si alguien del equipo quiere hacer magia analítica, tiene todo a disposición para brillar. Además, acercar a tu equipo a la fuente de datos en crudo fomenta el crecimiento técnico. Como *bonus track*, los LLMs se llevan espectacularmente bien generando SQL.
- **Conectividad:** Se integra nativamente con múltiples orígenes (PostgreSQL, MySQL, MongoDB, BigQuery, etc.).
- **MCP Integrado:** Resuelve facilísimo la conexión con agentes como Claude Code. Es decir, si querés automatizar y quemar tokens como un loquillo podés hacerlo sin fricción.
- **Notificaciones:** Esto es algo super puntual pero me gusta mucho. Permite configurar alertas a partir de los charts con un par de clics, otorgando capacidad operativa además de la meramente analítica.

¿Qué no me convence tanto?
Si necesitás que los gráficos y dashboards queden versionados como código en un repositorio, estás obligado a pagar la versión Pro. De todos modos, se los perdono; al fin y al cabo, necesitan monetizar el proyecto de alguna forma.

En resumen: es una soberbia pieza de software que encaja a la perfección con las necesidades de una empresa incipiente.

## Arquitectura de Metabase en GCP

Para pasar a la acción, te comparto un paso a paso súper simplificado para desplegar tu propia instancia de Metabase en el ecosistema de Google Cloud usando Terraform.

El diseño arquitectónico es el siguiente:

![Arquitectura de Metabase en GCP](https://raw.githubusercontent.com/cacrespo/metabase-gcs/main/docs/architecture.jpg)

Acá te dejo el enlace al repositorio con todo el código listo para usar: [Repositorio de GitHub](https://github.com/cacrespo/metabase-gcs)

Con esto lo hacés andar en minutos y ya tenés algo tangible para mostrar. Dentro del repositorio también incluí lineamientos generales (la sección *From POC to Production*) por si en el futuro necesitás escalar la infraestructura de forma robusta.

## Conclusión

Cierro retomando el dilema central: ¿desarrollo *in-house* o SaaS de pago? Obviamente, cada caso es un mundo y requiere el análisis correspondiente, dependiendo fuertemente de las capacidades del equipo.
Creo que la clave para afrontarlo es no caer en la tentación de convertir este debate en una dicotomía estricta (blanco o negro).

Hoy más que nunca necesitamos ser creativos en la búsqueda de soluciones (¡y también en la formulación de los problemas!). Además, contamos con el apoyo invaluable de loros inteligentes que no se cansan de programar por nosotros.
En el enfoque que presento aquí, no estamos desplegando clusters en Kubernetes ni arquitecturas súper complejas de mantener.

En términos de costos operativos el impacto es mínimo, resolviendo de forma muy sólida las necesidades primarias de visualización y capacidad analítica.
Entonces, te dejo un equilibrio óptimo entre tiempo invertido y dinero gastado. Llevatelo y mostráselo a quién necesites. Y de paso podés mantener el foco en lo que realmente importa: traccionar el *core* del negocio.

---
*Disclaimer: Este posteo no está patrocinado por Google Cloud, Metabase, Cheva, ni ninguna de las herramientas mencionadas.*

*[Link a la versión en inglés en mi sitio]*
