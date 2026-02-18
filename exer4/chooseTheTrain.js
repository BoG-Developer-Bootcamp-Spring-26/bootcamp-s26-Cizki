import getRealTimeRailCoordinates from "./getRail.js";

/**
 * You are given an array of all Marta rail arrivals at the time you run this
 * function (it's possible that there are no rails currently running -- in
 * those cases, the function returns a preset array of objects).
 *
 * You don't need to know how this works as you will learn all about it in the
 * next lecture. For now, please know that this is the array from which you
 * will process the data to fit your needs
 */
const railArray = await getRealTimeRailCoordinates();

/**
 * Task 1: What are the keys in each element in railArray?
 *
 * We want to roughly know what we are working with, so we need to know all
 * the keys in the FIRST element of railArray (there's no need to check the
 * keys of other elements, as they'll all be the same)
 *
 * Create a function that takes railArray as an argument and return the keys
 * of the first element of railArray in the form of an array
 *
 * DO NOT USE the Object.keys() METHOD!
 * Example:
 * {
 *     name: "Casey",
 *     age: 10,
 *     breed: "Pomeranian",
 *     friendly: false
 * }
 * -->
 * ["name", "age", "breed", "friendly"]
 *
 *
 * DO NOT MODIFY railArray! You'll need it for later
 */
function getKeysToArr(arrivals){
  // TODO
  const firstElement = arrivals[0];
  var keysArray = [];
  for (const key in firstElement){
    keysArray.push(key);
  }
  return keysArray;
}

/**
 * Task 2: We want to know which train is coming in 1 mintue!
 *
 * Create a function that takes railArray as an argument
 * and return an array of arrivals that is coming in 1 minute
 *
 * Please use forEach for this task!
 *
 * Hint: you would want to look at the field WAITING_TIME: '1 min'
 *
 * DO NOT MODIFY railArray! You'll need it for later
 */
function getTrainComingIn1Minute(arrivals) {
// TODO
  var arrivalsArray = [];
  
  arrivals.forEach(function(train) {
    if (train.WAITING_TIME === "1 min") { 
      arrivalsArray.push(train);
    }
  });
  return arrivalsArray;
}

/**
 * Task 3: Marta wants to change all Blue Rail Lines to be Pink Rail Lines
 *
 * Create a function that takes railArray as an argument, filter all elements
 * in railArray that involves Blue Line, DEEP copy the filtered array into a
 * new array (meaning all elements in filtered array are deep copied), map the
 * Line in the copy array to be Pink, and return the resulting array
 *
 * Example:
 * {
 *      ...
 *      LINE: 'BLUE',
 *      ...
 * }
 *
 * will become
 *
 * {
 *      ...
 *      LINE: 'PINK',
 *      ...
 * }
 *
 * Hint: filter, map, and spread operator might be useful here
 *
 * railArray should not be modified after running this function!
 *
 */
function updateLineColor(arrivals) {
  // TODO
  var blueLineArrivals = [];
  for (i = 0; i<= arrivals.length-1; i++){
    if ("Blue line" in arrivals){
      blueLineArrivals.push(arrivals)
    }
  }

}

/*
  TESTS:
    You may want to run these one at a time to see the output. If you run them and the API call works,
    the output may vary as the real-time data changes, and may be very large, so running them one at a time
    may help you see the results better.
*/
// EXPECTED: ['DESTINATION', 'DIRECTION', 'EVENT_TIME', 'LINE', 'NEXT_ARR', 'STATION', 'TRAIN_ID', 'WAITING_SECONDS', 'WAITING_TIME']
console.log(getKeysToArr(railArray));

// EXPECTED: Array with only the train(s) that is/are coming in 1 minute, this can vary based on real-time data
console.log(getTrainComingIn1Minute(railArray));

// EXPECTED: Array with only the Blue Line trains, but with LINE changed to 'PINK', this can vary based on real-time data
console.log(updateLineColor(railArray));
// EXPECTED: true as the original railArray should not be modified
console.log(railArray.some((arrival) => arrival.LINE === "BLUE"));
