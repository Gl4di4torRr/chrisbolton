FROM nginx:stable

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Install Node and NPM
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt install -y nodejs

# Create Directory for static content
RUN mkdir /var/www

# Create directories for certificate
RUN mkdir -p /etc/letsencrypt/live/thechrisbolton.com
RUN mkdir -p /etc/letsencrypt/archive

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Add static content
ADD index.html /var/www
ADD css /var/www/css
ADD img /var/www/img
ADD js /var/www/js
ADD less /var/www/less

# Add dependencies
ADD package.json /var/www

# Install dependencies
RUN npm install --prefix /var/www