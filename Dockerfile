# Этап сборки
FROM gradle:7.6.1-jdk23 as builder

WORKDIR /app-build

# Копируем файлы Gradle и сборки
COPY . .

# Сборка проекта
RUN gradle build -x test

# Этап выполнения
FROM eclipse-temurin:23-jre-alpine

WORKDIR /app-build

# Копируем собранный JAR-файл из этапа сборки
COPY --from=builder /app-build/build/libs/*.jar app.jar

# Открываем порт приложения
EXPOSE 8080

# Команда для запуска приложения
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
