"""
This is an example python code for Typst assognment tempalte.
"""

# import
import numpy as np

# func


def simple_fn(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    """This is a simple function that goes a+b -> c"""
    return a + b


# main

if __name__ == "__main__":
    a = np.asarray([1, 2, 3])
    b = np.asarray([2, 4, 6])
    simple_fn(a, b)
