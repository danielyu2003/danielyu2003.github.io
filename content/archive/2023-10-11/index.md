+++
title = "An AWK-ward primer"
date = 2023-10-11
authors = ["Daniel Yu"]
[extra]
footer = ""
+++

My first blog post! If you're a fan of old languages, or if you just want to write fast scripts that can easily parse text files, then learning AWK might be for you.

<!-- more -->


<figure>
<img src="auks.jpg">
<figcaption>A pair of auks!</figcaption>
</figure>


I'll skip the history to let us get straight into the meat of learning the tool/language, although you should check out the [GNU AWK reference](https://www.gnu.org/software/gawk/manual/gawk.html) to learn more.

By default, some flavor of AWK is included on macOS and most Linux distributions. Windows users must build and install AWK manually: I recommend [GAWK for Windows](https://gnuwin32.sourceforge.net/packages/gawk.htm). Depending on which variant you have, there may be extra or missing features. I'll be covering the base language supported by all versions of AWK.

To start with, let's assume we have a CSV file called `names.csv` that we want to process in some way. It might contain a column of names as strings and a column of ages as integers, like such:

```
Andrew,22
Bob,34
Caroline,90
Daniel,59
```

Now, we want to print the result of a filter applied over each entry/row in the CSV through stdout. Let's say that we want to see the names of people who are at least 30 years old, in addition to the sum of their combined ages. Here's an example of what such a program, which we will name `foo.awk`, might look like (not to worry: I'll explain what each element means).

```awk
#!/usr/bin/awk -f
BEGIN {
	FS=","
	sum=0
	i=0
	min=50
}

$2 >= min {
	arr[i]=$1
	sum+=$2
	i++
}

END {
	for (ind in arr) {
		print arr[ind] " is at least " min
	}
	print sum 
}
```

To run our program with an input, we can just call `./foo.awk names.csv`, in addition to granting execution priviliges with `chmod +x foo.awk` if necessary. When an AWK program is run, it reads a file stream line by line. An AWK program is comprised of pattern-action pairs, represented in the form:


```awk
pattern1 { 
	action1
}
pattern2 { 
	action2
	action3
}
...
```


A pattern is essentially a condition that each line might satisfy. If a line happens to satisfy the pattern, then the actions which correspond to that pattern are executed sequentially. 

When we execute our program from a terminal, the first line `#!/usr/bin/awk -f` invokes the AWK program with the `-f` flag set. The -f flag indicates that we want AWK to interpret our source file as a program. If you happen to be familiar with bash scripts, you may recognize this as a shebang (#!) sequence. Note that the location of the awk program (`/usr/bin/awk`) may differ based on your operating system or where you installed it.

Our first pattern is designated by the reserved keyword `BEGIN`. All actions which correspond to the BEGIN pattern are executed at the start. This makes the BEGIN block an ideal place to initialize variables that we would like to use later! The `END` pattern is similar, but is applied at the end of the program respectively.

Although by default AWK seperates fields in a line using whitespace, we can change the delimiter by setting <code>FS</code> (the "field seperator") to a string we would like to use instead. In this case, we set FS to a comma since that's the default for a CSV file. We also define three variables <code>sum</code>, <code>i</code> and <code>min</code>, which hold numeric values. Note that in AWK, there are only two types: strings and numbers. AWK automatically interprets numeric fields as numbers.

Our second pattern, `$2 >= min`, is matched when the second field in each line (\$2) is greater than or equal to min (which we had set to 50). The fields in a line are represented by a dollar sign and a number. For example, the sixteenth field of a line is \$16, the first is \$1, and so on. AWK reserves the variable `NF` to the number of fields in the current line. In addition, \$0 is a special case that represents the entire line.

AWK arrays are associative, meaning that they behave like maps and dictionaries. Arrays not have to be initialized before being used. Arrays follow the same naming convention as other user-defined variables, and array elements can be accessed by using the [] operator as in C or C++.

In our block above, we push all of the names of people who are least 50 years old into the array and accumulate their ages into the sum variable. At the end, we use a for loop that iterates over each index in the array. In AWK, loops can be defined in three ways:


```awk
# for loop
for (initialization; condition; increment) {
	body
}

# while loop
while (condition) {
	body
}

# array for loop
for (i in array) {
	do something with array[i]
}
```


To send output to stdout, AWK has the `print` statement. In our example above, the inputs `arr[ind] " is at least " min` are all concatenated into a single string that ends up being printed. In addition, AWK also has the `printf` statement that allows for formatted printing similar to the C function printf. Using these print statements, it is possible to modify our input CSV by redirecting the output of our program back into the CSV (ex. <code>./foo.awk names.csv > names.csv</code>).

I hope this short primer has been useful to you! There's a ton of other features that AWK (and its variants) possess, but I just wanted to cover a common usecase and the basic fundamentals that allow you to get right into using it. For more information, check out the [man page for AWK](https://man7.org/linux/man-pages/man1/awk.1p.html) and the [GNU AWK manual](https://www.gnu.org/software/gawk/manual/gawk.html). It's been a pleasure to Code with Y{o}u!