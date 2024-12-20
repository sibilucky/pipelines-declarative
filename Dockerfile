# Use the official Nextcloud image as the base
FROM nextcloud:latest

# Set environment variables if needed
# ENV NEXTCLOUD_ADMIN_USER admin
# ENV NEXTCLOUD_ADMIN_PASSWORD admin

# Install additional dependencies or configurations (optional)
# RUN apt-get update && apt-get install -y some-package

# Expose the port that Nextcloud will run on
EXPOSE 9091

# Command to start Nextcloud
CMD ["apache2-foreground"]
