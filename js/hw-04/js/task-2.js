function calcAverageCalories(days) {
	let daysLength = days.length;
	let totalCalories = 0;

	if (daysLength == 0) {
		return 0;
	}

	for (const day of days) {
		totalCalories += day.calories;
	}

	return totalCalories / daysLength;
}

console.log(
	calcAverageCalories([
		{ day: 'monday', calories: 3010 },
		{ day: 'tuesday', calories: 3200 },
		{ day: 'wednesday', calories: 3120 },
		{ day: 'thursday', calories: 2900 },
		{ day: 'friday', calories: 3450 },
		{ day: 'saturday', calories: 3280 },
		{ day: 'sunday', calories: 3300 },
	])
);