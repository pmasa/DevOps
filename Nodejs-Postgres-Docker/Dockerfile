FROM node:6-slim
# Working directory for application
WORKDIR /usr/src/app
# Binds to port 7777
EXPOSE 7777
# Creates a mount point
VOLUME [ "/usr/src/app" ]
#CMD [ "npm", "start" ]
CMD ["./wait_for_it.sh", "postgres:5432", "--", "npm", "start"]