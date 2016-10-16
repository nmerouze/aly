import generateID from './generateID';

interface Config {
  url: string;
}

interface CallFunc {
  (params: Array<string>): void;
}

interface Aly {
  call: CallFunc;
}

const getSessionID = () => {
  let sessionID: string = document.cookie.replace(/(?:(?:^|.*;\s*)_aly\s*\=\s*([^;]*).*$)|^.*$/, "$1");
  if (sessionID === "") {
    sessionID = generateID();
    document.cookie = `_aly=${sessionID}`;
  }

  return sessionID;
}

const aly = (config: Config): Aly => {
  const call = (params: Array<string>): void => {
    params.push(`session_id=${getSessionID()}`);
    const httpRequest = new XMLHttpRequest();
    httpRequest.open("POST", `${config.url}/api/events`, true);
    httpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    httpRequest.send(params.join("&"));
  };

  return { call };
}

(<any>window).aly = aly;
