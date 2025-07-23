# Base OS 
FROM alpine:latest

# Install Java 17, unzip, curl, and tzdata
RUN apk update && apk --no-cache add openjdk21 unzip curl tzdata

# Set timezone via ENV (optional, redundant with tzdata above)
ENV TZ=Australia/Melbourne

# Create target directory
RUN mkdir -p /var/opt/CrushFTP10

# COPY downloaded ZIP from host filesystem (downloaded by GitHub Actions)
COPY CrushFTP10.zip /tmp/CrushFTP10.zip

RUN unzip /tmp/CrushFTP10.zip -d /var/opt/ && rm -f /tmp/CrushFTP10.zip

# Set permissions
RUN chown -Rf root:root /var/opt/CrushFTP10

# Set working directory
WORKDIR /var/opt/CrushFTP10

# Default run command
CMD ["java", "-Xms512m", "-Xmx2048m", "-jar", "/var/opt/CrushFTP10/CrushFTP.jar", "-dmz", "9000"]
