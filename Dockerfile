# Usar la imagen de Java oficial
FROM openjdk:17-jdk-slim

# Crear un directorio para la aplicación
WORKDIR /app

# Copiar el archivo JAR generado al contenedor
COPY target/*.jar app.jar

# Exponer el puerto de la aplicación
EXPOSE 9191

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
