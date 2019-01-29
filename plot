#!/usr/bin/env python

import click
import matplotlib.pyplot as plt
import numpy as np

# customized graphical parameters
SMALL_SIZE = 12
MEDIUM_SIZE = 14
BIGGER_SIZE = 18
LINEWIDTH = 4
MARKERSIZE = 8

plt.rc('font', size=SMALL_SIZE)          # controls default text sizes
plt.rc('axes', titlesize=SMALL_SIZE)     # fontsize of the axes title
plt.rc('axes', labelsize=MEDIUM_SIZE)    # fontsize of the x and y labels
plt.rc('xtick', labelsize=SMALL_SIZE)    # fontsize of the tick labels
plt.rc('ytick', labelsize=SMALL_SIZE)    # fontsize of the tick labels
plt.rc('legend', fontsize=SMALL_SIZE)    # legend fontsize
plt.rc('figure', titlesize=BIGGER_SIZE)  # fontsize of the figure title
plt.rc('lines', linewidth=LINEWIDTH)     # default linewidth
plt.rc('lines', markersize=MARKERSIZE)   # default markersize

@click.command()
@click.argument('filename')
@click.option(
    '--labels/--no-labels', '-l',
    default = False,
    show_default = True,
    help = 'first line contains axis labels',
)
def main(filename, labels):

	'''
	Minimal plotting script.\n
	(c) Tomasz Skóra 2017\n
	contact: tskora@ichf.edu.pl
	'''

	data = np.genfromtxt(filename)

	plt.title(filename.split('.')[0])

	xs = data[:, 0]
	ys = [data[:, i] for i in range(1, len(data[0][:]))]

	label_strings = [str(i+1) for i in range(len(ys))]

	if labels:
		with open(filename, 'r') as file:
			label_strings = file.readline().split()
		plt.xlabel(label_strings[0])
		if len(ys) == 1:
			plt.ylabel(label_strings[1])

	for i in range(len(ys)):
		if len(ys) < 2:
			plt.plot(xs, ys[i], '-o')
		else:
			plt.plot(xs, ys[i], '-o', label = label_strings[i+1])
			plt.legend()
	
	plt.savefig(filename.split('.')[0]+'.eps')
	plt.close()



if __name__ == '__main__':
	main()
