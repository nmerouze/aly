/// <reference path="../../typings/index.d.ts" />
import { expect } from "chai";
import aly, { Header, Data } from "../src/aly";

const mockRequest = (method: string, url: string, headers: Array<Header>, params: Data) => {};

describe("aly", () => {
  it('sends a request to API', () => {
    const data = {
      event: "pageview",
      session_id: "abc123",
    };

    const request = (method: string, url: string, headers: Array<Header>, params: Data) => {
      expect(method).to.eq("POST");
      expect(url).to.eq("http://localhost/api/events");
      expect(headers).to.deep.equal([
        {
          key: "Content-Type",
          value: "application/x-www-form-urlencoded",
        },
      ]);
      expect(params).to.eq(data);
    };

    const tracker = aly({ url: "http://localhost", cookie: "", request });
    tracker.call(data);
  });

  it("parses session id from cookie", () => {
    let cookie = "_aly=abc123";
    const tracker = aly({ url: "http://localhost", cookie: cookie, request: mockRequest });
    expect(tracker.getSessionID()).to.eq("abc123");
  });

  it("generates a new session id and store in cookie", () => {
    let cookie = "";
    const tracker = aly({ url: "http://localhost", cookie: cookie, request: mockRequest });
    tracker.getSessionID();
    expect(tracker.config.cookie).to.match(/^_aly=(.{20})$/);
  });
});
