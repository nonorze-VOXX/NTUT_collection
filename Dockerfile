# Use the official SWI-Prolog image as the base image
FROM swipl:latest

# Set the working directory inside the container
WORKDIR /app

# Copy all files from the current directory to the container's working directory
COPY ./hw6 /app

# Set the default command to run SWI-Prolog
# CMD ["swipl", "-f", "word_freq.pl"]
CMD ["swipl", "-f", "fig12_3.pl", "hw6_test.pl"]