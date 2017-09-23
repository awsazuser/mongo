FROM mongo:latest
ADD mongosetup.sh /mongosetup.sh
RUN chmod u+x /mongosetup.sh
CMD ["mongod", "--replSet", "example"]