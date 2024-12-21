# Use the official Nextcloud image as the base
FROM nextcloud:latest

# Set environment variables for Nextcloud admin
ENV NEXTCLOUD_ADMIN_USER=admin
ENV NEXTCLOUD_ADMIN_PASSWORD=admin

# Install git and curl
RUN apt-get update && apt-get install -y git curl

# Expose the port that Nextcloud will run on
EXPOSE 9091

# Command to start Nextcloud
CMD ["apache2-foreground"]
