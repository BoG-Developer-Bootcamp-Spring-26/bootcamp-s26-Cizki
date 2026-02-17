import axios from "axios";
import https from "https";
import moment from "moment";

// BACKUP DATA
const time1 = moment().add(1, "minutes").format("MM/DD/YYYY hh:mm:ss A");
const time2 = moment().add(10, "seconds").format("MM/DD/YYYY hh:mm:ss A");

const blue = {
  DESTINATION: "Hamilton E Holmes",
  DIRECTION: "W",
  EVENT_TIME: time1,
  LINE: "BLUE",
  NEXT_ARR: time1,
  STATION: "VINE CITY STATION",
  TRAIN_ID: "101206",
  WAITING_SECONDS: "0",
  WAITING_TIME: "1 min",
};

const gold = {
  DESTINATION: "Airport",
  DIRECTION: "S",
  EVENT_TIME: time2,
  LINE: "GOLD",
  NEXT_ARR: time2,
  STATION: "GARNETT STATION",
  TRAIN_ID: "302506",
  WAITING_SECONDS: "10",
  WAITING_TIME: "Boarding",
};

getRealTimeRailCoordinates();

export default async function getRealTimeRailCoordinates() {
  try {
    let requestSettings = {
      method: "get",
      url: "https://developerservices.itsmarta.com:18096/railrealtimearrivals?apiKey=aa09b111-e99b-4a7c-83f7-8cb6ce8857f7",
      httpsAgent: new https.Agent({
        rejectUnauthorized: false,
      }),
    };
    let res = await axios(requestSettings);

    if (JSON.stringify(res.data) == "{}") {
      res.data.RailArrivals = [];
      res.data.RailArrivals.push(blue);
      res.data.RailArrivals.push(gold);
    }

    return res.data.RailArrivals;
  } catch (error) {
    let res = {};
    res.data = {};
    res.data.RailArrivals = [];
    res.data.RailArrivals.push(blue);
    res.data.RailArrivals.push(gold);
    return res.data.RailArrivals;
  }

}
