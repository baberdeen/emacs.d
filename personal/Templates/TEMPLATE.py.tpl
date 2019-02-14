#!/usr/bin/python
"""

:date: (>>>DATE<<<) 
:author: (>>>USER_NAME<<<)

"""
from __future__ import print_function


if __name__ == "__main__" :

    import sys
    import doctest

    def run_doctest():
        """
        Run doctest on this module.

        >>> 1
        1
        """
        exit(0 if doctest.testmod(optionflags=doctest.IGNORE_EXCEPTION_DETAIL).failed == 0 else 1)

    def my_test():
        print("dont run me")
        exit(1)

    if len(sys.argv) == 2 and sys.argv[1] == "--doctest" : 
        run_doctest()
    else :
        my_test()

