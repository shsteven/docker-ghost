# docker-ghost
Ghost docker image. Bring your own /content folder.

# usage

Mount config.js and content/ from the host machine:

```
VOLUME ./config.js
VOLUME ./content
```
