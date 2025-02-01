# Usar la imagen de Java oficial
FROM openjdk:17-jdk-slim

# Crear un directorio para la aplicación
WORKDIR /app

# Copiar el archivo JAR generado al contenedor
COPY target/java-docker-app-1.0-SNAPSHOT.jar app.jar

# Exponer el puerto de la aplicación
EXPOSE 9191

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
