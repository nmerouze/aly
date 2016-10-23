import aly, { Header, Data } from "./aly";

interface Config {
  url: string;
}

const request = (method: string, url: string, headers: Array<Header>, params: Data) => {
  const httpRequest = new XMLHttpRequest();
  httpRequest.open(method, url, true);
  headers.forEach(header => {
    httpRequest.setRequestHeader(header.key, header.value);
  });
  httpRequest.send(`data=${btoa(JSON.stringify(params))}`);
};

const clientAly = (config: Config) => {
  return aly({ url: config.url, cookie: document.cookie, request });
};

(<any>window).aly = clientAly;
