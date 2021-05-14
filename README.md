# Proyecto final para fullstack-g39
Este es el proyecto final de la carrera "desarrollo fullstack", generación 39, de la Academia Desafío Latam.

El objetivo de este proyecto es crear una plataforma para planificar, gestionar, documentar y compartir viajes.

## Links
### Trello
https://trello.com/b/FINbe47p/time-travelling-turtle

### DB design
https://dbdiagram.io/d/60722617ecb54e10c33faa66

### Live version
http://www.trvlr.cl

## Versiones
ruby: 3.0.1 \
rails: 6.1.3.1

## Mockups
### Visitantes
![mockup: visitors](mockups/screenshots/visitors.png)

### Activity stream
![mockup: activity stream](mockups/screenshots/activity_stream.png)

### My trips - overview
![mockup: my trips - overview](mockups/screenshots/my_trips_overview.png)

### My trips - segments
![mockup: my trips - segments](mockups/screenshots/my_trips_segments.png)

### My trips - blog
![mockup: my trips - blog](mockups/screenshots/my_trips_blog.png)

### My trips - media
![mockup: my trips - media](mockups/screenshots/my_trips_media.png)

### Summary page
![mockup: overview](mockups/screenshots/summary.png)

## ERD
![ERD model](doc/erd.png)
Nota: también está disponible cómo PDF en docs/erd.pdf \
Se lo generó usando la gema `rails-erd` con el comando
```bash
rails erd indirect=true attributes=foreign_keys,primary_keys,content filetype=pdf filename=doc/erd
```
