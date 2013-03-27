"use strict";

module.exports = {

	reporter: function (data) {

		var thereAreErrors = false,
			errors = {},
			output = "";

		data.forEach(function (r) {

			var fileName = r.file;

			if (typeof errors[fileName] === 'undefined') {
				thereAreErrors = true;
				errors[fileName] = 1;
			} else {
				errors[fileName] += 1;
			}

		});

		if (thereAreErrors) {

			var file,
				fileLength,
				bespokePaddingLength,
				bespokePaddingText,
				paddingChar = ".",
				padding = 10,
				longestFileNameLength = 0,
				totalFileErrors;

			for (file in errors) {
				fileLength = file.length;
				if (longestFileNameLength < fileLength) {
					longestFileNameLength = fileLength;
				}
			}

			padding += longestFileNameLength;

			for (file in errors) {

				fileLength = file.length;

				bespokePaddingLength = padding - fileLength;
				bespokePaddingText = " ";

				for (var i = 0; i < bespokePaddingLength; i++) {
					bespokePaddingText += paddingChar;
				}

				bespokePaddingText += " ";

				totalFileErrors = errors[file];
				output += file + bespokePaddingText + totalFileErrors + " error" + ((totalFileErrors == 1) ? "" : "s") + "\n";
			}

			process.stdout.write(output);

		}
	}
};
