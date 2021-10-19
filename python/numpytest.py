
import numpy as np
import matplotlib.pyplot as plt


class NumpyTest(object):
	@classmethod
	def scatter(self):
		N = 4
		x = np.random.randn(N)
		y = np.random.randn(N)
		print(x)
		print(y)
		plt.scatter(x, y, s = 4, c='r', marker='^', alpha=0.5)
		plt.show()




def main():
    NumpyTest.scatter()


if __name__ == '__main__':
    main()