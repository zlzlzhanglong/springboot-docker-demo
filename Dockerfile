# 使用Maven来构建项目
FROM maven:3.8.4-openjdk-11-slim AS build

# 复制项目的pom.xml文件并下载依赖
COPY pom.xml .
COPY src ./src

# 打包Spring Boot项目
RUN mvn clean package -DskipTests

# 使用OpenJDK 11作为基础镜像
FROM openjdk:11-jre-slim

# 设置工作目录
WORKDIR /app

# 将编译后的JAR文件复制到镜像中
COPY target/demo.jar app.jar

# 暴露应用程序运行的端口
EXPOSE 8080

# 定义容器启动时执行的命令
CMD ["java", "-jar", "app.jar"]
