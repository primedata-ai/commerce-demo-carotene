FROM golang:1.13

RUN git clone https://github.com/primedata-ai/commerce-demo-carotene.git /go/src/github.com/i-love-flamingo/commerce-demo-carotene
WORKDIR /go/src/github.com/i-love-flamingo/commerce-demo-carotene
RUN apt update -y && apt install unzip -y
RUN make download-product-data

# Prepare translation files:
RUN make translation
RUN apt install nodejs npm -y
RUN npm install -g npx
# Build the flamingo-carotene bases templates:
RUN make frontend-build
RUN make build
COPY ./scripts/demo-entrypoint.sh entrypoint.sh
RUN chmod a+x entrypoint.sh
CMD ["./entrypoint.sh"]